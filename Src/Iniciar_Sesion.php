<?php
session_start();

$conn = new mysqli("localhost", "ortizher_administrador", "contrasenia123", "ortizher_Colegio");
if ($conn->connect_error) {
    die("Conexión Fallida: " . $conn->connect_error);
}

if (isset($_POST['User']) && isset($_POST['Password'])) {
    $User = $conn->real_escape_string($_POST['User']);
    $Password = $conn->real_escape_string($_POST['Password']);

    // Preparar la consulta SQL
    $stmt = $conn->prepare("SELECT User_ID, contrasenia, Rol_ID, DNI FROM users WHERE User_ID = ? AND contrasenia = ?");
    $stmt->bind_param("ss", $User, $Password);
    $stmt->execute();
    $stmt->store_result();

    // Verificar si se encontró el usuario
    if ($stmt->num_rows > 0) {
        // Obtener resultados
        $stmt->bind_result($V_Us, $V_Pass, $Rol_ID, $V_DNI);
        $stmt->fetch();

        // Guardar datos en sesión
        $_SESSION['IDUSUARIO'] = $V_Us;
        $_SESSION['IDPASSWORD'] = $V_Pass;
        $_SESSION['ROL_ID'] = $Rol_ID;
        $_SESSION['DNIID'] = $V_DNI; 
        
        // Redirigir según el rol
        if ($Rol_ID == 1) {
            header("Location: Calificaciones_alumno.php"); 
            exit();
        } elseif ($Rol_ID == 2) {
            header("Location: Lista_Alumnos.php"); 
            exit();
        } elseif ($Rol_ID == 3) {
            header("Location: Directivos.php");
            exit();
        }
    } else {
        echo "Usuario o contraseña incorrectos";
    }

    $stmt->close();
} else {
    echo "Por favor ingresa el usuario y la contraseña.<br>";
}

$conn->close();
?>
