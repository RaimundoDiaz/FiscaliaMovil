(()=> {
    document.addEventListener("turbolinks:load", () => {
        console.log("HOLA");
        })
})()

$(document).ready(function(){
    console.log("cargooooooooooo")
    //transformar la variable de ruby a un json
    var comunas = "<%= @regiones[0].to_json %>";
    comunas = comunas.replace(/&quot;/g,'\"');
    comunas = JSON.parse(comunas);
    comunas = comunas.comunas; // [{codigo : 1231, nombre: "", ...}]
    console.log(comunas);

    //agregar al select de comunas los datos del json
    $.each(comunas, function (i, item) {
        $('#company_comuna').append($('<option>', {
            value: item.codigo,
            text : item.nombre
        }));
    });

    //preparar lo anterior para cada vez que se cambie el select de regiones
    $("#company_region").change(function(){
        //seleccionar las comunas de la region correspondiente
        var regiones = "<%= @regiones.to_json %>";
        regiones = regiones.replace(/&quot;/g,'\"');
        regiones = JSON.parse(regiones);
        var option = $(this).val();
        console.log("opcion = " + option);
        var nuevas_comunas = $.grep(regiones, function(region) { return region.codigo == option; });
        nuevas_comunas = nuevas_comunas[0].comunas;
        console.log(nuevas_comunas);

        //borrar las opciones actuales
        $('#company_comuna').children().remove();

        //agregar al select de comunas los datos del json
        $.each(nuevas_comunas, function (i, item) {
            $('#company_comuna').append($('<option>', {
                value: item.codigo,
                text : item.nombre
            }));
        });
    });
});