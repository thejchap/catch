import Component from '@ember/component';
import Model from './time-table/models/model';
import { set } from '@ember/object';

export default Component.extend({
  classNames: ['time-table', 'd-flex', 'flex-column'],
  timeSlotHeight: 20,
  timeSlotDuration: 30,
  init() {
    this._super(...arguments);
    set(this, 'model', Model.create({ component: this }));
  },
  actions: {
    addOccurrence(startsAt, day) {
      const occurrence = this.model.createOccurrence({ startsAt, day });
      this.attrs.onAddOccurrence(occurrence.content);
    },
  }
});
