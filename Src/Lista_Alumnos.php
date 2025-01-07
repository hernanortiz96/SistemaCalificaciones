<?php
session_start();
if ($_SESSION['ROL_ID'] != 2) {
    die("Acceso denegado"); 
}

$conn = new mysqli("localhost", "ortizher_administrador", "contrasenia123", "ortizher_Colegio");
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

$dni_docente = $_SESSION['DNIID'];

// Obtener el nombre del profesor
$sql_docente = "SELECT Apel_Doc, Nomb_Doc FROM docentes WHERE DNI_Doc = ?";
$stmt_docente = $conn->prepare($sql_docente);
$stmt_docente->bind_param("i", $dni_docente);
$stmt_docente->execute();
$stmt_docente->bind_result($apellido_docente, $nombre_docente);
$stmt_docente->fetch();
$stmt_docente->close();

// Consulta SQL para obtener estudiantes, materias y calificaciones por cuatrimestre
$sql = "
    SELECT estudiantes.DNI_Est, estudiantes.Apel_Est, estudiantes.Nomb_Est, curso.Curso_Desc, 
           materias.Materia_Desc, calificaciones.Cuatrimestre, calificaciones.Calificacion
    FROM estudiantes
    INNER JOIN materias ON estudiantes.Curso_ID = materias.Curso_ID AND materias.DNI_Doc = ?
    INNER JOIN curso ON estudiantes.Curso_ID = curso.Curso_ID
    LEFT JOIN calificaciones ON estudiantes.DNI_Est = calificaciones.DNI_Est 
        AND calificaciones.Materia_ID = materias.Materia_ID 
    ORDER BY curso.Curso_Desc, materias.Materia_Desc, estudiantes.Apel_Est, estudiantes.Nomb_Est, calificaciones.Cuatrimestre";

$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $dni_docente);
$stmt->execute();
$result = $stmt->get_result();

// Organizar los resultados en un array para mostrar en la tabla
$calificaciones = [];
while ($row = $result->fetch_assoc()) {
    $curso = $row['Curso_Desc'];
    $materia = $row['Materia_Desc'];
    $dni_est = $row['DNI_Est'];
    $nombre_completo = $row['Apel_Est'] . " " . $row['Nomb_Est'];
    $cuatrimestre = $row['Cuatrimestre'];
    $calificacion = $row['Calificacion'];
    
    // Guardar las calificaciones por curso, alumno, materia y cuatrimestre
    $calificaciones[$curso][$materia][$dni_est]['nombre'] = $nombre_completo;
    $calificaciones[$curso][$materia][$dni_est]['calificaciones'][$cuatrimestre] = $calificacion;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $curso = $_POST['curso'];
    foreach ($_POST['alumnos'] as $dni_est => $materias) {
        foreach ($materias as $materia => $cuatrimestres) {
            $cuatrimestre1 = $cuatrimestres['1'];
            $cuatrimestre2 = $cuatrimestres['2'];
            
            // Actualizar calificaciones en la base de datos
            $sql_update = "UPDATE calificaciones SET Calificacion = CASE Cuatrimestre 
                           WHEN 1 THEN ? 
                           WHEN 2 THEN ? 
                           END
                           WHERE DNI_Est = ? AND Materia_ID = (
                               SELECT Materia_ID FROM materias WHERE Materia_Desc = ? LIMIT 1
                           )";
            $stmt_update = $conn->prepare($sql_update);
            $stmt_update->bind_param("iiis", $cuatrimestre1, $cuatrimestre2, $dni_est, $materia);
            $stmt_update->execute();
        }
    }
    $stmt_update->close();

    // Recargar la página después de actualizar con el parámetro de éxito
    header("Location: " . $_SERVER['PHP_SELF'] . "?status=success");
    exit();
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de estudiantes por Materia</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="icon" type="image/x-icon" href="isft.ico">
</head>
<body>
<nav class="navbar" style="background-color: #1565c0;">
    <div class="container-fluid">
        <img src="logoisft.png" alt="Logo Colegio" style="height: 50px;">
        <span class="ms-3 text-white" style="font-size: 1.5rem;">Instituto Superior de Formacion Tecnica 232</span>
        <button onclick="location.href='Cerrar_Sesion.php'" class="btn btn-outline-light ms-auto">Cerrar sesión</button>
    </div>
</nav>
    <div class="container mt-5">
        <h2>Bienvenido, profesor <?php echo htmlspecialchars($nombre_docente) . " " . htmlspecialchars($apellido_docente); ?></h2>
        <h3 class="mt-4">Lista de estudiantes por Materia</h3>

        <?php foreach ($calificaciones as $curso => $materias): ?>
            <h4>Curso: <?php echo htmlspecialchars($curso); ?></h4>
            <form method="post" action="">
                <input type="hidden" name="curso" class="form-control form-control-lg" value="<?php echo htmlspecialchars($curso); ?>">
                <?php foreach ($materias as $materia => $estudiantes): ?>
                    <h5>Materia: <?php echo htmlspecialchars($materia); ?></h5>
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>DNI</th>
                                <th>Nombre</th>
                                <th>1er Cuatrimestre</th>
                                <th>2do Cuatrimestre</th>
                                <th>Promedio</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($estudiantes as $dni_est => $info_estudiante): ?>
                                <?php
                                // Calcular el promedio si ambos cuatrimestres están presentes
                                $calificacion1 = isset($info_estudiante['calificaciones'][1]) ? $info_estudiante['calificaciones'][1] : null;
                                $calificacion2 = isset($info_estudiante['calificaciones'][2]) ? $info_estudiante['calificaciones'][2] : null;
                                if ($calificacion1 !== null && $calificacion2 !== null) {
                                    $promedio = ($calificacion1 + $calificacion2) / 2;
                                } else {
                                    $promedio = "-";
                                }
                                ?>
                                <tr>
                                    <td><?php echo htmlspecialchars($dni_est); ?></td>
                                    <td><?php echo htmlspecialchars($info_estudiante['nombre']); ?></td>
                                    <td><input type="number" class="form-control form-control-lg" min="1" max="10" name="alumnos[<?php echo htmlspecialchars($dni_est); ?>][<?php echo htmlspecialchars($materia); ?>][1]" value="<?php echo $calificacion1 !== null ? htmlspecialchars($calificacion1) : ''; ?>"></td>
                                    <td><input type="number" class="form-control form-control-lg" min="1" max="10" name="alumnos[<?php echo htmlspecialchars($dni_est); ?>][<?php echo htmlspecialchars($materia); ?>][2]" value="<?php echo $calificacion2 !== null ? htmlspecialchars($calificacion2) : ''; ?>"></td>
                                    <td><?php echo is_numeric($promedio) ? number_format($promedio, 2) : $promedio; ?></td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                <?php endforeach; ?>
                <button type="submit" class="btn btn-outline-success">Actualizar Calificaciones del Curso</button>
            </form>
        <?php endforeach; ?>
    </div>
    
<?php
$stmt->close();
$conn->close();
?>
<footer style="background-color: #1565c0; color: white; padding: 10px; text-align: center; font-size: small; bottom: 0; width: 100%;">
    Hernan Rodolfo Ortiz - ISFT 232 - Sistema de gestión de calificaciones
</footer>

</body>
</html>
