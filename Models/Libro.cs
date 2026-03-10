using System.ComponentModel.DataAnnotations;

namespace BibliotecaWeb.Models
{
    public class Libro
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "El título es obligatorio")]
        [StringLength(250, ErrorMessage = "El título no puede superar los 250 caracteres")]
        public string Titulo { get; set; }

        [Range(1000, 2100, ErrorMessage = "El año de publicación debe estar entre 1000 y 2100")]
        public int? Publicacion { get; set; }

        [Required(ErrorMessage = "Debe seleccionar un autor")]
        public int IdAutor { get; set; }

        [Required(ErrorMessage = "Debe seleccionar una categoría")]
        public int IdCategoria { get; set; }

        // Relaciones
        public virtual Autor Autor { get; set; }
        public virtual Categoria Categoria { get; set; }
    }


}
