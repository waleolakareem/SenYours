$(document).on('turbolinks:load', function(){
  console.log("what")
  var className = $('.home_div').attr('class')
  if(className) {
    $('.press').show()
  } else {
    $('.press').hide()
  }
  $(".press").click(function(e) {
      e.preventDefault();
      var aid = $(this).attr("href");
      $('html,body').animate({scrollTop: $(aid).offset().top},'slow');
    });
});
