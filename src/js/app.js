/* eslint no-console:0 */

// Rails Unobtrusive JavaScript (UJS) is *required* for links in Lucky that use DELETE, POST and PUT.
// Though it says "Rails" it actually works with any framework.
require("@rails/ujs").start();

// Turbolinks is optional. Learn more: https://github.com/turbolinks/turbolinks/
require("turbolinks").start();

// If using Turbolinks, you can attach events to page load like this:
//
// document.addEventListener("turbolinks:load", function() {
//   ...
// })
require("./$.min.js");

import hljs from 'highlight.js/lib/core';

import 'highlight.js/styles/github-gist.css';

import javascript from 'highlight.js/lib/languages/javascript';
hljs.registerLanguage('javascript', javascript);

import typescript from 'highlight.js/lib/languages/typescript';
hljs.registerLanguage('typescript', typescript);

import css from 'highlight.js/lib/languages/css';
hljs.registerLanguage('css', css);

import scss from 'highlight.js/lib/languages/scss';
hljs.registerLanguage('scss', scss);

import crystal from 'highlight.js/lib/languages/crystal';
hljs.registerLanguage('crystal', crystal);

import bash from 'highlight.js/lib/languages/bash';
hljs.registerLanguage('bash', bash);

import json from 'highlight.js/lib/languages/json';
hljs.registerLanguage('json', json);

import sql from 'highlight.js/lib/languages/sql';
hljs.registerLanguage('sql', sql);

import erb from 'highlight.js/lib/languages/erb';
hljs.registerLanguage('erb', erb);

import dockerfile from 'highlight.js/lib/languages/dockerfile';
hljs.registerLanguage('dockerfile', dockerfile);

import http from 'highlight.js/lib/languages/http';
hljs.registerLanguage('http', http);

import less from 'highlight.js/lib/languages/less';
hljs.registerLanguage('less', less);

import llvm from 'highlight.js/lib/languages/llvm';
hljs.registerLanguage('llvm', llvm);

import yaml from 'highlight.js/lib/languages/yaml';
hljs.registerLanguage('yaml', yaml);

import xml from 'highlight.js/lib/languages/xml';
hljs.registerLanguage('xml', xml);

import html from 'highlight.js/lib/languages/xml';
hljs.registerLanguage('html', html);

document.addEventListener('turbolinks:load', function() {
  document.querySelectorAll('pre code').forEach((block) => {
      hljs.highlightBlock(block)
  });
  bindFlashMessages();
});

// capture document events
bindDocumentEvent('click');
bindDocumentEvent('keyup');
bindDocumentEvent('keydown');
bindDocumentEvent('keypress');


/**
 * Binds a document event to $ so that you can listen to events like `$.on('click', (evt) => {...})`.
 * @param string name the name of the event without an `on` prefix. e.g. `click`.
 */
function bindDocumentEvent(name) {
  document[`on${name}`] = (evt) => {
    evt = evt || window.event;
    $.trigger(name, evt);
  };
}


function bindFlashMessages() {
  $('[flash-close-target]').on('click', (e) => {
    const duration = 250;
    const flashId = $('#close').getAttribute('flash-close-target').toString();
    const classes = `transition ease-in-out duration-${duration} transform hidden scale-95`.split(' ');
    const flash = $("#" + flashId);
    flash.classList
    classes.forEach((c) => {
      flash.classList.add(c);
      setTimeout(() => {
        flash.toggleClass = 'hidden h-0'
      }, duration);
    });
  });
}