$(document).ready(function() {
  // This onClick event handler toggles the arrow in the transaction summary from down to up, while also hiding and revealing the appointment details.
  $(".arrow").on("click", function(event) {
    if (this.classList[3] == "down") {
      $(this).css('display', 'none');
      $(this).next().css('display', 'block');
      var info = $(this).closest('.appointment-container').next('.appointment-info')[0];
      console.log(info);
      $(info).slideToggle('fast');
    } else if (this.classList[3] == "up") {
      $(this).css('display', 'none');
      $(this).prev().css('display', 'block');
      var info = $(this).closest('.appointment-container').next('.appointment-info')[0];
      $(info).slideToggle('fast');
    }
  });
});
