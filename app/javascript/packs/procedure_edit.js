$(document).on('turbolinks:load', function() {
    if($("#borradorTitulo").length){
        if(gon.sector){
            $('#procedure_sector').val(gon.sector);
        }

        $('.delete_crime').each(function(){
            $(this).click(function(){
                let division = $(this).closest('#old_crime');
                let crimeID = division.find("#crimeID").html();
                division.remove();

                let input = $("<input>")
                    .attr("type", "hidden")
                    .attr("name", "procedure[deletedCrimes][][id]").val(crimeID);
                $('#crimes').append(input);
            })
        });

        $('[id=accussedDelete]').click(function () {
            let division = $(this).closest('#accussed');
            let accussedID = division.find('#accussedID').html();
            division.remove();

            let input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "procedure[deletedAccusseds][][id]").val(accussedID);
            $('#accuseds').append(input);
        });

        $('[id=victimDelete]').click(function () {
            let division = $(this).closest('#victim');
            let victimID = division.find("#victimID").html();
            division.remove();

            let input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "procedure[deletedVictims][][id]").val(victimID);
            $('#victims').append(input);
        });

        $('[id=witnessDelete]').click(function () {
            let division = $(this).closest('#witness');
            let witnessID = division.find("#witnessID").html();
            division.remove();

            let input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "procedure[deletedWitnesses][][id]").val(witnessID);
            $('#witnesses').append(input);
        });
    }

});
