# Trabajo por grupos en ITSC versión 1.5

Esta versión funciona en XAMPP con PHP y MariaDB. Incorpora inscripción de varios estudiantes, horarios, planillas, reportes y un panel por gestión. Conserva los 1.000 estudiantes, 80 docentes y cuatro grupos de ejemplo.

## 1 Inscripción por grupo

En **Organización académica → Inscripción por grupo**, seleccionar un grupo y su plan de estudios. Buscar estudiantes y marcar sus casillas. El botón **Seleccionar según cupo disponible** marca explícitamente los casos disponibles de la página; no incorpora estudiantes hasta guardar.

Completar la fecha y guardar el lote. Se crean únicamente las matrículas e integrantes que faltan. Volver a enviar los mismos estudiantes no duplica registros. Se procesan hasta 100 estudiantes por operación, con 50 candidatos por página.

Para inscribir también las materias, vincular primero las ofertas en **Materias por grupo** y activar la opción correspondiente al guardar el lote. Se comprueban plan, prerrequisitos, cupos, carrera, gestión y estado. Si un caso no cumple, no se guarda ninguna parte del lote. Una matrícula que ya pertenece a otro grupo no se traslada automáticamente.

Los cuatro grupos de ejemplo están disponibles para trabajar; no se distribuyeron automáticamente los mil estudiantes entre ellos.

## 2 Horarios y aulas

En **Organización académica → Horarios y aulas**, elegir oferta, aula, día y horas de inicio y fin. Se puede crear, editar y retirar el horario.

El sistema rechaza intervalos que se superpongan para el mismo docente, aula, grupo u oferta. Comprueba también períodos distintos cuyas fechas coincidan. Los intervalos contiguos sí están permitidos. La capacidad del aula debe cubrir el cupo de la oferta.

Una oferta ya programada no puede vincularse a un grupo si introduce un cruce. No se cambian fechas de una gestión con horarios hasta retirarlos. Los docentes pueden consultar únicamente horarios de sus propias ofertas; administración los modifica.

Los paralelos admiten hasta 10 letras, números o guiones, tanto en grupos como en ofertas.

## 3 Notas y asistencia en lista

Abrir **Evaluación y asistencia → Planilla de notas** o **Planilla de asistencia**.

1. Elegir grupo y cargar sus materias.
2. Elegir materia y cargar las evaluaciones o sesiones disponibles.
3. Seleccionar la evaluación o sesión y abrir la lista.
4. Completar los valores y guardar la planilla.

Las evaluaciones se crean desde **Evaluaciones** y las sesiones desde **Sesiones de clase**. La lista contiene estudiantes del grupo inscritos en esa oferta y con matrícula activa.

Las notas admiten de 1 a 100 con hasta dos decimales. La asistencia se registra en minutos enteros, entre cero y la duración de la sesión. Los botones de presentes y ausentes solo completan la página; es necesario guardar. Un campo vacío conserva el valor previo y no equivale a cero.

Se procesan hasta 200 filas por página y guardado. Un valor inválido rechaza el guardado completo. Las ofertas o grupos cerrados permiten consultar, pero no guardar. El docente solo accede a sus propias materias.

## 4 Reportes PDF y Excel

En **Servicios estudiantiles → Reportes PDF y Excel**, seleccionar el tipo de reporte, gestión y, opcionalmente, grupo.

- **Estudiantes por grupo:** listas de integrantes.
- **Boletín de resultados:** resultados calculados mediante el cierre académico.
- **Cargos pagos y saldos:** situación de los cargos por matrícula.

Los botones descargan PDF y XLSX reales. El PDF admite múltiples páginas y el Excel conserva datos numéricos y texto sin convertirlo en fórmulas. La pantalla también permite revisar los resultados antes de descargarlos.

ADMIN accede a los tres reportes; DOCENTE a listas y resultados de sus materias; CAJA a los reportes financieros. Si no existen resultados cerrados en el grupo o la gestión, el boletín queda vacío hasta completar el cierre y calcular los resultados.

## 5 Panel por gestión

En **Panel institucional**, elegir una gestión y actualizar. Los indicadores muestran estudiantes con matrícula activa, grupos, ofertas y materias aprobadas de ese período. No se confunden los mil registros del catálogo con estudiantes efectivamente matriculados.

Administración y caja ven cargos, importes cobrados y saldos vinculados a las matrículas de la gestión. El criterio es la gestión de la matrícula, independientemente de la fecha de cobro. El docente ve los indicadores de sus ofertas y no los importes de caja.

## Instalación y respaldo

En este equipo la versión está instalada en `C:\xampp\htdocs\itsc`. Se guardó un respaldo previo. Se mantienen las credenciales existentes.

Para otro equipo: importar la base completa en una instalación nueva sin datos previos, copiar `itsc/` a XAMPP y ejecutar `setup.php` por consola. El instalador genera un acceso propio y configura los permisos específicos de la aplicación. No se distribuyen credenciales ni hashes de acceso del equipo original.

El práctico y el UML anteriores describen la entrega inicial. Esta guía documenta las funciones nuevas. Las carreras adicionales de demostración siguen requiriendo planes y materias antes de poder matricular estudiantes en ellas.
