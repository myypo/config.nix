// ==UserScript==
// @name         YouTube Shorts Blocker
// @namespace    http://tampermonkey.net/
// @version      0.1.2
// @description  Blocks the YouTube shorts from appearing.
// @author       Aiden Charles
// @license      MIT
// @match        https://www.youtube.com/*
// @require      https://code.jquery.com/jquery-3.4.1.slim.min.js
// @grant        none
// @downloadURL https://update.greasyfork.org/scripts/471062/YouTube%20Shorts%20Blocker.user.js
// @updateURL https://update.greasyfork.org/scripts/471062/YouTube%20Shorts%20Blocker.meta.js
// ==/UserScript==

(function () {
  console.log("YouTube Shorts blocker script is running!");

  setInterval(function () {
    $("ytd-reel-shelf-renderer").hide();
    $("a[title='Shorts']").hide();
    $('a[href^="/shorts/"]').closest("ytd-video-renderer").hide();
    $('span:contains("Shorts")')
      .closest("#content.ytd-rich-section-renderer")
      .hide();
  }, 1000);
})();
