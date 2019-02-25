import Component from '@ember/component';
import { computed } from '@ember/object';
import { A } from '@ember/array';
import { compare } from '@ember/utils';

const { alias } = computed;

export default Component.extend({
  tagName: 'ul',
  classNames: ['list-group'],
  buttonText: 'Save',
  activeSelection: computed('selection.[]', function() {
    let arr = A();
    this.selection.forEach((item) => arr.pushObject(item));
    return arr;
  }),
  isClean: computed('selection.[]', 'activeSelection.[]', function() {
    return compare(this.selection.sort(), this.activeSelection.sort()) === 0;
  }),
  saveDisabled: alias('isClean'),
  actions: {
    save() {
      this.onSave(this.activeSelection.sort());
    },
    activityToggled(activity, selected) {
      if (selected) {
        this.activeSelection.pushObject(activity);
      } else {
        this.activeSelection.removeObject(activity);
      }
    }
  }
});
