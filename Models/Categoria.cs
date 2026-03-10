using System.ComponentModel.DataAnnotations;

namespace BibliotecaWeb.Models
{
    public class Categoria
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "El nombre de la categoría es obligatorio")]
        [StringLength(50, ErrorMessage = "El nombre no puede superar los 50 caracteres")]
        public string Nombre { get; set; }

        // Relación con Libros
        public virtual ICollection<Libro> Libros { get; set; }
    }

}
