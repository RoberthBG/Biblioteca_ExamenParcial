using BibliotecaWeb.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.Data.SqlClient;

namespace BibliotecaWeb.Controllers
{
    public class LibrosController : Controller
    {
        private readonly string cadenaConexion = "server=localhost; database=Biblioteca; user id=sa; password=sqladmin; TrustServerCertificate=true";

        // Listar todos los libros
        public IActionResult Index()
        {
            var listaLibros = ObtenerLibros();
            return View(listaLibros);
        }

        // Mostrar formulario de creación
        public IActionResult Create()
        {
            var autores = ObtenerAutores();
            var categorias = ObtenerCategorias();

            ViewBag.Autores = new SelectList(autores, "Id", "Nombre");
            ViewBag.Categorias = new SelectList(categorias, "Id", "Nombre");

            return View(new Libro());
        }

        // Guardar nuevo libro
        [HttpPost]
        public IActionResult Create(Libro libro)
        {
            var exito = CrearLibro(libro);
            if (exito)
                return RedirectToAction("Index");

            // Si falla, recargamos combos
            ViewBag.Autores = new SelectList(ObtenerAutores(), "Id", "Nombre");
            ViewBag.Categorias = new SelectList(ObtenerCategorias(), "Id", "Nombre");
            return View(libro);
        }

        #region Métodos privados

        private List<Libro> ObtenerLibros()
        {
            var listaLibros = new List<Libro>();
            using (var conexion = new SqlConnection(cadenaConexion))
            {
                string sql = @"SELECT L.Id, L.Titulo, L.Publicacion, 
                                      A.Id AS IdAutor, A.Nombre AS NombreAutor,
                                      C.Id AS IdCategoria, C.Nombre AS NombreCategoria
                               FROM Libros L
                               INNER JOIN Autores A ON L.IdAutor = A.Id
                               INNER JOIN Categorias C ON L.IdCategoria = C.Id";

                using (var comando = new SqlCommand(sql, conexion))
                {
                    conexion.Open();
                    using (var lector = comando.ExecuteReader())
                    {
                        while (lector.Read())
                        {
                            listaLibros.Add(new Libro
                            {
                                Id = lector.GetInt32(0),
                                Titulo = lector.GetString(1),
                                Publicacion = lector.IsDBNull(2) ? null : lector.GetInt32(2),
                                IdAutor = lector.GetInt32(3),
                                Autor = new Autor { Id = lector.GetInt32(3), Nombre = lector.GetString(4) },
                                IdCategoria = lector.GetInt32(5),
                                Categoria = new Categoria { Id = lector.GetInt32(5), Nombre = lector.GetString(6) }
                            });
                        }
                    }
                }
            }
            return listaLibros;
        }

        private List<Autor> ObtenerAutores()
        {
            var listaAutores = new List<Autor>();
            using (var conexion = new SqlConnection(cadenaConexion))
            {
                using (var comando = new SqlCommand("SELECT Id, Nombre FROM Autores", conexion))
                {
                    conexion.Open();
                    using (var lector = comando.ExecuteReader())
                    {
                        while (lector.Read())
                        {
                            listaAutores.Add(new Autor
                            {
                                Id = lector.GetInt32(0),
                                Nombre = lector.GetString(1)
                            });
                        }
                    }
                }
            }
            return listaAutores;
        }

        private List<Categoria> ObtenerCategorias()
        {
            var listaCategorias = new List<Categoria>();
            using (var conexion = new SqlConnection(cadenaConexion))
            {
                using (var comando = new SqlCommand("SELECT Id, Nombre FROM Categorias", conexion))
                {
                    conexion.Open();
                    using (var lector = comando.ExecuteReader())
                    {
                        while (lector.Read())
                        {
                            listaCategorias.Add(new Categoria
                            {
                                Id = lector.GetInt32(0),
                                Nombre = lector.GetString(1)
                            });
                        }
                    }
                }
            }
            return listaCategorias;
        }

        private bool CrearLibro(Libro libro)
        {
            var exito = false;
            using (var conexion = new SqlConnection(cadenaConexion))
            {
                string sql = @"INSERT INTO Libros (Titulo, Publicacion, IdAutor, IdCategoria)
                               VALUES (@titulo, @publicacion, @idAutor, @idCategoria)";

                using (var comando = new SqlCommand(sql, conexion))
                {
                    comando.Parameters.AddWithValue("@titulo", libro.Titulo);
                    comando.Parameters.AddWithValue("@publicacion", (object)libro.Publicacion ?? DBNull.Value);
                    comando.Parameters.AddWithValue("@idAutor", libro.IdAutor);
                    comando.Parameters.AddWithValue("@idCategoria", libro.IdCategoria);

                    conexion.Open();
                    exito = comando.ExecuteNonQuery() > 0;
                }
            }
            return exito;
        }

        #endregion
    }
}
