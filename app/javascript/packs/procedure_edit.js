$(document).on('turbolinks:load', function() {
    if($("#borradorTitulo").length){
        if(gon.sector){
            $('#procedure_sector').val(gon.sector);
        }

        $('.delete_crime').each(function(){
            $(this).click(function(){
                let division = $(this).closest('#old_crime');
                division.remove();
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

        $("[id=delete_photo_edit]").click(function(){
            let division = $(this).closest("#single-photo-edit");
            let photoID = division.find("#photoID").html();
            division.remove();

            let input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "procedure[deleted_photos][]").val(photoID);
            $('#photos').append(input);
        });
        $("[id=delete_video_edit]").click(function(){
            let division = $(this).closest("#single-video-edit");
            let videoID = division.find("#videoID").html();
            division.remove();

            let input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "procedure[deleted_videos][]").val(videoID);
            $('#videos').append(input);
        });

        $("[id=delete_document_edit]").click(function(){
            let division = $(this).closest("#single-document-edit");
            let documentID = division.find("#documentID").html();
            division.remove();

            let input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "procedure[deleted_documents][]").val(documentID);
            $('#documents').append(input);
        });
    }

});
