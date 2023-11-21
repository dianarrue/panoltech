error_reporting(E_ALL);
ini_set('display_errors', 1);
<?php 

require_once "../modelos/herramienta.php";

$herramienta=new Herramienta();

$idherramienta=isset($_POST["idherramienta"])? limpiarCadena($_POST["idherramienta"]):"";
$herramienta=isset($_POST["herramienta"])? limpiarCadena($_POST["herramienta"]):"";
$cantidad_disponible=isset($_POST["cantidad_disponible"])? limpiarCadena($_POST["cantidad_disponible"]):"";
$descripcion=isset($_POST["descripcion"])? limpiarCadena($_POST["descripcion"]):"";
$imagen=isset($_POST["imagen"])? limpiarCadena($_POST["imagen"]):"";

switch ($_GET["op"]){
	case 'guardaryeditar':

		if (!file_exists($_FILES['imagen']['tmp_name']) || !is_uploaded_file($_FILES['imagen']['tmp_name']))
		{
			$imagen=$_POST["imagenactual"];
		}
		else 
		{
			$ext = explode(".", $_FILES["imagen"]["name"]);
			if ($_FILES['imagen']['type'] == "image/jpg" || $_FILES['imagen']['type'] == "image/jpeg" || $_FILES['imagen']['type'] == "image/png")
			{
				$imagen = round(microtime(true)) . '.' . end($ext);
				move_uploaded_file($_FILES["imagen"]["tmp_name"], "../files/herramientas/" . $imagen);
			}
		}
		if (empty($idherramienta)){
			$rspta=$herramienta->insertar($titulo,$cantidad_disponible,$descripcion,$imagen);
			echo $rspta ? "Herramienta registrado" : "Herramienta no se pudo registrar";
		}
		else {
			$rspta=$herramienta->editar($idherramienta,$titulo,$cantidad_disponible,$descripcion,$imagen);
			echo $rspta ? "Herramienta actualizado" : "Herramienta no se pudo actualizar";
		}
	break;

	case 'desactivar':
		$rspta=$herramienta->desactivar($idherramienta);
 		echo $rspta ? "Herramienta Desactivada" : "Herramienta no se puede desactivar";
	break;

	case 'activar':
		$rspta=$herramienta->activar($idherramienta);
		var_dump($rspta);
 		echo $rspta ? "herramienta activada" : "Herramienta no se puede activar";
	break;

	case 'mostrar':
		$rspta=$herramienta->mostrar($idherramienta);
 		//Codificar el resultado utilizando json
 		echo json_encode($rspta);
	break;

	case 'listar':
		$rspta=$herramienta->listar();
 		//Vamos a declarar un array
 		$data= Array();

 		while ($reg=$rspta->fetch_object()){
 			$data[]=array(
 				"0"=>($reg->condicion)?'<button class="btn btn-warning" onclick="mostrar('.$reg->idherramienta.')"><i class="fa fa-pencil"></i></button>'.
 					' <button class="btn btn-danger" onclick="desactivar('.$reg->idherramienta.')"><i class="fa fa-close"></i></button>':
 					'<button class="btn btn-warning" onclick="mostrar('.$reg->idherramienta.')"><i class="fa fa-pencil"></i></button>'.
 					' <button class="btn btn-primary" onclick="activar('.$reg->idherramienta.')"><i class="fa fa-check"></i></button>',
 				"1"=>$reg->herramienta,
 				"2"=>$reg->cantidad_disponible,
 				"3"=>$reg->materia,
 				"4"=>$reg->descripcion,
 				"5"=>"<img src='../files/herramientas/".$reg->imagen."' height='50px' width='50px' >",
 				"6"=>($reg->condicion)?'<span class="label bg-green">Activado</span>':
 				'<span class="label bg-red">Desactivado</span>'
 				);
 		}
 		$results = array(
 			"sEcho"=>1, //Información para el datatables
 			"iTotalRecords"=>count($data), //enviamos el total registros al datatable
 			"iTotalDisplayRecords"=>count($data), //enviamos el total registros a visualizar
 			"aaData"=>$data);
 		echo json_encode($results);

	break;





 
  }
?>