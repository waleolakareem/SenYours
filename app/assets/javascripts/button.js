$(document).on('turbolinks:load', function(){
  // To hide buttons when not on home page to scroll to where needed.
  var className = $('.home_div').attr('class')
  if(className) {
    $('.press').show()
  } else {
    $('.press').hide()
  }

  // Scroll to the field needed
  $(".press").click(function(e) {
    e.preventDefault();
    var aid = $(this).attr("href");
    $('html,body').animate({scrollTop: $(aid).offset().top},'slow');
  });

  // Cliend side verify
  // $('#micropost_picture').bind('change', function() {
  //   var size_in_megabytes = this.files[0].size/1024/1024;
  //   if (size_in_megabytes > 5) {
  //     alert('Maximum file size is 5MB. Please choose a smaller file.');
  //   }
  // });

});
