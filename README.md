# Sistema académico ITSC con 1000 estudiantes

Estudiante: Vicente Apaza Bautista. Docente: Ing. Lozano Barro Jorge Robbert.

## Entrega

- [Proyecto completo y código fuente para XAMPP](Proyecto_ITSC_1000_Completo.zip).
- [Base de datos completa](Base_de_datos_ITSC.sql).
- [Práctico](Practico_ITSC.docx).
- [Diagrama HTML](Diagrama_de_Clases_ITSC.html): descargar y abrir en Chrome.

La base contiene **1.000 estudiantes, 80 docentes y 12 carreras**, con datos ficticios. Cuatro carreras están marcadas como demostración. Incluye 37 tablas y tres vistas.

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
