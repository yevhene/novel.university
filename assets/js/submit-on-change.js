$(document).on("change", "[js-submit-on-change]", function() {
  const form = $(this).parents("form");
  form.submit();
});
