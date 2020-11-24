$(document).on('turbolinks:load', function() {
    if($("#borradorTitulo").length){
        if(gon.sector){
            $('#procedure_sector').val(gon.sector);
        }

        $('.delete_crime').each(function(){
            $(this).click(function(){
                let division = $(this).closest('#old_crime');
                let crimeID = $("#crimeID");
                division.remove()
            })
        });

        $('#accussedDelete').click(function () {
            let division = $(this).closest('#accussed');
            let accussedID = $("#")
            division.remove()
        });

        $('#victimDelete').click(function () {
            let division = $(this).closest('#victim');
            division.remove()
        });

        $('#witnessDelete').click(function () {
            let division = $(this).closest('#witness');
            division.remove()
        });
    }

});
