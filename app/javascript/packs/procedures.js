$(document).on('turbolinks:load', function() {
    if (gon.regiones){
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
    }


    var crimeField = $('#new_crime').clone()
    $('#new_crime').last().remove()

    $('#add_crime_btn').click(function () {
        $('#crimes').append(crimeField.clone())
        let delBtn = $('.delete_crime').last()
        $(delBtn).click(function () {
            let division = $(delBtn).closest('#new_crime')
            division.remove()
        })
    });

    $('#procedure_tag_ids').chosen({
        allow_single_deselect: true,
        width: '100%'
    });

    if ($('#policeUnitInCharge').length){
        $('#procedure_police_unit_in_charge').chosen({
            width: '100%'
        });
    }

    $('#procedure_police_in_charge').chosen({
        width: '100%'
    });

    $(function() {
        $("#accusedRut").rut({formatOn: 'keyup', ignoreControlKeys: false})
    });
    $(function() {
        $("#victimRut").rut({formatOn: 'keyup', ignoreControlKeys: false})
    });
    $(function() {
        $("#witnessRut").rut({formatOn: 'keyup', ignoreControlKeys: false})
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

            var accussedHTML = $(`<div id="accussed" class="card">
                                    <div class="card-body">
                                        <h5 class="card-title"> ${name} <button type="button" id="accussedDelete" class="close" aria-label="Close ml-2 mb-2"><span aria-hidden="true">&times;</span></button></h5> 
                                        <h6 class="card-subtitle text-muted">${rut}</h6>  
                                        <p class="card-subtitle text-muted">"${alias}"</p>
                                    </div>
                               </div> `);

            let button = accussedHTML.find("#accussedDelete");
            $(button).click(function () {
                let division = button.closest('#accussed')
                division.remove()
            });

            var input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "procedure[accuseds][][name]").val(name);
            accussedHTML = $(accussedHTML).append(input);

            input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "procedure[accuseds][][alias]").val(alias);
            accussedHTML = $(accussedHTML).append(input);
            input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "procedure[accuseds][][rut]").val(rut);
            accussedHTML = $(accussedHTML).append(input);

            $('#accuseds').append(accussedHTML);
            restartAccusedModal();
            $('#form-invalid-accussed').hide();
            $("#accusedClose").click()
        }
        else{
            $("#accusedRut").addClass("has-danger");
            $("#accusedRut").addClass("is-invalid");
            $('#accused-invalid-rut').removeAttr('hidden');
            $('#accused-invalid-rut').removeAttr('style');
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


            var victimHTML = $(`<div id="victim" class="card">
                                    <div class="card-body">
                                        <h5 class="card-title"> ${name} <button type="button" id="victimDelete" class="close" aria-label="Close ml-2 mb-2"><span aria-hidden="true">&times;</span></button></h5> 
                                        <h6 class="card-subtitle text-muted"> ${rut}</h6>  
                                        <p class="card-subtitle text-muted"> ${contact}</p>
                                        <p class="card-text text-muted">${story}</p>
                                    </div>
                               </div> `);

            let button = victimHTML.find("#victimDelete");
            $(button).click(function () {
                let division = button.closest('#victim')
                division.remove()
            });

            var input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "procedure[victims][][name]").val(name);
            victimHTML = $(victimHTML).append(input);

            input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "procedure[victims][][rut]").val(rut);
            victimHTML = $(victimHTML).append(input);
            input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "procedure[victims][][story]").val(story);
            victimHTML = $(victimHTML).append(input);
            input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "procedure[victims][][contact]").val(contact);
            victimHTML = $(victimHTML).append(input);
            input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "procedure[victims][][deceased]").val(deceased);
            victimHTML = $(victimHTML).append(input);

            restartVictimModal()

            $('#victims').append(victimHTML);
            $("#victimClose").click()
        }
        else{
            $("#victimRut").addClass("has-danger")
            $("#victimRut").addClass("is-invalid")
            $('#victim-invalid-rut').removeAttr('hidden');
            $('#victim-invalid-rut').removeAttr('style');
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

            var witnessHTML = $(`<div id="witness" class="card">
                                    <div class="card-body">
                                        <h5 class="card-title"> ${name} <button type="button" id="witnessDelete" class="close" aria-label="Close ml-2 mb-2"><span aria-hidden="true">&times;</span></button></h5> 
                                        <h6 class="card-subtitle text-muted"> ${rut}</h6>  
                                        <p class="card-subtitle text-muted"> ${contact}</p>
                                        <p class="card-text text-muted">${story}</p>
                                    </div>
                               </div> `);

            let button = witnessHTML.find("#witnessDelete");
            $(button).click(function () {
                let division = button.closest('#witness')
                division.remove()
            });


            var input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "procedure[witness][][name]").val(name);
            witnessHTML = $(witnessHTML).append(input);
            input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "procedure[witness][][rut]").val(rut);
            witnessHTML = $(witnessHTML).append(input);
            input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "procedure[witness][][story]").val(story);
            witnessHTML = $(witnessHTML).append(input);
            input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "procedure[witness][][contact]").val(contact);
            witnessHTML = $(witnessHTML).append(input);
            restartWitnessModal()

            $('#witnesses').append(witnessHTML);

            $("#witnessClose").click()
        }
        else{
            $("#witnessRut").addClass("has-danger");
            $("#witnessRut").addClass("is-invalid");
            $('#witness-invalid-rut').removeAttr('hidden');
            $('#witness-invalid-rut').removeAttr('style');
        }
    });

    const Toast = Swal.mixin({
        toast: true,
        position: 'bottom-end',
        showConfirmButton: false,
        timer: 3000,
        timerProgressBar: true,
    });
    
    function checkInputs(){
        let invalidField = false;
        let invalidDate = false
        if($("#procedure_date").val()==""){
            invalidField = true
            $("#procedure_date").addClass("is-invalid");
            $('#form-invalid-date').removeAttr('hidden');
            $('#form-invalid-date').html('Fecha necesaria.');
        }
        if($("#procedure_time").val()==""){
            invalidField = true
            $("#procedure_time").addClass("is-invalid");
            $('#form-invalid-time').removeAttr('hidden');
            $('#form-invalid-time').html('Hora necesaria.');
        }
        else if($("#procedure_date").val() == getCurrentDate()){
            if ($("#procedure_time").val() > getCurrentTime()){
                invalidDate = true;
                $("#procedure_time").addClass("is-invalid");
                $('#form-invalid-time').removeAttr('hidden');
                $('#form-invalid-time').html('Hora invalida.');
            }
        }
        if(!$("#accussed").length){
            invalidField=true
            $('#form-invalid-accussed').removeAttr('hidden');
            $('#form-invalid-accussed').removeAttr('style');
        }
        if($("#procedure_address").val()==""){
            invalidField=true
            $("#procedure_address").addClass("is-invalid");
            $('#form-invalid-address').removeAttr('hidden');
            $('#form-invalid-address').html('Direccion necesaria.');
        }
        if($("#procedure_story").val() == ""){
            invalidField=true
            $("#procedure_story").addClass("is-invalid");
            $('#form-invalid-story').removeAttr('hidden');
            $('#form-invalid-story').html('Relato necesario.');
        }
        if(invalidField){
            Toast.fire({
                icon: 'error',
                title: 'Debes rellenar los campos solicitados!'
            })
        }
        if(invalidDate){
            Toast.fire({
                icon: 'error',
                title: 'La fecha ingresada no puede ser futura!'
            })
        }
    }


    $("#btn-save").click(function () {
        checkInputs()
    });

    $("#btn-send").click(function () {
        checkInputs()
    });

    function getCurrentDate(){
        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth()+1; //January is 0!
        var yyyy = today.getFullYear();
        if(dd<10){
            dd='0'+dd
        }
        if(mm<10){
            mm='0'+mm
        }
        today = yyyy+'-'+mm+'-'+dd;
        return today
    }

    function getCurrentTime(){
        let now = new Date()
        let HH = now.getHours()
        let MM = now.getMinutes()
        HH < 10 ? HH = '0'+HH : HH;
        MM < 10 ? MM = '0'+MM : MM;
        return HH+':'+MM;
    }

    $("#procedure_date").attr("max", getCurrentDate());

    $("#procedure_date").change(function(){
        $("#procedure_date").removeClass("is-invalid");
        $('#form-invalid-date').attr("hidden",true);
    });

    $("#procedure_time").change(function(){
        $("#procedure_time").removeClass("is-invalid");
        $('#form-invalid-time').attr("hidden",true);
        if($("#procedure_date").val() == getCurrentDate()){
            if ($("#procedure_time").val() > getCurrentTime()){
                $("#procedure_time").addClass("is-invalid");
                $('#form-invalid-time').removeAttr('hidden');
                $('#form-invalid-time').html('Hora invalida.');
            }
        }
    });

    $("#procedure_address").change(function(){
        $("#procedure_address").removeClass("is-invalid");
        $('#form-invalid-address').attr("hidden",true);
    });

    $("#procedure_story").change(function(){
        $("#procedure_story").removeClass("is-invalid");
        $('#form-invalid-story').attr("hidden",true);
    });


    var singlePhoto = $("#single-photo").clone();
    $("#delete_photo").remove();

    $('#add_photo_btn').click(function () {

        let photoHTML = singlePhoto.clone()

        let delBtn = photoHTML.find('#delete_photo');
        $(delBtn).click(function () {
            let division = $(delBtn).closest('#single-photo')
            division.remove()
        });
        $('#photos').append(photoHTML)
    });

    var singleVideo = $("#single-video").clone();
    $("#delete_video").remove();

    $('#add_video_btn').click(function () {

        let videoHTML = singleVideo.clone()

        let delBtn = videoHTML.find('#delete_video');
        $(delBtn).click(function () {
            let division = $(delBtn).closest('#single-video')
            division.remove()
        });
        $('#videos').append(videoHTML)
    });

    var singleDocument = $("#single-document").clone();
    $("#delete_document").remove();

    $('#add_document_btn').click(function () {

        let documentHTML = singleDocument.clone()

        let delBtn = documentHTML.find('#delete_document');
        $(delBtn).click(function () {
            let division = $(delBtn).closest('#single-document')
            division.remove()
        });
        $('#documents').append(documentHTML)
    });

});