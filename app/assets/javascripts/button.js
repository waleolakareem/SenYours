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

  var mess = $('.mess_bod').attr('class')
  if (mess) {
    window.scrollTo(0,document.body.scrollHeight, 'slow');
  }


  // setTimeout(function() {
  //   window.location.reload();
  // }, 10000);

    // For scaling
  // $('#states-of-country').change(function () {
  //   var input_state = $(this);
  //   var cities_of_state = $("#cities-of-state");

  //   if($(this).val() == "") {
  //     cities_of_state.html("");

  //   } else {
  //     $.getJSON('/cities/' + $(this).val(), function (data) {
  //     // cities_of_state.empty();
  //     var opt = '<option value="" selected="">Select Your City</option>';
  //     console.log(data);
  //     if(data.length == 0){

  //     } else {
  //       data.forEach(function(i) {
  //         opt += "<option value="+ i +">" + i + '</option>';
  //         cities_of_state.html(opt);
  //       });
  //     }
  //   });
  //   }
  // });
  // Cliend side verify
  // $('#micropost_picture').bind('change', function() {
  //   var size_in_megabytes = this.files[0].size/1024/1024;
  //   if (size_in_megabytes > 5) {
  //     alert('Maximum file size is 5MB. Please choose a smaller file.');
  //   }
  // });

});
