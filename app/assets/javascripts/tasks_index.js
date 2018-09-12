$(document).on('turbolinks:load', function() {
  // This onClick event handler toggles the arrow in the tasks section from down to up, while also hiding and revealing the full list of tasks.
  console.log("ready");
  $(document).on("click", ".collapsible", function(event) {
      console.log(this);
      var tasks = this.nextElementSibling;
      $(tasks).slideToggle('fast');
  });
});
