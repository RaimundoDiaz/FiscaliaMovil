$(document).on('turbolinks:load', function() {
    //transformar la variable de ruby a un json

    var regiones = [
        {
            codigo : 15,
            nombre :  "Arica y Parinacota",
            comunas : [ {codigo : "15101",   nombre : "Arica"},
                        {codigo : "15102",   nombre : "Camarones"},
                        {codigo : "15201",   nombre : "Putre"},
                        {codigo : "15202",   nombre : "General Lagos"}]
        },{
            codigo : 1,
            nombre :  "Tarapacá"    ,
            comunas : [
            {codigo : "01101",   nombre : "Iquique"},
            {codigo : "01107",   nombre : "Alto Hospicio"},
            {codigo : "01401",   nombre : "Pozo Almonte"},
            {codigo : "01402",   nombre : "Camiña"},
            {codigo : "01403",   nombre : "Colchane"},
            {codigo : "01404",   nombre : "Huara"},
            {codigo : "01405",   nombre : "Pica"}
    ]
    },{
    codigo : 2,
    nombre :  "Antofagasta" ,
    comunas : [
            {codigo : "02101",   nombre : "Antofagasta"},
        {codigo : "02102",   nombre : "Mejillones"},
        {codigo : "02103",   nombre : "Sierra Gorda"},
        {codigo : "02104",   nombre : "Taltal"},
        {codigo : "02201",   nombre : "Calama"},
        {codigo : "02202",   nombre : "Ollagüe"},
        {codigo : "02203",   nombre : "San Pedro de Atacama"},
        {codigo : "02301",   nombre : "Tocopilla"},
        {codigo : "02302",   nombre : "María Elena"}
    ]
    },{
    codigo : 3,
    nombre :  "Atacama" ,
    comunas : [
            {codigo : "03101",   nombre : "Copiapó"},
        {codigo : "03102",   nombre : "Caldera"},
        {codigo : "03103",   nombre : "Tierra Amarilla"},
        {codigo : "03201",   nombre : "Chañaral"},
        {codigo : "03202",   nombre : "Diego de Almagro"},
        {codigo : "03301",   nombre : "Vallenar"},
        {codigo : "03302",   nombre : "Alto del Carmen"},
        {codigo : "03303",   nombre : "Freirina"},
        {codigo : "03304",   nombre : "Huasco"},
    ]
    },{
    codigo : 4,
    nombre :  "Coquimbo" ,
    comunas : [
            {codigo : "04101",   nombre : "La Serena"},
        {codigo : "04102",   nombre : "Coquimbo"},
        {codigo : "04103",   nombre : "Andacollo"},
        {codigo : "04104",   nombre : "La Higuera"},
        {codigo : "04105",   nombre : "Paiguano"},
        {codigo : "04106",   nombre : "Vicuña"},
        {codigo : "04201",   nombre : "Illapel"},
        {codigo : "04202",   nombre : "Canela"},
        {codigo : "04203",   nombre : "Los Vilos"},
        {codigo : "04204",   nombre : "Salamanca"},
        {codigo : "04301",   nombre : "Ovalle",},
        {codigo : "04302",   nombre : "Combarbalá"},
        {codigo : "04303",   nombre : "Monte Patria"},
        {codigo : "04304",   nombre : "Punitaqui"},
        {codigo : "04305",   nombre : "Río Hurtado"}
    ]
    },{
    codigo : 5,
    nombre :  "Valparaíso" ,
    comunas : [
            {codigo : "05101",   nombre : "Valparaíso"},
        {codigo : "05102",   nombre : "Casablanca"},
        {codigo : "05103",   nombre : "Concón"},
        {codigo : "05104",   nombre : "Juan Fernández"},
        {codigo : "05105",   nombre : "Puchuncaví"},
        {codigo : "05107",   nombre : "Quintero"},
        {codigo : "05109",   nombre : "Viña del Mar"},
        {codigo : "05201",   nombre : "Isla de Pascua"},
        {codigo : "05301",   nombre : "Los Andes"},
        {codigo : "05302",   nombre : "Calle Larga"},
        {codigo : "05303",   nombre : "Rinconada"},
        {codigo : "05304",   nombre : "San Esteban"},
        {codigo : "05401",   nombre : "La Ligua"},
        {codigo : "05402",   nombre : "Cabildo"},
        {codigo : "05403",   nombre : "Papudo"},
        {codigo : "05404",   nombre : "Petorca"},
        {codigo : "05405",   nombre : "Zapallar"},
        {codigo : "05501",   nombre : "Quillota"},
        {codigo : "05502",   nombre : "Calera"},
        {codigo : "05503",   nombre : "Hijuelas"},
        {codigo : "05504",   nombre : "La Cruz"},
        {codigo : "05506",   nombre : "Nogales"},
        {codigo : "05601",   nombre : "San Antonio"},
        {codigo : "05602",   nombre : "Algarrobo"},
        {codigo : "05603",   nombre : "Cartagena"},
        {codigo : "05604",   nombre : "El Quisco"},
        {codigo : "05605",   nombre : "El Tabo"},
        {codigo : "05606",   nombre : "Santo Domingo"},
        {codigo : "05701",   nombre : "San Felipe"},
        {codigo : "05702",   nombre : "Catemu"},
        {codigo : "05703",   nombre : "Llaillay"},
        {codigo : "05704",   nombre : "Panquehue"},
        {codigo : "05705",   nombre : "Putaendo "},
        {codigo : "05706",   nombre : "Santa María"},
        {codigo : "05801",   nombre : "Quilpué"},
        {codigo : "05802",   nombre : "Limache"},
        {codigo : "05803",   nombre : "Olmué"},
        {codigo : "05804",   nombre : "Villa Alemana"}
    ]
    },{
    codigo : 6,
    nombre :  "Región del Libertador Gral. Bernardo O’Higgins"  ,
    comunas : [
            {codigo : "06101",   nombre : "Rancagua"},
        {codigo : "06102",   nombre : "Codegua"},
        {codigo : "06103",   nombre : "Coinco"},
        {codigo : "06104",   nombre : "Coltauco"},
        {codigo : "06105",   nombre : "Doñihue"},
        {codigo : "06106",   nombre : "Graneros"},
        {codigo : "06107",   nombre : "Las Cabras"},
        {codigo : "06108",   nombre : "Machalí"},
        {codigo : "06109",   nombre : "Malloa"},
        {codigo : "06110",   nombre : "Mostazal"},
        {codigo : "06111",   nombre : "Olivar"},
        {codigo : "06112",   nombre : "Peumo"},
        {codigo : "06113",   nombre : "Pichidegua"},
        {codigo : "06114",   nombre : "Quinta de Tilcoco"},
        {codigo : "06115",   nombre : "Rengo"},
        {codigo : "06116",   nombre : "Requínoa"},
        {codigo : "06117",   nombre : "San Vicente"},
        {codigo : "06201",   nombre : "Pichilemu"},
        {codigo : "06202",   nombre : "La Estrella"},
        {codigo : "06203",   nombre : "Litueche"},
        {codigo : "06204",   nombre : "Marchihue"},
        {codigo : "06205",   nombre : "Navidad"},
        {codigo : "06206",   nombre : "Paredones"},
        {codigo : "06301",   nombre : "San Fernando"},
        {codigo : "06302",   nombre : "Chépica"},
        {codigo : "06303",   nombre : "Chimbarongo"},
        {codigo : "06304",   nombre : "Lolol"},
        {codigo : "06305",   nombre : "Nancagua"},
        {codigo : "06306",   nombre : "Palmilla"},
        {codigo : "06307",   nombre : "Peralillo"},
        {codigo : "06308",   nombre : "Placilla"},
        {codigo : "06309",   nombre : "Pumanque"},
        {codigo : "06310",   nombre : "Santa Cruz"}
    ]
    },{
    codigo : 7,
    nombre :  "Región del Maule",
    comunas : [
            {codigo : "07101",   nombre : "Talca"},
        {codigo : "07102",   nombre : "Constitución"},
        {codigo : "07103",   nombre : "Curepto"},
        {codigo : "07104",   nombre : "Empedrado"},
        {codigo : "07105",   nombre : "Maule"},
        {codigo : "07106",   nombre : "Pelarco"},
        {codigo : "07107",   nombre : "Pencahue"},
        {codigo : "07108",   nombre : "Río Claro"},
        {codigo : "07109",   nombre : "San Clemente"},
        {codigo : "07110",   nombre : "San Rafael"},
        {codigo : "07201",   nombre : "Cauquenes"},
        {codigo : "07202",   nombre : "Chanco"},
        {codigo : "07203",   nombre : "Pelluhue"},
        {codigo : "07301",   nombre : "Curicó"},
        {codigo : "07302",   nombre : "Hualañé"},
        {codigo : "07303",   nombre : "Licantén"},
        {codigo : "07304",   nombre : "Molina"},
        {codigo : "07305",   nombre : "Rauco"},
        {codigo : "07306",   nombre : "Romeral"},
        {codigo : "07307",   nombre : "Sagrada Familia"},
        {codigo : "07308",   nombre : "Teno"},
        {codigo : "07309",   nombre : "Vichuquén"},
        {codigo : "07401",   nombre : "Linares"},
        {codigo : "07402",   nombre : "Colbún"},
        {codigo : "07403",   nombre : "Longaví"},
        {codigo : "07404",   nombre : "Parral"},
        {codigo : "07405",   nombre : "Retiro"},
        {codigo : "07406",   nombre : "San Javier"},
        {codigo : "07407",   nombre : "Villa Alegre"},
        {codigo : "07408",   nombre : "Yerbas Buenas"}
    ]
    },{
    codigo : 8,
    nombre :  "Región del Biobío" ,
    comunas : [
            {codigo : "08101",   nombre : "Concepción"},
        {codigo : "08102",   nombre : "Coronel"},
        {codigo : "08103",   nombre : "Chiguayante"},
        {codigo : "08104",   nombre : "Florida"},
        {codigo : "08105",   nombre : "Hualqui"},
        {codigo : "08106",   nombre : "Lota"},
        {codigo : "08107",   nombre : "Penco"},
        {codigo : "08108",   nombre : "San Pedro de la Paz"},
        {codigo : "08109",   nombre : "Santa Juana"},
        {codigo : "08110",   nombre : "Talcahuano"},
        {codigo : "08111",   nombre : "Tomé"},
        {codigo : "08112",   nombre : "Hualpén"},
        {codigo : "08201",   nombre : "Lebu"},
        {codigo : "08202",   nombre : "Arauco"},
        {codigo : "08203",   nombre : "Cañete"},
        {codigo : "08204",   nombre : "Contulmo"},
        {codigo : "08205",   nombre : "Curanilahue"},
        {codigo : "08206",   nombre : "Los Álamos"},
        {codigo : "08207",   nombre : "Tirúa"},
        {codigo : "08301",   nombre : "Los Ángeles"},
        {codigo : "08302",   nombre : "Antuco"},
        {codigo : "08303",   nombre : "Cabrero"},
        {codigo : "08304",   nombre : "Laja"},
        {codigo : "08305",   nombre : "Mulchén"},
        {codigo : "08306",   nombre : "Nacimiento"},
        {codigo : "08307",   nombre : "Negrete"},
        {codigo : "08308",   nombre : "Quilaco"},
        {codigo : "08309",   nombre : "Quilleco"},
        {codigo : "08310",   nombre : "San Rosendo"},
        {codigo : "08311",   nombre : "Santa Bárbara"},
        {codigo : "08312",   nombre : "Tucapel"},
        {codigo : "08313",   nombre : "Yumbel"},
        {codigo : "08314",   nombre : "Alto Biobío"},
        {codigo : "08401",   nombre : "Chillán"},
        {codigo : "08402",   nombre : "Bulnes"},
        {codigo : "08403",   nombre : "Cobquecura"},
        {codigo : "08404",   nombre : "Coelemu"},
        {codigo : "08405",   nombre : "Coihueco"},
        {codigo : "08406",   nombre : "Chillán Viejo"},
        {codigo : "08407",   nombre : "El Carmen"},
        {codigo : "08408",   nombre : "Ninhue"},
        {codigo : "08409",   nombre : "Ñiquén"},
        {codigo : "08410",   nombre : "Pemuco"},
        {codigo : "08411",   nombre : "Pinto"},
        {codigo : "08412",   nombre : "Portezuelo"},
        {codigo : "08413",   nombre : "Quillón"},
        {codigo : "08414",   nombre : "Quirihue"},
        {codigo : "08415",   nombre : "Ránquil"},
        {codigo : "08416",   nombre : "San Carlos"},
        {codigo : "08417",   nombre : "San Fabián"},
        {codigo : "08418",   nombre : "San Ignacio"},
        {codigo : "08419",   nombre : "San Nicolás"},
        {codigo : "08420",   nombre : "Treguaco"},
        {codigo : "08421",   nombre : "Yungay"}
    ]
    },{
    codigo : 9,
    nombre :  "Región de la Araucanía" ,
    comunas : [
            {codigo : "09101",   nombre : "Temuco"},
        {codigo : "09102",   nombre : "Carahue"},
        {codigo : "09103",   nombre : "Cunco"},
        {codigo : "09104",   nombre : "Curarrehue"},
        {codigo : "09105",   nombre : "Freire"},
        {codigo : "09106",   nombre : "Galvarino"},
        {codigo : "09107",   nombre : "Gorbea"},
        {codigo : "09108",   nombre : "Lautaro"},
        {codigo : "09109",   nombre : "Loncoche"},
        {codigo : "09110",   nombre : "Melipeuco"},
        {codigo : "09111",   nombre : "Nueva Imperial"},
        {codigo : "09112",   nombre : "Padre las Casas"},
        {codigo : "09113",   nombre : "Perquenco"},
        {codigo : "09114",   nombre : "Pitrufquén"},
        {codigo : "09115",   nombre : "Pucón"},
        {codigo : "09116",   nombre : "Saavedra"},
        {codigo : "09117",   nombre : "Teodoro Schmidt"},
        {codigo : "09118",   nombre : "Toltén"},
        {codigo : "09119",   nombre : "Vilcún"},
        {codigo : "09120",   nombre : "Villarrica"},
        {codigo : "09121",   nombre : "Cholchol"},
        {codigo : "09201",   nombre : "Angol"},
        {codigo : "09202",   nombre : "Collipulli"},
        {codigo : "09203",   nombre : "Curacautín"},
        {codigo : "09204",   nombre : "Ercilla"},
        {codigo : "09205",   nombre : "Lonquimay"},
        {codigo : "09206",   nombre : "Los Sauces"},
        {codigo : "09207",   nombre : "Lumaco"},
        {codigo : "09208",   nombre : "Purén"},
        {codigo : "09209",   nombre : "Renaico"},
        {codigo : "09210",   nombre : "Traiguén"},
        {codigo : "09211",   nombre : "Victoria"}
    ]
    },{
    codigo : 14,
    nombre :  "Región de Los Ríos",
    comunas : [
            {codigo : "14101",   nombre : "Valdivia"},
        {codigo : "14102",   nombre : "Corral"},
        {codigo : "14103",   nombre : "Lanco"},
        {codigo : "14104",   nombre : "Los Lagos"},
        {codigo : "14105",   nombre : "Máfil"},
        {codigo : "14106",   nombre : "Mariquina"},
        {codigo : "14107",   nombre : "Paillaco"},
        {codigo : "14108",   nombre : "Panguipulli"},
        {codigo : "14201",   nombre : "La Unión"},
        {codigo : "14202",   nombre : "Futrono"},
        {codigo : "14203",   nombre : "Lago Ranco"},
        {codigo : "14204",   nombre : "Río Bueno"}
    ]
    },{
    codigo : 10,
    nombre :  "Región de Los Lagos" ,
    comunas : [
            {codigo : "10101",   nombre : "Puerto Montt"},
        {codigo : "10102",   nombre : "Calbuco"},
        {codigo : "10103",   nombre : "Cochamó"},
        {codigo : "10104",   nombre : "Fresia"},
        {codigo : "10105",   nombre : "Frutillar"},
        {codigo : "10106",   nombre : "Los Muermos"},
        {codigo : "10107",   nombre : "Llanquihue"},
        {codigo : "10108",   nombre : "Maullín"},
        {codigo : "10109",   nombre : "Puerto Varas"},
        {codigo : "10201",   nombre : "Castro"},
        {codigo : "10202",   nombre : "Ancud"},
        {codigo : "10203",   nombre : "Chonchi"},
        {codigo : "10204",   nombre : "Curaco de Vélez"},
        {codigo : "10205",   nombre : "Dalcahue"},
        {codigo : "10206",   nombre : "Puqueldón"},
        {codigo : "10207",   nombre : "Queilén"},
        {codigo : "10208",   nombre : "Quellón"},
        {codigo : "10209",   nombre : "Quemchi"},
        {codigo : "10210",   nombre : "Quinchao"},
        {codigo : "10301",   nombre : "Osorno"},
        {codigo : "10302",   nombre : "Puerto Octay"},
        {codigo : "10303",   nombre : "Purranque"},
        {codigo : "10304",   nombre : "Puyehue"},
        {codigo : "10305",   nombre : "Río Negro"},
        {codigo : "10306",   nombre : "San Juan de la Costa"},
        {codigo : "10307",   nombre : "San Pablo"},
        {codigo : "10401",   nombre : "Chaitén"},
        {codigo : "10402",   nombre : "Futaleufú"},
        {codigo : "10403",   nombre : "Hualaihué"},
        {codigo : "10404",   nombre : "Palena"}
    ]
    },{
    codigo : 11,
    nombre :  "Región Aisén del Gral. Carlos Ibáñez del Campo"  ,
    comunas : [
            {codigo : "11101",   nombre : "Coihaique"},
        {codigo : "11102",   nombre : "Lago Verde"},
        {codigo : "11201",   nombre : "Aisén"},
        {codigo : "11202",   nombre : "Cisnes"},
        {codigo : "11203",   nombre : "Guaitecas"},
        {codigo : "11301",   nombre : "Cochrane"},
        {codigo : "11302",   nombre : "O’Higgins"},
        {codigo : "11303",   nombre : "Tortel"},
        {codigo : "11401",   nombre : "Chile Chico"},
        {codigo : "11402",   nombre : "Río Ibáñez"}
    ]
    },{
    codigo : 12,
    nombre :  "Región de Magallanes y de la Antártica Chilena",
    comunas : [
            {codigo : "12101",   nombre : "Punta Arenas"},
        {codigo : "12102",   nombre : "Laguna Blanca"},
        {codigo : "12103",   nombre : "Río Verde"},
        {codigo : "12104",   nombre : "San Gregorio"},
        {codigo : "12201",   nombre : "Cabo de Hornos (Ex Navarino)"},
        {codigo : "12202",   nombre : "Antártica"},
        {codigo : "12301",   nombre : "Porvenir"},
        {codigo : "12302",   nombre : "Primavera"},
        {codigo : "12303",   nombre : "Timaukel"},
        {codigo : "12401",   nombre : "Natales"},
        {codigo : "12402",   nombre : "Torres del Paine"}
    ]
    },{
    codigo : 13,
    nombre :  "Región Metropolitana de Santiago"    ,
    comunas : [
            {codigo : "13101",   nombre : "Santiago"},
        {codigo : "13102",   nombre : "Cerrillos"},
        {codigo : "13103",   nombre : "Cerro Navia"},
        {codigo : "13104",   nombre : "Conchalí"},
        {codigo : "13105",   nombre : "El Bosque"},
        {codigo : "13106",   nombre : "Estación Central"},
        {codigo : "13107",   nombre : "Huechuraba"},
        {codigo : "13108",   nombre : "Independencia"},
        {codigo : "13109",   nombre : "La Cisterna"},
        {codigo : "13110",   nombre : "La Florida"},
        {codigo : "13111",   nombre : "La Granja"},
        {codigo : "13112",   nombre : "La Pintana"},
        {codigo : "13113",   nombre : "La Reina"},
        {codigo : "13114",   nombre : "Las Condes"},
        {codigo : "13115",   nombre : "Lo Barnechea"},
        {codigo : "13116",   nombre : "Lo Espejo"},
        {codigo : "13117",   nombre : "Lo Prado"},
        {codigo : "13118",   nombre : "Macul"},
        {codigo : "13119",   nombre : "Maipú"},
        {codigo : "13120",   nombre : "Ñuñoa"},
        {codigo : "13121",   nombre : "Pedro Aguirre Cerda"},
        {codigo : "13122",   nombre : "Peñalolén"},
        {codigo : "13123",   nombre : "Providencia"},
        {codigo : "13124",   nombre : "Pudahuel"},
        {codigo : "13125",   nombre : "Quilicura"},
        {codigo : "13126",   nombre : "Quinta Normal"},
        {codigo : "13127",   nombre : "Recoleta"},
        {codigo : "13128",   nombre : "Renca"},
        {codigo : "13129",   nombre : "San Joaquín"},
        {codigo : "13130",   nombre : "San Miguel"},
        {codigo : "13131",   nombre : "San Ramón"},
        {codigo : "13132",   nombre : "Vitacura"},
        {codigo : "13201",   nombre : "Puente Alto"},
        {codigo : "13202",   nombre : "Pirque"},
        {codigo : "13203",   nombre : "San José de Maipo"},
        {codigo : "13301",   nombre : "Colina"},
        {codigo : "13302",   nombre : "Lampa"},
        {codigo : "13303",   nombre : "Tiltil"},
        {codigo : "13401",   nombre : "San Bernardo"},
        {codigo : "13402",   nombre : "Buin"},
        {codigo : "13403",   nombre : "Calera de Tango"},
        {codigo : "13404",   nombre : "Paine"},
        {codigo : "13501",   nombre : "Melipilla"},
        {codigo : "13502",   nombre : "Alhué"},
        {codigo : "13503",   nombre : "Curacaví"},
        {codigo : "13504",   nombre : "María Pinto"},
        {codigo : "13505",   nombre : "San Pedro"},
        {codigo : "13601",   nombre : "Talagante"},
        {codigo : "13602",   nombre : "El Monte"},
        {codigo : "13603",   nombre : "Isla de Maipo"},
        {codigo : "13604",   nombre : "Padre Hurtado"},
        {codigo : "13605",   nombre : "Peñaflor"}]
        }
    ];

    var comunas = regiones[0];
    comunas = JSON.parse(JSON.stringify(comunas));
    comunas = comunas.comunas; // [{codigo : 1231, nombre: "", ...}]

    //agregar al select de comunas los datos del json
    $.each(comunas, function (i, item) {
        $('#procedure_sector').append($('<option>', {
            value: item.codigo,
            text : item.nombre
        }));
    });

    //preparar lo anterior para cada vez que se cambie el select de regiones
    $("#procedure_region").change(function(){
        //seleccionar las comunas de la region correspondiente
        regiones = JSON.parse(JSON.stringify(regiones));
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

    var crimeField = $('#new_crime').clone()
    $('#new_crime').last().remove()

    $('#add_crime_btn').click(function () {
        $('#crimes').append(crimeField.clone())
        $('.delete_crime').last().click(function () {
            var division = $('.delete_crime').last().closest('#new_crime')
            division.remove()
        })
    });

    $('#procedure_tag_ids').chosen({
        allow_single_deselect: true,
        width: '100%'
    });

    $(function() {
        $("#accusedRut").rut({formatOn: 'keyup'})
    });
    $(function() {
        $("#victimRut").rut({formatOn: 'keyup'})
    });
    $(function() {
        $("#witnessRut").rut({formatOn: 'keyup'})
    });

    function restartAccusedModal(){
        $('#accusedName').val("");
        $('#accusedAlias').val("");
        $('#accusedRut').val("");

        $("#accusedRut").removeClass("is-invalid");
        $("#accusedRut").removeClass("has-danger");
        $('#accused-invalid-rut').hide();
    }

    $('#accusedClose').on('click',function(){restartAccusedModal()});
    $('#close-accused-btn').on('click',function(){restartAccusedModal()});

    //al apretar el boton guardar en el modal del acusado
    $('#modal-accused-btn').click(function() {
        if($.validateRut($("#accusedRut").val()) || $("#accusedRut").val() == "") {
            $("#accusedRut").removeClass("has-danger");
            $("#accusedRut").addClass("has-success");
            $("#accusedRut").removeClass("is-invalid");
            $("#accusedRut").addClass("form-control-success");
            $('#accused-invalid-rut').hide();

            var name = $('#accusedName').val();
            var alias = $('#accusedAlias').val();
            var rut = $('#accusedRut').val();

            var input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "procedure[accuseds][][name]").val(name);
            $('#form_procedure').append(input);

            input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "procedure[accuseds][][alias]").val(alias);
            $('#form_procedure').append(input);
            input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "procedure[accuseds][][rut]").val(rut);
            $('#form_procedure').append(input);

            $('#accuseds').append($("<div class=\"d-flex justify-content-between\">\n" +
                "                <p><b>Nombre:</b> " + name + " </p> <p><b>Alias:</b> \"" + alias + "\" </p>\n" +
                "                <p><b>Rut:</b> " + rut + "</p>\n" +
                "              </div>"));
            restartAccusedModal()
            $("#accusedClose").click()
        }
        else{
            $("#accusedRut").addClass("has-danger");
            $("#accusedRut").addClass("is-invalid");
            $('#accused-invalid-rut').removeAttr('hidden');
        }
    });

    function restartVictimModal(){
        $('#victimName').val("");
        $('#victimRut').val("");
        $('#victimContact').val("");
        $('#victimStory').val("");

        $("#victimRut").removeClass("has-danger");
        $("#victimRut").removeClass("is-invalid");
        $('#victim-invalid-rut').hide();
    }

    $('#victimClose').on('click',function(){restartVictimModal()});
    $('#close-victim-btn').on('click',function(){restartVictimModal()});

    //logica del modal de la victima al clickear el boton guardar
    $('#modal-victim-btn').click(function() {
        if($.validateRut($("#victimRut").val()) || $("#victimRut").val() == "") {
            $("#victimRut").removeClass("has-danger");
            $("#victimRut").addClass("has-success");
            $("#victimRut").removeClass("is-invalid");
            $("#victimRut").addClass("form-control-success");
            $('#victim-invalid-rut').hide();

            var name = $('#victimName').val();
            var rut = $('#victimRut').val();
            var story = $('#victimStory').val();
            var contact = $('#victimContact').val();
            var deceased = $('#deceasedVictimSwitch').is(":checked");

            var input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "procedure[victims][][name]").val(name);
            $('#form_procedure').append(input);

            input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "procedure[victims][][rut]").val(rut);
            $('#form_procedure').append(input);
            input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "procedure[victims][][story]").val(story);
            $('#form_procedure').append(input);
            input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "procedure[victims][][contact]").val(contact);
            $('#form_procedure').append(input);
            input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "procedure[victims][][deceased]").val(deceased);
            $('#form_procedure').append(input);

            restartVictimModal()

            $('#victims').append($("<div class=\"d-flex justify-content-between\">\n" +
                "                   <p><b>Nombre:</b> " + name+ " </p> <p><b>Rut:</b> " + rut + " </p> <p><b>Contacto:</b> " + contact + " </p>" +
                "                   </div> <div><p><b>Detalles:</b> " + story + "</p></div>"));
            $("#victimClose").click()
        }
        else{
            $("#victimRut").addClass("has-danger")
            $("#victimRut").addClass("is-invalid")
            $('#victim-invalid-rut').removeAttr('hidden');
        }
    });

    function restartWitnessModal(){
        $('#witnessName').val("");
        $('#witnessRut').val("");
        $('#witnessContact').val("");
        $('#witnessStory').val("");
        $("#witnessRut").removeClass("has-danger");
        $("#witnessRut").removeClass("is-invalid");
        $('#witness-invalid-rut').hide();
    };

    $('#witnessClose').on('click',function(){restartWitnessModal()});
    $('#close-witness-btn').on('click',function(){restartWitnessModal()});

    $('#modal-witness-btn').click(function() {

        if($.validateRut($("#witnessRut").val()) || $("#witnessRut").val() == "") {
            $("#witnessRut").removeClass("has-danger");
            $("#witnessRut").addClass("has-success");
            $("#witnessRut").removeClass("is-invalid");
            $("#witnessRut").addClass("form-control-success");
            $('#witness-invalid-rut').hide();

            var name = $('#witnessName').val();
            var rut = $('#witnessRut').val();
            var story = $('#witnessStory').val();
            var contact = $('#witnessContact').val();

            var input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "procedure[witness][][name]").val(name);
            $('#form_procedure').append(input);

            input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "procedure[witness][][rut]").val(rut);
            $('#form_procedure').append(input);
            input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "procedure[witness][][story]").val(story);
            $('#form_procedure').append(input);
            input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "procedure[witness][][contact]").val(contact);
            $('#form_procedure').append(input);
            restartWitnessModal()
            $('#witnesses').append($("<div class=\"d-flex justify-content-between\">\n" +
                "                   <p><b>Nombre:</b> " + name + " </p> <p><b>Rut:</b> " + rut +" </p> <p><b>Contacto:</b> " + contact + " </p>" +
                "                   </div> <div><p><b>Detalles:</b> " + story + "</p></div>"));
            $("#witnessClose").click()
        }
        else{
            $("#witnessRut").addClass("has-danger");
            $("#witnessRut").addClass("is-invalid");
            $('#witness-invalid-rut').removeAttr('hidden');
        }
    });
});