using System.ComponentModel.DataAnnotations;

namespace BibliotecaWeb.Models
{
    public class Autor
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "El nombre del autor es obligatorio")]
        [StringLength(100, ErrorMessage = "El nombre no puede superar los 100 caracteres")]
        public string Nombre { get; set; }

        [Required(ErrorMessage = "La nacionalidad es obligatoria")]
        [StringLength(80, ErrorMessage = "La nacionalidad no puede superar los 80 caracteres")]
        public string Nacionalidad { get; set; }

        [DataType(DataType.Date)]
        [Display(Name = "Fecha de Nacimiento")]
        public DateTime? FechaNacimiento { get; set; }

        // Relación con Libros
        public virtual ICollection<Libro> Libros { get; set; }
    }
}
