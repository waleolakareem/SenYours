$(document).on('turbolinks:load', function() {
  // This onClick event handler toggles the arrow in the tasks section from down to up, while also hiding and revealing the full list of tasks.
  console.log("ready");
  $(document).on("click", ".collapsible", function(event) {
      var tasks = this.nextElementSibling;
      $(tasks).slideToggle('fast');
      var downArrow = $(".task-arrow")[0];
      var upArrow = $(".task-arrow")[1];
      downArrow.style.display = (downArrow.style.display === 'none' ? 'block' : 'none');
      upArrow.style.display = (upArrow.style.display === 'none' ? 'block' : 'none');
  });
});
