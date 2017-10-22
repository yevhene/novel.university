$(document).on("click", "[js-submit-repository]", function() {
  const repository = $(this).attr('js-submit-repository');
  $(this).parents(".form-group").find("input").val(repository);
});
