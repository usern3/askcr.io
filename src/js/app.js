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
  })
})