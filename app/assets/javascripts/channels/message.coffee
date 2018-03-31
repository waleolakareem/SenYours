App.message = App.cable.subscriptions.create {
  channel: "MessageChannel"
  conversation_id: window.location.pathname.split('/')[2]
},
  subscribed: ->
    @perform 'subscribed',conversation_id:window.location.pathname.split('/')[2]

  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log('data',data)
    if(data["action"]=='typing')
      if(data["user_id"]!=$('#user_id').val())
        $('.typing_message').show()
        setTimeout (-> $('.typing_message').hide()), 1000
        console.log('typing')
    else
      if(data['user'].id.toString()==$('#user_id').val())
        element='<div class="row form_div mess_div current_user">' +
          '<div class="col-lg-1 col-md-2 col-3">' +
          '<img src="' + data['user']['avatar'].thumb.url + '" class= "mess_responsive_image mess_img_circle img-fluid">' +
          '</div>' +
          '<div class="col-lg-10 col-md-10 col-9 mess_display">' +
          '<div>'
      else
        element='<div class="row form_div mess_div">' +
          '<div class="col-lg-1 col-md-2 col-3">' +
          '<img src="' + data['user']['avatar'].thumb.url + '" class= "mess_responsive_image mess_img_circle img-fluid">' +
          '</div>' +
          '<div class="col-lg-10 col-md-10 col-9 mess_display">' +
          '<div>'

      if(data['user'].id.toString()==$('#user_id').val())
        element += '<strong>me </strong>'
      else
        element += '<a href="/users/'+data['user'].id+'"><strong>' +  data['user'].first_name + ' </strong></a>'
      element+=
        '</div>' +
        '<div>' +
        '<i class="right triangle icon edit_tag"></i>' +
        data.message.body +
        '</div><div class="message_time_div">' +data.message_time +
        '</div></div>'
      $('.mess_div:last').after(element)
      window.scrollTo(0, document.body.scrollHeight);


  typing: (data)->
    console.log('typing')
    @perform 'typing',conversation_id:window.location.pathname.split('/')[2],user_id:data

