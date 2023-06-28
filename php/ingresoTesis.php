<?php
include 'conex.php';

$titulo = $_POST['titulo_tesis'];
$autores = $_POST['autores'];
$anio = $_POST['anio'];
$categoria = $_POST['categoria'];
$resumen = $_POST['resumen'];

// Verificar si se proporcionó el archivo PDF
if (isset($_FILES['pdf']) && !empty($_FILES['pdf']['name'])) {
    $pdfFile = $_FILES['pdf'];
    $pdfName = $pdfFile['name'];
    $pdfTmpName = $pdfFile['tmp_name'];

    // Directorio padre para guardar los archivos
    $parentDir = 'archivos/';

    // Directorio para guardar los archivos PDF
    $tesisDir = $parentDir . 'tesis/';

    // Crear directorio 'archivos' si no existe
    if (!is_dir($parentDir)) {
        mkdir($parentDir, 0755, true);
    }

    // Crear directorio 'tesis' dentro de 'archivos' si no existe
    if (!is_dir($tesisDir)) {
        mkdir($tesisDir, 0755, true);
    }

    // Generar nombre único para el archivo PDF usando el título de la tesis
    $pdfUniqueName = sanitizeFileName($titulo) . '_' . uniqid();

    // Ruta completa del archivo PDF sin extensión
    $pdfPath = $tesisDir . $pdfUniqueName . '.pdf';

    // Mover el archivo PDF a la carpeta de tesis con el nombre único
    move_uploaded_file($pdfTmpName, $pdfPath);
} else {
    // Manejar el caso cuando no se proporciona el archivo PDF
    echo '
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.4/dist/sweetalert2.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.4/dist/sweetalert2.min.css">
    <script>
    Swal.fire({
        title: "Falta el PDF de tu Tesis",
        text: "Vuelve a intentarlo",
        icon: "question"
    }).then(() => {
        history.back();
    });
</script>
';
    // Puedes mostrar un mensaje de error o redirigir al formulario nuevamente
    exit();
}

// Verificar si se proporcionó la imagen de portada
if (isset($_FILES['imagen']) && !empty($_FILES['imagen']['name'])) {
    $portadaFile = $_FILES['imagen'];
    $portadaName = $portadaFile['name'];
    $portadaTmpName = $portadaFile['tmp_name'];

    // Directorio para guardar las imágenes de portada
    $portadaDir = $parentDir . 'portadas/';

    // Crear directorio 'portadas' dentro de 'archivos' si no existe
    if (!is_dir($portadaDir)) {
        mkdir($portadaDir, 0755, true);
    }

    // Generar nombre único para la imagen de portada usando el título de la tesis
    $portadaUniqueName = sanitizeFileName($titulo) . '_' . uniqid();

    // Obtener la extensión de la imagen de portada
    $portadaExtension = pathinfo($portadaName, PATHINFO_EXTENSION);

    // Ruta completa de la imagen de portada con el nombre único y la extensión
    $portadaPath = $portadaDir . $portadaUniqueName . '.' . $portadaExtension;

    // Mover la imagen de portada a la carpeta de portadas con el nombre único
    move_uploaded_file($portadaTmpName, $portadaPath);
} else {
    // Manejar el caso cuando no se proporciona la imagen de portada
    echo '
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.4/dist/sweetalert2.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.4/dist/sweetalert2.min.css">
    <script>
    Swal.fire({
        title: "Falta una Portada de tu Tesis",
        text: "Vuelve a intentarlo",
        icon: "question"
    }).then(() => {
        history.back();
    });
</script>
';
    // Puedes mostrar un mensaje de error o redirigir al formulario nuevamente
    exit();
}

$sql = "INSERT INTO tesis (titulo, autores, año, categoria, resumen, imagen, archivo_pdf) VALUES ('$titulo', '$autores', $anio, '$categoria', '$resumen', '$portadaPath', '$pdfPath')";

// Ejecutar la consulta SQL
if (mysqli_query($conex, $sql)) {
    // La inserción se realizó correctamente
    echo '
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.4/dist/sweetalert2.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.4/dist/sweetalert2.min.css">
        <script>
        Swal.fire({
            title: "¡Excelente!",
            text: "El registro fue exitoso",
            icon: "success",
            }).then(function() {
                window.location.href = "../book.html";
            });
        </script>
    ';
} else {
    // Eliminar los archivos PDF y de portada si no se pudo guardar en la base de datos
    unlink($pdfPath);
    unlink($portadaPath);

    echo '
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.4/dist/sweetalert2.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.4/dist/sweetalert2.min.css">
        <script>
            Swal.fire(
              "¡Error!",
              "Existe Un ERROR",
              "error"
            );
        </script>
    ';
}

/**
 * Función para sanear un nombre de archivo
 * Reemplaza caracteres no permitidos por guiones bajos
 * @param string $filename Nombre de archivo a sanear
 * @return string Nombre de archivo saneado
 */
function sanitizeFileName($filename) {
    $filename = preg_replace('/[^a-zA-Z0-9_-]/', '_', $filename);
    return $filename;
}
?>
