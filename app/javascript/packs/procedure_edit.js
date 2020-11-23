$(document).on('turbolinks:load', function() {

    var regiones = gon.regiones;
    regiones = JSON.parse(JSON.stringify(regiones));
    var option = $("#procedure_region").val();
    var nuevas_comunas = $.grep(regiones, function(region) { return region.codigo == option; });
    nuevas_comunas = nuevas_comunas[0].comunas;
    console.log(nuevas_comunas);

    //borrar las opciones actuales
    $('#procedure_sector').children().remove();

    //agregar al select de comunas los datos del json
    $.each(nuevas_comunas, function (i, item) {
        $('#procedure_sector').append($('<option>', {
            value: item.codigo,
            text : item.nombre
        }));
    });

    $('#procedure_sector')

    //preparar lo anterior para cada vez que se cambie el select de regiones
    $("#procedure_region").change(function(){
        //seleccionar las comunas de la region correspondiente
        var option = $(this).val();
        console.log("opcion = " + option);
        var nuevas_comunas = $.grep(regiones, function(region) { return region.codigo == option; });
        nuevas_comunas = nuevas_comunas[0].comunas;
        console.log(nuevas_comunas);

        //borrar las opciones actuales
        $('#procedure_sector').children().remove();

        //agregar al select de comunas los datos del json
        $.each(nuevas_comunas, function (i, item) {
            $('#procedure_sector').append($('<option>', {
                value: item.codigo,
                text : item.nombre
            }));
        });
    });

});
