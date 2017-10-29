$(document).on("click", "[js-submit-remote]", function() {
  const remote = $(this).attr("js-submit-remote");
  $(this).parents(".form-group").find("input").val(remote);
});
