<?php
// Incluir el archivo conex.php
include 'conex.php';

// Array con los nombres de las carreras
$nombresCarreras = array(
    "talentoHumano" => "Gestión del Talento Humano",
    "mkDigitalRedes" => "Marketing Digital y Redes Sociales",
    "mecatroAutomotriz" => "Mecatrónica Automotriz",
    "automatizacionInstru" => "Automatización Instrumentación",
    "logiAduanero" => "Gestión Logística y Procesos Aduaneros",
    "software" => "Desarrollo de Software",
    "mecanicaAutomotriz" => "Mecánica Automotriz",
    "enfermeria" => "Enfermería",
    "marketing" => "Marketing",
    "tributacion" => "Tributación",
    "comexExter" => "Comercio Exterior",
    "gastronomia" => "Gastronomía",
    "electromecanica" => "Electromecánica",
    "turismo" => "Turismo",
    "administracion" => "Administración",
    "dietetica" => "Dietética",
    "hoteleria" => "Hotelería y Turismo"
);

// Consulta SQL para obtener el total de tesis
$sqlTotalTesis = 'SELECT COUNT(*) AS total FROM tesis';
$resultadoTotalTesis = mysqli_query($conexion, $sqlTotalTesis);
$rowTotalTesis = mysqli_fetch_assoc($resultadoTotalTesis);
$totalTesis = $rowTotalTesis['total'];

// Crear un array vacío para almacenar los datos de las carreras y sus tesis
$carreras = array();

// Llenar el array con los datos de las carreras y sus tesis
foreach ($nombresCarreras as $categoria => $nombreCarrera) {
    $sqlTesisCarrera = "SELECT COUNT(*) AS total FROM tesis WHERE categoria = '$categoria'";
    $resultadoTesisCarrera = mysqli_query($conexion, $sqlTesisCarrera);
    $rowTesisCarrera = mysqli_fetch_assoc($resultadoTesisCarrera);
    $totalTesisCarrera = $rowTesisCarrera['total'];

    $carreras[$categoria] = $totalTesisCarrera;
}

// Mostrar las carreras y sus tesis
foreach ($nombresCarreras as $categoria => $nombreCarrera) {
    $totalTesisCarrera = isset($carreras[$categoria]) ? $carreras[$categoria] : 0;
?>
    <div class="col-md-4">
        <h3><?php echo $nombreCarrera; ?></h3>
        <p><?php echo $totalTesisCarrera; ?> tesis</p>
    </div>
<?php } ?>

<!-- Cerrar la conexión a la base de datos -->
<?php mysqli_close($conexion); ?>