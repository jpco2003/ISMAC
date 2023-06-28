<?php
include 'conex.php';

// Consulta SQL para obtener los valores de tesis por carrera
$sql = "SELECT categoria, COUNT(*) as total FROM tesis GROUP BY categoria";
$result = mysqli_query($conex, $sql);

// Crear un array para almacenar los resultados
$tesisPorCarrera = array();

// Comprobar si se obtuvieron resultados
if (mysqli_num_rows($result) > 0) {
    while ($row = mysqli_fetch_assoc($result)) {
        $tesisPorCarrera[$row["categoria"]] = $row["total"];
    }
}

// Crear un array con todas las carreras
$carreras = array(
    "Gestión del Talento Humano",
    "Marketing Digital y Redes Sociales",
    "Mecatrónica Automotriz",
    "Automatización Instrumentación",
    "Gestión Logística y Procesos Aduaneros",
    "Desarrollo de Software",
    "Mecánica Automotriz",
    "Enfermería",
    "Tributación",
    "Comercio Exterior",
    "Gastronomía"
    // Agrega aquí todas las carreras restantes
);

// Generar el código HTML
$html = '<div class="full-box text-center" style="padding: 30px 10px;">';
foreach ($carreras as $carrera) {
    $total = isset($tesisPorCarrera[$carrera]) ? $tesisPorCarrera[$carrera] : 0;
    $html .= '<article class="full-box tile">';
    $html .= '<div class="full-box tile-title text-center text-titles text-uppercase">';
    $html .= $carrera;
    $html .= '</div>';
    $html .= '<div class="full-box tile-icon text-center">';
    $html .= '<i class="zmdi zmdi-account"></i>';
    $html .= '</div>';
    $html .= '<div class="full-box tile-number text-titles">';
    $html .= '<p class="full-box">' . $total . '</p>';
    $html .= '<small>EXISTENTES</small>';
    $html .= '</div>';
    $html .= '</article>';
}
$html .= '</div>';

// Cerrar la conexión a la base de datos
mysqli_close($conex);

// Cargar el contenido HTML en el archivo home.html
$file = 'home.html';
$current = file_get_contents($file);
$current = preg_replace('/<!--\s*INSERTAR_CODIGO_PHP_AQUI\s*-->/', $html, $current);
file_put_contents($file, $current);

echo "El archivo home.html se actualizó correctamente con los datos de las tesis.";

?>
