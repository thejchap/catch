import Component from '@ember/component';
import { computed } from '@ember/object';

const { alias, empty } = computed;

export default Component.extend({
  init() {
    this._super(...arguments);
    this.set('center', this.activeSelection || this.all.firstObject);
  },
  activeSelection: computed('selection', function() {
    if (!this.selection) {
      return;
    }

    return {...this.selection}
  }),
  isClean: computed('selection', 'activeSelection', function() {
    const active = this.get('activeSelection.modelId');
    const sel = this.get('selection.modelId');
    return active === sel;
  }),
  saveDisabled: alias('isClean'),
  buttonText: 'Save',
  noSelection: empty('selection'),
  actions: {
    locationSelected(locationId) {
      this.set('activeSelection', this.all.find((loc) => {
        return loc.modelId === locationId;
      }));

      this.set('center', this.activeSelection);
    },
    save() {
      this.onSave(this.activeSelection);
    }
  }
});
