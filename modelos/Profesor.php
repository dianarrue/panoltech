<?php 
//Incluímos inicialmente la conexión a la base de datos
require "../config/Conexion.php";

Class Profesor
{
	//Implementamos nuestro constructor
	public function __construct()
	{

	}

	//Implementamos un método para insertar registros
	public function insertar($numero_trabajador,$rut ,$nombre,$profesion,$cargo,$email,$login,$clave)
	{
		$sql="INSERT INTO profesor (numero_trabajador,rut ,nombre,profesion,cargo,email,login,clave)
		VALUES ('$numero_trabajador','$rut ','$nombre','$profesion','$cargo','$email','$login','$clave')";
		return ejecutarConsulta($sql);
	}

	//Implementamos un método para editar registros
	public function editar($idprofesor,$numero_trabajador,$rut ,$nombre,$profesion,$cargo,$email,$login,$clave)
	{
		$sql="UPDATE profesor SET numero_trabajador='$numero_trabajador',rut ='$rut ',nombre='$nombre',profesion='$profesion',cargo='$cargo',email='$email',login='$login',clave='$clave' WHERE idprofesor='$idprofesor'";
		return ejecutarConsulta($sql);
	}


	//Implementar un método para mostrar los datos de un registro a modificar
	public function mostrar($idprofesor)
	{
		$sql="SELECT * FROM profesor WHERE idprofesor='$idprofesor'";
		return ejecutarConsultaSimpleFila($sql);
	}

	//Implementar un método para listar los registros
	public function listar()
	{
		$sql="SELECT * FROM profesor";
		return ejecutarConsulta($sql);		
	}

    //Función que va a verficar si existe 
        //la cuenta de profesor
        public function verificar($login,$clave)
        {
            $sql="SELECT nombre, login, clave FROM profesor WHERE login='$login' AND clave='$clave'";
            
            return ejecutarConsulta($sql);
        }

     //Implementamos nuestro método para insertar registros 
        public function eliminar($idprofesor)
        {
            $sql ="DELETE FROM profesor
            WHERE idprofesor='$idprofesor'";
            return ejecutarConsulta($sql);
        }
    }

?>