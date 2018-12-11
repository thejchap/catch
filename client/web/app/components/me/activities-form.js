import Component from '@ember/component';
import { set } from '@ember/object';
import { A } from '@ember/array';

export default Component.extend({
  tagName: 'ul',
  classNames: ['list-group'],
  init() {
    this._super(...arguments);

    let selection = A();

    this.selection.forEach((item) => {
      selection.pushObject(item);
    });

    set(this, 'userSelection', this.selection);
    set(this, 'selection', selection);
  },
});
