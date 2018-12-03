import Component from '@ember/component';
import { run } from '@ember/runloop'

const { next } = run;

export default Component.extend({
  tagName: 'li',
  classNames: ['nav-item'],
  didInsertElement() {
    next(() => window.feather.replace());
  }
});
