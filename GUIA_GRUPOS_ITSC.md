# Grupos por gestión en el sistema ITSC

La versión 1.4 organiza la aplicación de XAMPP en institución, organización académica, evaluación y asistencia, caja, servicios estudiantiles y administración. Cada sección del menú se despliega por separado. Conserva los colores institucionales, el logotipo y el modo oscuro.

## Crear un grupo

1. Ingresar con un usuario ADMIN.
2. Abrir **Organización académica → Gestiones y períodos**. Crear, por ejemplo, `2027 anual`, con fecha inicial y final. También se pueden editar los períodos existentes.
3. Abrir **Grupos por gestión → Nuevo registro**.
4. Seleccionar la gestión y carrera. Completar curso, paralelo, turno y cupo; asignar opcionalmente un docente tutor y seleccionar ACTIVO.
5. Guardar. Ejemplo: gestión 2027 anual, Sistemas Informáticos, curso 1, paralelo A, mañana, cupo 30.

Un grupo queda identificado por gestión, carrera, curso, paralelo y turno. Se permite el mismo paralelo en otra gestión. No se permite duplicar esa combinación dentro de una misma gestión.

## Asignar estudiantes y materias

1. Crear la matrícula del estudiante con el plan, carrera y período correspondientes.
2. Abrir **Estudiantes por grupo** y asignar esa matrícula al grupo. El sistema verifica carrera, gestión, estado y cupo. Una matrícula pertenece a un solo grupo.
3. En **Ofertas y docentes**, crear las ofertas de materias del curso con la misma gestión, paralelo y turno del grupo, y el docente responsable de cada materia.
4. Abrir **Materias por grupo** para vincular esas ofertas al grupo. No admite materias de otra carrera o curso.
5. En **Inscripción a materias**, inscribir las matrículas del grupo a sus ofertas. Pertenecer al grupo no crea automáticamente las inscripciones.
6. Continuar con evaluaciones, calificaciones y asistencia por las pantallas correspondientes.

Los selectores de integrantes y ofertas se filtran al elegir el grupo. Los selectores largos incluyen un campo para buscar opciones. Las validaciones del servidor se mantienen aunque JavaScript esté desactivado.

## Consultar y mantener

- Filtrar grupos, integrantes y materias por gestión o grupo.
- Buscar en todos los registros del módulo; cada página muestra 50 filas.
- Editar cupo, tutor y estado del grupo. El cupo no puede quedar por debajo de sus integrantes.
- Si un grupo tiene asignaciones, no cambiar su gestión, carrera, curso, paralelo ni turno: crear otro grupo.
- Los grupos cerrados conservan su información y rechazan nuevas asignaciones. Se pueden reabrir editando su estado.
- Retirar integrantes o desvincular ofertas desde sus módulos. Las inscripciones activas impiden retirar relaciones necesarias.
- La gestión de grupos es administrativa. El rol DOCENTE mantiene acceso a sus propias ofertas y el rol CAJA a sus funciones de cobro.

## Instalación y datos

En este equipo la actualización ya está aplicada y se guardó un respaldo previo del código y de la base. No se distribuyen las credenciales del equipo.

Para una instalación nueva, importar la exportación completa en una base nueva, copiar `itsc/` a XAMPP y ejecutar `setup.php` por consola. El instalador incluye las tablas de grupos y configura el acceso de la aplicación.

La ampliación añade `grupos`, `grupo_integrantes` y `grupo_materias`: ahora hay 40 tablas y 3 vistas. Se conservan los 1.000 estudiantes, 80 docentes y 12 carreras del entorno de demostración. No se distribuyeron automáticamente esos estudiantes entre gestiones o grupos.

Las 4 carreras adicionales siguen marcadas como demostración; pueden no tener materias o planes cargados. Para matricular se necesita un plan de estudio y sus materias existentes. El diagrama UML anterior no incluye las tres tablas nuevas.

Esta versión continúa en PHP y MariaDB para XAMPP. La migración a NestJS, Next.js, PostgreSQL y ORM sigue pendiente. El práctico anterior describe la entrega inicial; esta guía documenta la ampliación.
