<?php
session_start();
if (!isset($_SESSION['ROL_ID']) || $_SESSION['ROL_ID'] != 3) {
    die("Acceso denegado");
}

$conn = new mysqli("localhost", "ortizher_administrador", "contrasenia123", "ortizher_Colegio");
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

// Consulta para obtener boletines
$sql = "
    SELECT estudiantes.Nomb_Est, estudiantes.Apel_Est, estudiantes.DNI_Est, 
           curso.Curso_Desc, especializacion.Espec_Desc, materias.Materia_Desc, 
           calificaciones.Cuatrimestre, calificaciones.Calificacion
    FROM calificaciones
    INNER JOIN estudiantes ON calificaciones.DNI_Est = estudiantes.DNI_Est
    INNER JOIN materias ON calificaciones.Materia_ID = materias.Materia_ID
    INNER JOIN curso ON calificaciones.Curso_ID = curso.Curso_ID
    INNER JOIN especializacion ON calificaciones.Espec_ID = especializacion.Espec_ID
    ORDER BY curso.Curso_Desc, especializacion.Espec_Desc, estudiantes.DNI_Est, materias.Materia_Desc, calificaciones.Cuatrimestre";

$result = $conn->query($sql);

// Agrupar boletines por curso y especialización
$boletines = [];
while ($row = $result->fetch_assoc()) {
    $curso = $row['Curso_Desc'];
    $especializacion = $row['Espec_Desc'];
    $dni = $row['DNI_Est'];
    $nombre = $row['Nomb_Est'];
    $apellido = $row['Apel_Est'];
    $materia = $row['Materia_Desc'];
    $cuatrimestre = $row['Cuatrimestre'];
    $calificacion = $row['Calificacion'];

    // Agrupar por curso y especialización
    $boletines[$curso][$especializacion][$dni]['nombre'] = $nombre;
    $boletines[$curso][$especializacion][$dni]['apellido'] = $apellido;
    $boletines[$curso][$especializacion][$dni]['calificaciones'][$materia][$cuatrimestre] = $calificacion;
}

// Calcular promedio por materia
foreach ($boletines as $curso => &$especializaciones) {
    foreach ($especializaciones as $especializacion => &$estudiantes) {
        foreach ($estudiantes as &$boletin) {
            foreach ($boletin['calificaciones'] as $materia => &$cuatrimestres) {
                $calificacion1 = isset($cuatrimestres[1]) ? $cuatrimestres[1] : null;
                $calificacion2 = isset($cuatrimestres[2]) ? $cuatrimestres[2] : null;

                if ($calificacion1 !== null && $calificacion2 !== null) {
                    $promedio = ($calificacion1 + $calificacion2) / 2;
                } else {
                    $promedio = null;
                }

                $cuatrimestres['promedio'] = $promedio;
            }
        }
    }
}
$conn->close();
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Boletines de Alumnos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="icon" type="image/x-icon" href="isft.ico">
    <style>
        body {
            text-align: center;
        }
        .container {
            max-width: 800px;
            margin: auto;
        }
        .boletin {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 15px;
            margin: 15px auto;
            text-align: center;
            display: inline-block;
            width: 100%;
            background-color: #f9f9f9;
        }
        .tabla-boletines {
            margin: 15px auto;
            border-collapse: collapse;
            width: 100%;
        }
        .tabla-boletines th, .tabla-boletines td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }
        .tabla-boletines th {
            background-color: #f2f2f2;
        }
        h1, h2, h3, h4 {
            margin: 10px 0;
        }

        /* Estilos para impresión */
        @media print {
            body {
                text-align: left;
            }
            .boletin {
                page-break-inside: avoid;
                margin-bottom: 20px;
            }
            .boletin:nth-of-type(2n) {
                page-break-after: always;
            }
            .navbar, .btn, .footer, button {
                display: none; /* Ocultar navegación y botones durante la impresión */
            }
        }
    </style>
    <script>
        function printBoletin(dni) {
            const boletin = document.getElementById(`boletin-${dni}`);
            const originalContent = document.body.innerHTML;
            document.body.innerHTML = boletin.outerHTML;
            window.print();
            document.body.innerHTML = originalContent;
        }

        function printAllBoletines() {
            window.print();
        }
    </script>
</head>
<body>
<nav class="navbar" style="background-color: #1565c0;">
    <div class="container-fluid">
        <img src="logoisft.png" alt="Logo Colegio" style="height: 50px;">
        <span class="ms-3 text-white" style="font-size: 1.5rem;">Instituto Superior de Formacion Tecnica 232</span>
        <button onclick="location.href='Cerrar_Sesion.php'" class="btn btn-outline-light ms-auto">Cerrar sesión</button>
    </div>
</nav>

<div class="container">
    <h1>Boletines de Todos los Alumnos</h1>
    <button class="btn btn-outline-success" onclick="printAllBoletines()">Imprimir todos los boletines</button>

    <?php foreach ($boletines as $curso => $especializaciones): ?>
        <h2>Curso: <?php echo htmlspecialchars($curso); ?></h2>
        <?php foreach ($especializaciones as $especializacion => $estudiantes): ?>
            <h3>Especialización: <?php echo htmlspecialchars($especializacion); ?></h3>
            <?php foreach ($estudiantes as $dni => $boletin): ?>
                <div class="boletin" id="boletin-<?php echo $dni; ?>">
                    <h4>Boletín de <?php echo htmlspecialchars($boletin['nombre']) . ' ' . htmlspecialchars($boletin['apellido']); ?></h4>
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
                            <?php foreach ($boletin['calificaciones'] as $materia => $notas): ?>
                                <tr>
                                    <td><?php echo htmlspecialchars($materia); ?></td>
                                    <td><?php echo isset($notas[1]) ? $notas[1] : '-'; ?></td>
                                    <td><?php echo isset($notas[2]) ? $notas[2] : '-'; ?></td>
                                    <td><?php echo isset($notas['promedio']) ? number_format($notas['promedio'], 2) : '-'; ?></td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                    <button class="btn btn-outline-success mt-2" onclick="printBoletin(<?php echo $dni; ?>)">Imprimir boletín</button>
                </div>
            <?php endforeach; ?>
        <?php endforeach; ?>
    <?php endforeach; ?>
</div>
<footer style="background-color: #1565c0; color: white; padding: 10px; text-align: center; font-size: small; bottom: 0; width: 100%;">
    Hernan Rodolfo Ortiz - ISFT 232 - Sistema de gestión de calificaciones
</footer>
</body>
</html>
