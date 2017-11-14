function lazyLoad(element) {
  const url = element.getAttribute("js-lazy-content");
  fetch(url, { credentials: "include" })
    .then(response => response.text())
    .then(html => replaceElementWithHtml(element, html));
}

function replaceElementWithHtml(element, html) {
  const replacement = document.createRange().createContextualFragment(html);
  element.parentElement.replaceChild(replacement, element);
}

$(function() {
  const lazyElements = document.querySelectorAll("[js-lazy-content]");
  for (let element of lazyElements) {
    lazyLoad(element);
  }
});
