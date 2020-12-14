$(document).on('turbolinks:load', function() {
    $(function() {
        $("#police_man_rut").rut({formatOn: 'keyup', ignoreControlKeys: false});
    });
    $(function() {
        $("#prosecutor_rut").rut({formatOn: 'keyup', ignoreControlKeys: false});
        $("#prosecutor_rut").change(function () {
            if($.validateRut($("#prosecutor_rut").val())){

            }
        })
    });
});