<?php
session_start();
if (!isset($_SESSION['ROL_ID']) || $_SESSION['ROL_ID'] != 1) {
    die("Acceso denegado");
}

$conn = new mysqli("localhost", "ortizher_administrador", "contrasenia123", "ortizher_Colegio");
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

$dni_estudiante = $_SESSION['DNIID'];

// Consulta para obtener el nombre y apellido del estudiante
$sql_estudiante = "SELECT Nomb_Est, Apel_Est FROM estudiantes WHERE DNI_Est = ?";
$stmt_estudiante = $conn->prepare($sql_estudiante);
$stmt_estudiante->bind_param("i", $dni_estudiante);
$stmt_estudiante->execute();
$stmt_estudiante->bind_result($nombre_estudiante, $apellido_estudiante);
$stmt_estudiante->fetch();
$stmt_estudiante->close();

// Consulta para obtener las materias, calificaciones, curso y especialización del estudiante
$sql = "
    SELECT materias.Materia_Desc, calificaciones.Cuatrimestre, calificaciones.Calificacion, 
           curso.Curso_Desc, especializacion.Espec_Desc
    FROM calificaciones
    INNER JOIN materias ON calificaciones.Materia_ID = materias.Materia_ID
    INNER JOIN curso ON calificaciones.Curso_ID = curso.Curso_ID
    INNER JOIN especializacion ON calificaciones.Espec_ID = especializacion.Espec_ID
    WHERE calificaciones.DNI_Est = ?
    ORDER BY materias.Materia_Desc, calificaciones.Cuatrimestre";

$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $dni_estudiante);
$stmt->execute();
$result = $stmt->get_result();

// Organizar los resultados en un array
$calificaciones = [];
$curso = '';
$especializacion = '';
while ($row = $result->fetch_assoc()) {
    $materia = $row['Materia_Desc'];
    $cuatrimestre = $row['Cuatrimestre'];
    $calificacion = $row['Calificacion'];
    $curso = $row['Curso_Desc'];
    $especializacion = $row['Espec_Desc'];

    // Guardar la calificación por materia y cuatrimestre
    $calificaciones[$materia][$cuatrimestre] = $calificacion;
}

// Cerrar la consulta y la conexión
$stmt->close();
$conn->close();

// Calcular el promedio para cada materia y preparar la estructura para la tabla
foreach ($calificaciones as $materia => &$cuatrimestres) {
    $calificacion1 = isset($cuatrimestres[1]) ? $cuatrimestres[1] : null;
    $calificacion2 = isset($cuatrimestres[2]) ? $cuatrimestres[2] : null;
    
    if ($calificacion1 !== null && $calificacion2 !== null) {
        $promedio = ($calificacion1 + $calificacion2) / 2;
    } else {
        $promedio = null; // Si falta una calificación, no hay promedio
    }

    $cuatrimestres['promedio'] = $promedio;
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="Css/Alumnos.css">
    <link rel="icon" type="image/x-icon" href="isft.ico">
    <title>Calificaciones</title>
    <style>
        /* Estilo para ocultar elementos al imprimir */
        @media print {
            body * {
                visibility: hidden; /* Oculta todos los elementos */
            }
            .print-area, .print-area * {
                visibility: visible; /* Muestra únicamente el área de impresión */
            }
            .print-area {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
            }
        }
    </style>
</head>
<body>
<nav class="navbar" style="background-color: #1565c0;">
    <div class="container-fluid">
        <img src="logoisft.png" alt="Logo Colegio" style="height: 50px;">
        <span class="ms-3 text-white" style="font-size: 1.5rem;">Instituto Superior de Formacion Tecnica 232</span>
        <button onclick="location.href='Cerrar_Sesion.php'" class="btn btn-outline-light ms-auto">Cerrar sesión</button>
    </div>
</nav>
<div class="container mt-4">
    <h2>Calificaciones de <?php echo htmlspecialchars($nombre_estudiante) . ' ' . htmlspecialchars($apellido_estudiante); ?></h2>
    <h4>Curso: <?php echo htmlspecialchars($curso); ?> | Especialización: <?php echo htmlspecialchars($especializacion); ?></h4>

    <!-- Área que queremos imprimir -->
    <div class="print-area">
        <table class="tabla-boletines">
            <thead>
                <tr>
                    <th>Materia</th>
                    <th>1er Cuatrimestre</th>
                    <th>2do Cuatrimestre</th>
                    <th>Promedio</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($calificaciones as $materia => $notas): ?>
                    <tr>
                        <td><?php echo htmlspecialchars($materia); ?></td>
                        <td><?php echo isset($notas[1]) ? $notas[1] : '-'; ?></td>
                        <td><?php echo isset($notas[2]) ? $notas[2] : '-'; ?></td>
                        <td><?php echo isset($notas['promedio']) ? number_format($notas['promedio'], 2) : '-'; ?></td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>
    <!-- Botón para imprimir -->
    <div class="text-center mt-4">
        <button class="btn btn-outline-success" onclick="imprimirBoletin()" class="btn btn-primary">Imprimir Boletín</button>
    </div>
</div>

<footer style="background-color: #1565c0; color: white; padding: 10px; text-align: center; font-size: small; position: fixed; bottom: 0; width: 100%;">
    Hernan Rodolfo Ortiz - ISFT 232 - Sistema de gestión de calificaciones
</footer>

<script>
    function imprimirBoletin() {
        window.print();
    }
</script>

<style>
    .tabla-boletines {
        border-collapse: collapse;
        width: 100%;
        margin-top: 20px;
        font-family: Arial, sans-serif;
    }

    .tabla-boletines th, .tabla-boletines td {
        padding: 10px;
        border: 1px solid #ddd;
        text-align: center;
    }

    .tabla-boletines th {
        background-color: #f2f2f2;
        font-weight: bold;
    }
</style>

</body>
</html>
