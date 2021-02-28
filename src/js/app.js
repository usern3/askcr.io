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
require("./admin.js");

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
  loadCharts();
});
document.addEventListener('turbolinks:load', loadCharts);
document.addEventListener('turbolinks:click', unloadCharts);

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

/**
 * Binds a menu element to it's panel so that clicking the menu opens the panel.
 * @param {*} menu
 * @param {*} menuPanel
 */
function bindMenuPanel(menu, menuPanel, openedClasses, closedClasses, sticky) {
  let isOpen = true;
  const openClasses = openedClasses.split(' ');
  const closeClasses = closedClasses.split(' ');
  closeClasses.push('pointer-events-none');

  const open = () => {
    if (isOpen == true) return;
    isOpen = true;
    openClasses.forEach((c) => {
      menuPanel.classList.add(c);
    });
    closeClasses.forEach((c) => {
      menuPanel.classList.remove(c);
    });
    menuPanel.trigger('opened');
  };
  const close = () => {
    if (isOpen == false) return;
    isOpen = false;
    closeClasses.forEach((c) => {
      menuPanel.classList.add(c);
    });
    openClasses.forEach((c) => {
      menuPanel.classList.remove(c);
    });
    menuPanel.trigger('closed');
  };

  menu.on('click', () => {
    if (isOpen) {
      close();
    } else {
      open();
    }
  });

  // add some utility listeners so the menu can programatialy closed/opened.
  menu.on('close', close);
  menu.on('open', open);

  // close this menu if the escape key is pressed.
  $.on('keyup', (e) => {
    if (e.data.key === 'Escape') {
      close();
    }
  });

  // close the menu if the user clicks away
  $.on('click', e => {
    if (!isOpen || sticky) return;

    const menuRect = menu.getBoundingClientRect();
    const panelRect = menuPanel.getBoundingClientRect();

    if (!isPointInRect(e.data.clientX, e.data.clientY, menuRect) && !isPointInRect(e.data.clientX, e.data.clientY, panelRect)) {
      close();
    }
  });

  // Start closed to ensure state is consistent.
  close();
  return menuPanel;
}

function isPointInRect(x, y, rect) {
  return x > rect.left && x < rect.right && y > rect.top && y < rect.bottom
}

/**
 * Registers a menu with it's panel.
 * The panel selector should be the same as the menu selector but with `-panel` affixed to it.
 * @param {*} menuSelector
 * @param {boolean} sticky the menu can only be close programaticaly or by clicking the menu button again.
 */
function registerMenu(menuSelector, openedClasses = 'transition ease-out duration-200 transform scale-100', closedClasses = 'transition ease-in duration-75 transform hidden scale-95', sticky = false) {
  const m = $(menuSelector);
  const p = $(`${menuSelector}-panel`);
  if (!m || m.length === 0 || !p || p.length === 0) {
    // Return an empty node list so things break silently
    return $('-missing-element-');
  } else {
    return bindMenuPanel(m, p, openedClasses, closedClasses, sticky);
  }
}