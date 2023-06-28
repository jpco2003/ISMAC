<?php
// Incluir el archivo conex.php que contiene la conexión a la base de datos
include 'php/conex.php';

// Consulta SQL para obtener el número de tesis existentes para la categoría 'desarrolloSoftware'
$sqlTesisCarrera = "SELECT COUNT(*) AS total FROM tesis WHERE categoria = 'desarrolloSoftware'";
$resultadoTesisCarrera = mysqli_query($conex, $sqlTesisCarrera);

if ($resultadoTesisCarrera) {
  $rowTesisCarrera = mysqli_fetch_assoc($resultadoTesisCarrera);
  $totalTesisCarrera = $rowTesisCarrera['total'];

  // Mostrar el número de tesis
  echo $totalTesisCarrera;
} else {
  echo 'Error al obtener el número de tesis';
}

// Cerrar la conexión a la base de datos
mysqli_close($conex);
?>
