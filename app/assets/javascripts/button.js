$(document).on('turbolinks:load', function(){

  // To hide buttons when not on home page to scroll to where needed.
  var className = $('.home_div').attr('class')
  if(className) {
    $('.press').show();
  } else {
    $('.press').hide();
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
  //chatra
  (function(d, w, c) {
    w.ChatraID = 'CraZHDarmzW2h7DBC';
    var s = d.createElement('script');
    w[c] = w[c] || function() {
      (w[c].q = w[c].q || []).push(arguments);
    };
    s.async = true;
    s.src = (d.location.protocol === 'https:' ? 'https:': 'http:')
    + '//call.chatra.io/chatra.js';
    if (d.head) d.head.appendChild(s);
  })(document, window, 'Chatra');

});

