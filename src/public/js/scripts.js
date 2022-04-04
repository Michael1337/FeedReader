$(document).ready(function () {
  isTablet = false;
  if ($("#isTablet").is(":visible")) {
    isTablet = true;
  } else {
    isTablet = false;
  }

  if ($("#hasNews").val() == true && isTablet) {
    // var snd = new Audio("appointed.mp3"); // buffers automatically when created
    // var promise = snd.play(); // doesn't work on Tablets...
  }

  /*    var regex = /\s*,\s*!/;
      var keywords = $('#keywords').val().trim().split(regex); // check if not empty first
      $(".context").mark(keywords, {
          "separateWordSearch": false
      });*/

  $('#saveKeywords').click(function () {
    saveKeywords();
  });

  $('#shuffle').click(function () {
    shuffle();
  });

  $('#refresh').click(function () {
    refreshPage()();
  });

  $('#sendNews').click(function () {
    sendNews();
  });

  $('#sendPhrase').click(function () {
    sendPhrase();
  });

  refreshTimeout = setTimeout('refreshPage()', 10 * 60 * 1000);

  $('.modal').on('show.bs.modal', function (e) {
    pauseRefresh();
  });

  $('.modal').on('hidden.bs.modal', function (e) {
    resumeRefresh();
  });

  setTimeout(function () {
    fixTwitterWidth();
  }, 500);

});

function fixTwitterWidth() {
  var style = document.createElement('style');
  style.setAttribute('type', 'text/css');
  style.innerHTML = ".TweetAuthor-decoratedName { max-width: 100%; } ";

  var host = $('.twitter-tweet.twitter-tweet-rendered');

  for (var i = 0; i < host.length; i++) {
    host[i].shadowRoot.append(style.cloneNode(true));
  }
}

function saveKeywords() {
  /*    var regex = /\s*,\s*!/;
      var keywords = $('#keywords').val().trim().split(regex);
      $(".context").mark(keywords, {
          "separateWordSearch": false
      });*/
  $('#keywordsForm').submit();
}

function sendNews() {
  $('#newsForm').submit();
}

function sendPhrase() {
  $('#loginForm').submit();
}

function shuffle() {
  $('#shuffleForm').submit();
}

function refreshPage() {
  if (isTablet) {
    window.location = window.location.href;
  }
}

function pauseRefresh() {
  clearTimeout(refreshTimeout);
}

function resumeRefresh() {
  refreshTimeout = setTimeout('refreshPage()', 10 * 60 * 1000);
}
