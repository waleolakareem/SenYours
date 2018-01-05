$(document).on('turbolinks:load', function(){
  $( "#comp" ).click(function() {
    $( '.companionMember').show()
  });

  $( "#sen" ).click(function() {
    $( '.companionMember').hide()
  });
});
