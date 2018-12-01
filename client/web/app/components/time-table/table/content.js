import Component from '@ember/component';
import { computed } from '@ember/object';

const { reads } = computed;

export default Component.extend({
  classNames: ['time-table-content'],
  days: reads('model.days'),
  timeSlots: reads('model.timeSlots')
});
