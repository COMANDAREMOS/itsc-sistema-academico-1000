# Sistema académico ITSC con 1000 estudiantes

Estudiante: Vicente Apaza Bautista. Docente: Ing. Lozano Barro Jorge Robbert.

## Entrega

- [Proyecto completo y código fuente para XAMPP](Proyecto_ITSC_1000_Completo.zip).
- [Base de datos completa](Base_de_datos_ITSC.sql).
- [Práctico](Practico_ITSC.docx).
- [Diagrama HTML](Diagrama_de_Clases_ITSC.html): descargar y abrir en Chrome.

La base contiene **1.000 estudiantes, 80 docentes y 12 carreras**, con datos ficticios. Cuatro carreras están marcadas como demostración. Incluye 40 tablas y tres vistas.

## Instalación

1. Descargar y extraer el ZIP.
2. Iniciar Apache y MySQL en XAMPP.
3. Importar `database/Base_de_datos_ITSC.sql` en una instalación nueva, sin datos previos.
4. Copiar `itsc` a `C:\xampp\htdocs\itsc`.
5. Ejecutar `C:\xampp\php\php.exe C:\xampp\htdocs\itsc\setup.php` en consola.
6. Guardar el acceso generado y abrir http://localhost/itsc/.

El ZIP incluye las instrucciones completas, las capturas y el diagrama editable. Las contraseñas, hashes de acceso y configuración local no se publican. Cada instalación genera su propio acceso.

Esta entrega usa PHP y MariaDB. La migración a NestJS, Next.js y PostgreSQL todavía no está implementada. El práctico conserva el enlace al repositorio original.

Proyecto de práctica; no es un sistema oficial del instituto.

## Organización institucional y grupos versión 1.4

La entrega ahora incluye grupos por gestión, carrera, curso, paralelo y turno; asignación de matrículas y ofertas de materias; tutor, cupo y estado. El menú separa organización, evaluación, caja y administración. Incluye búsqueda en todos los registros y páginas de 50 filas.

- [Guía para crear y gestionar grupos](GUIA_GRUPOS_ITSC.md).
- [Resultado de las 62 verificaciones locales](PRUEBAS_GRUPOS_ITSC.txt).

El práctico y diagrama anteriores corresponden a la entrega inicial; las tablas y funciones nuevas se documentan en la guía. Se conserva el alcance PHP y MariaDB para XAMPP.

## Operación por grupos versión 1.5

- Inscripción de varios estudiantes a un grupo, con matrícula e inscripción opcional a materias y sin duplicados.
- Horarios con controles de cruces de grupo, docente y aula.
- Planillas de notas y asistencia por grupo y materia.
- Reportes descargables PDF y Excel XLSX con permisos por rol.
- Panel institucional filtrado por gestión.

[Guía de uso de la versión 1.5](GUIA_OPERACION_ITSC_V15.md) · [168 comprobaciones locales correctas](PRUEBAS_FUNCIONALES_ITSC_V15.txt).

La actualización está incluida en el ZIP y el SQL completo. Se conservaron los cuatro grupos de ejemplo y los 1.000 estudiantes. Los estudiantes se asignan mediante selección explícita, no automáticamente. El práctico y UML iniciales se complementan con esta guía.
