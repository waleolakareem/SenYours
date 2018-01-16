$(document).on('turbolinks:load', function(){
  console.log("waiting")
  $('.btn-warning').click(function() {
    var treat = $(this).children("p").text()
    console.log(treat)
    var user = $(".current").html()
    console.log(user)
    $.ajax({
      url: `/users/${user}/available_days`,
      method: 'POST',
      data:({
          "date":`${treat}`,
          "user_id":`${user}`,
          "comment":"I love my job"
      })
    })
  })
});
  // var update = function(){
  // $(".update").on("click", ".col-lg-2", (function(){
  //   $(this).parent().siblings().children().attr("id","update_need")
  //   var need_id = $(this).attr("id")
  //   $("#update_need").attr('id',need_id)

  //   $.ajax({
  //     url: `/answers/design/${need_id}`,
  //     method: $("form").attr("method")
  //   }).done(function(res){
  //     console.log(res)
  //     $('#fill').val(res.filter)
  //   });

  // })
  // )}
