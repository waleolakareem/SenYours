
$(document).ready(function() {

$("i").hover(function() {
    $(".comp_description").show();
  }, function() {
    $(".comp_description").hide();
 })
});

// TEST
//On-click attempts:

// $(document).on('click', 'profile_drop', function(){
//   $(".comp_description").show();
// });
//
//
// $(document).ready(function() {
//
// $("profile_drop").click(function() {
//     $(".comp_description").show();
//   }, function() {
//     $(".comp_description").hide();
//  })
// });
