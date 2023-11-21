var tabla;

//Función que se ejecuta al inicio
function init(){
	mostrarform(false);
	listar();

	$("#formulario").on("submit",function(e)
	{
		guardaryeditar(e);	
	});

	//Cargamos los items al combobox materia
	$.post("../ajax/herramienta.php?op=SelectMateria", function(r){
	            $("#idmateria").html(r);
	            $('#idmateria').selectpicker('refresh');
	});

	$("#imagenmuestra").hide();
//	$('#mAlmacen').addClass("treeview active");
  //  $('#lherramientas').addClass("active");
}

//Función limpiar
function limpiar()
{
	$("#cantidad_disponible").val("");
	$("#descripcion").val("");
	$("#imagenmuestra").attr("src","");
	$("#imagenactual").val("");
	$("#idherramienta").val("");
}

//Función mostrar formulario
function mostrarform(flag)
{
	limpiar();
	if (flag)
	{
		$("#listadoregistros").hide();
		$("#formularioregistros").show();
		$("#btnGuardar").prop("disabled",false);
		$("#btnagregar").hide();
	}
	else
	{
		$("#listadoregistros").show();
		$("#formularioregistros").hide();
		$("#btnagregar").show();
	}
}

//Función cancelarform
function cancelarform()
{
	limpiar();
	mostrarform(false);
}

//Función Listar
function listar()
{
	tabla=$('#tbllistado').dataTable(
	{
		"lengthMenu": [ 5, 10, 25, 75, 100],//mostramos el menú de registros a revisar
		"aProcessing": true,//Activamos el procesamiento del datatables
	    "aServerSide": true,//Paginación y filtrado realizados por el servidor
	    dom: '<Bl<f>rtip>',//Definimos los elementos del control de tabla
	    buttons: [		          
		            'copyHtml5',
		            'excelHtml5',
		            'csvHtml5',
		            'pdf'
		        ],
		"ajax":
				{
					url: '../ajax/herramienta.php?op=listar',
        type: "get",
        dataType: "json",
        success: function (data) {
            console.log(data); // Verifica la respuesta en la consola
            // Agrega el código adicional aquí, por ejemplo:
            // bootbox.alert(datos);
            // mostrarform(false);
			mostrarform(false);
        },
        error: function (e) {
            console.log(e.responseText);	
					}
				},
		"language": {
            "lengthMenu": "Mostrar : _MENU_ registros",
            "buttons": {
            "copyTitle": "Tabla Copiada",
            "copySuccess": {
                    _: '%d líneas copiadas',
                    1: '1 línea copiada'
                }
            }
        },
		"bDestroy": true,
		"iDisplayLength": 5,//Paginación
	    "order": [[ 0, "desc" ]]//Ordenar (columna,orden)
	}).DataTable();
}
//Función para guardar o editar

function guardaryeditar(e)
{
	e.preventDefault(); //No se activará la acción predeterminada del evento
	$("#btnGuardar").prop("disabled",true);
	var formData = new FormData($("#formulario")[0]);

	$.ajax({
		url: "../ajax/herramienta.php?op=guardaryeditar",
	    type: "POST",
	    data: formData,
	    contentType: false,
	    processData: false,

		success: function(datos) {                    
			if (datos.trim() === 'Herramienta registrada' || datos.trim() === 'Herramienta actualizada') {
				bootbox.alert("Operación exitosa");
				mostrarform(false);
			} else {
				bootbox.alert("Error: " + datos);
			}
		}

	});
	limpiar();
}

function mostrar(idherramienta)
{
	$.post("../ajax/herramienta.php?op=mostrar",{idherramienta : idherramienta}, function(data, status)
	{
		data = JSON.parse(data);		
		mostrarform(true);

		$("#cantidad_disponible").val(data.cantidad_disponible);
		$("#idmateria").val(data.idmateria);
        $('#idmateria').selectpicker('refresh');
		$("#descripcion").val(data.descripcion);
		$("#imagenmuestra").show();
		$("#imagenmuestra").attr("src","../files/herramientas/"+data.imagen);
		$("#imagenactual").val(data.imagen);
 		$("#idherramienta").val(data.idherramienta);

 	})
}

//Función para desactivar registros
function desactivar(idherramienta)
{
	bootbox.confirm("¿Está Seguro de desactivar la herramienta?", function(result){
		if(result)
        {
        	$.post("../ajax/herramienta.php?op=desactivar", {idherramienta : idherramienta}, function(e){
        		bootbox.alert(e);
	            tabla.ajax.reload();
        	});	
        }
	})
}

//Función para activar registros
function activar(idherramienta)
{
	bootbox.confirm("¿Está Seguro de activar la herramienta?", function(result){
		if(result)
        {
        	$.post("../ajax/herramienta.php?op=activar", {idherramienta : idherramienta}, function(e){
        		bootbox.alert(e);
	            tabla.ajax.reload();
        	});	
        }
	})
}
init();