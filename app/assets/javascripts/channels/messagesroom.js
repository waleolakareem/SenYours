document.addEventListener("turbolinks:load", function() {
    setTimeout(function() {
        messageTyping();
    }, 1000);
});

function messageTyping() {
    $('.emoji-wysiwyg-editor.mess_descrip').on('keyup',function () {
        App.message.typing($('#user_id').val())
    })
}
