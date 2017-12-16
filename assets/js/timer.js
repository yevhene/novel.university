class Timer {
  constructor(element) {
    this.$element = $(element);
    this.finishedAtSeconds = Date.parse(this.$element.attr("js-timer")) / 1000;
    this.setupTimer();
  }

  setupTimer() {
    const seconds = this.secondsLeft();

    if (seconds > 0) {
      this.interval = setInterval(() => this.updateTimer(), 500);
      this.updateTimer();
      this.$element.trigger("timer:started");
    } else {
      this.renderTime(0);
      this.$element.trigger("timer:not-started");
    }
  }

  updateTimer() {
    let seconds = this.secondsLeft();
    if (seconds <= 0) {
      clearInterval(this.interval);
      this.$element.trigger("timer:finished");
      seconds = 0;
    }

    this.renderTime(seconds);
  }

  renderTime(seconds) {
    this.$element.text(formatTime(seconds));
  }

  secondsLeft() {
    const target = this.finishedAtSeconds;
    const now = new Date().getTime() / 1000;
    return target - now;
  }
}


function formatTime(seconds) {
  const minutes = Math.floor(seconds / 60).toString();
  seconds = Math.floor(seconds % 60).toString().padStart(2, "0");

  return `${minutes}:${seconds}`;
}

$(document).ready(function() {
  const timersElements = document.querySelectorAll("[js-timer]");
  for (let timerElement of timersElements) {
    const timer = new Timer(timerElement);
    $(timerElement)
      .data("timer", timer)
      .on("timer:finished", () => location.reload());
  }
});
