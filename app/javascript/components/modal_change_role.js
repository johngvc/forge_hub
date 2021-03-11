import 'jquery'

const changeRoleModal = () => {
    $('#changeStatusModal').on('show.bs.modal', function(e) {

        //get data-id attribute of the clicked element
        console.log(participantId)
        var participantId = $(e.relatedTarget).data('participant-id');
        var participantName = $(e.relatedTarget).data('participant-name');
    
        //Mudar a action para o participant certo
        $(e.currentTarget).find('#changeRoleForm').attr('action', `/participants/update_status/${participantId}`);
        //O texto com o nome do participant certo
        $(e.currentTarget).find('#exampleModalLabel').html(`Select the new role of ${participantName}`);
    });
}

export { changeRoleModal };