<?php
$servidor = "localhost";
$usuario = "root";
$contra = "";
$dataname = "repoismac";

$conex=mysqli_connect($servidor,$usuario,$contra,$dataname);

if($conex) {
    echo 'Conexión establecida';
}else{

    echo 'Conexión no se pudo establecer.';}

