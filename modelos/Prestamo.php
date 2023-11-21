<?php 
//Incluímos inicialmente la conexión a la base de datos
require "../config/Conexion.php";

Class Prestamo
{
	//Implementamos nuestro constructor
	public function __construct()
	{

	}

	//Implementamos un método para insertar registros
	public function insertar($idherramienta,$idestudiante,$fecha_prestamo,$fecha_devolucion,$cantidad,$observacion)
	{
		$sql="INSERT INTO prestamo (idherramienta,idestudiante,fecha_prestamo,fecha_devolucion,cantidad,observacion,condicion)
		VALUES ('$idherramienta','$idestudiante','$fecha_prestamo','$fecha_devolucion','$cantidad','$observacion','Prestado')";
		return ejecutarConsulta($sql);
	}

	//Implementar un método para listar los registros
	public function listar()
	{
		$sql="SELECT p.idprestamo,p.idherramienta,l.titulo as herramienta,p.idestudiante,e.nombre as estudiante, DATE(p.fecha_prestamo) as fecha_prestamo,DATE(p.fecha_devolucion) as fecha_devolucion,p.cantidad,p.observacion,p.condicion FROM prestamo p INNER JOIN herrammienta l ON p.idherramienta=l.idherramienta INNER JOIN estudiante e ON p.idestudiante=e.idestudiante ORDER BY p.idprestamo desc";
		return ejecutarConsulta($sql);		
	}


	public function mostrar($idprestamo)
	{
		$sql="SELECT * FROM prestamo WHERE idprestamo='$idprestamo'";
		return ejecutarConsultaSimpleFila($sql);
	}
//Implementamos un método para anular prestamo
	public function anular($idprestamo)
	{
		$sql="UPDATE prestamo SET condicion='Devuelto' WHERE idprestamo='$idprestamo'";
		return ejecutarConsulta($sql);
	}

}

?>