import Component from '@ember/component';
import { computed } from '@ember/object';

const { reads } = computed;

export default Component.extend({
  days: reads('model.days'),
  timeSlots: reads('model.timeSlots')
});
