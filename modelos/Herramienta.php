<?php 
//Incluímos inicialmente la conexión a la base de datos
require "../config/Conexion.php";

Class Herramienta
{
	//Implementamos nuestro constructor
	public function __construct()
	{

	}

	//Implementamos un método para insertar registros
	public function insertar($cantidad_disponible, $descripcion, $imagen, $herramienta)
	{
		$sql="INSERT INTO herramienta (cantidad_disponible, descripcion, imagen, herramienta, condicion)
		VALUES ('$cantidad_disponible','$descripcion','$imagen','$herramienta','1')";
		return ejecutarConsulta($sql);
	}
	//Implementamos un método para editar registros
	public function editar($idherramienta,$cantidad_disponible,$descripcion,$imagen,$herramienta)
	{
		$sql="UPDATE herramienta SET herramienta='$herramienta',cantidad_disponible='$cantidad_disponible',descripcion='$descripcion',imagen='$imagen' WHERE idherramienta='$idherramienta'";
		return ejecutarConsulta($sql);
	}

	//Implementamos un método para desactivar registros
	public function desactivar($idherramienta)
	{
		$sql="UPDATE herramienta SET condicion='0' WHERE idherramienta='$idherramienta'";
		return ejecutarConsulta($sql);
	}

	//Implementamos un método para activar registros
	public function activar($idherramienta)
	{
		$sql="UPDATE herramienta SET condicion='1' WHERE idherramienta='$idherramienta'";
		return ejecutarConsulta($sql);
	}

	//Implementar un método para mostrar los datos de un registro a modificar
	public function mostrar($idherramienta)
	{
		$sql="SELECT * FROM herramienta WHERE idherramienta='$idherramienta'";
		return ejecutarConsultaSimpleFila($sql);
	}

	//Implementar un método para listar los registros
	public function listar()
	{
		$sql="SELECT idherramienta,herramienta,cantidad_disponible from herramienta";
		return ejecutarConsulta($sql);		
	}

	public function select()
        {
         $sql="SELECT * FROM herramienta WHERE condicion='1'";
         return ejecutarConsulta($sql);
        }

}

?>