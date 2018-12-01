import Component from '@ember/component';
import { computed, set } from '@ember/object';
import Model from './models/model';
import { htmlSafe } from '@ember/string';

const { reads } = computed;

export default Component.extend({
  classNames: ['time-table-table', 'd-flex', 'flex-column'],
  days: reads('model.days'),
  timeSlots: reads('model.timeSlots'),
  labeledTimeSlots: computed('timeSlots.[]', function() {
    return this.get('timeSlots').filter((_, index) => (index % 2) === 0);
  }),
  timeSlotLabelStyle: computed('timeSlotHeight', function() {
    return htmlSafe(`height: ${2 * this.timeSlotHeight}px;`);
  }),
  timeSlotStyle: computed('timeSlotHeight', function() {
    return htmlSafe(`height: ${this.timeSlotHeight}px`);
  }),
  init() {
    this._super(...arguments);
    set(this, 'model', Model.create({ component: this }));
  },
  didInsertElement() {
    set(this, 'referenceElement', this.$('#time-table-content'));
  }
});
