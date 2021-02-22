
import { $ } from "@rails/ujs";
import { createApp } from "vue";
import "./$.min.js";

/**
 * This will safely create and mount a Vue component
 * to the dom if it's mount point exists.
 * @param component
 * @param {string} selector the mount point
 */
export function safeMount(component, selector) {
  if (elementExists(selector)) {
    try {
      createApp(component).mount(selector);
    } catch (e) {
      console.error("Failed to mount vue component.", e);
    }
  }
}

/**
 * Checks if an element exists in the dom.
 * @param {string} selector this can be any valid css selector.
 */
function elementExists(selector) {
  const el = $(selector);
  const isAnArray = Array.isArray(el);
  return (isAnArray && el.length > 0) || (!isAnArray && !!el);
}