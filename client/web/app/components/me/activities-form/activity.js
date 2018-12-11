import Component from '@ember/component';
import { computed } from '@ember/object';

export default Component.extend({
  tagName: 'div',
  classNames: ['card',  'activities-form-activity', 'rounded-0'],
  classNameBindings: ['selected:border-success'],
  selected: computed('selection.[]', 'model.name', function() {
    return this.selection.includes(this.model.name);
  }),
  click() {
    this.action(this.model.name, !this.selected);
  }
});
