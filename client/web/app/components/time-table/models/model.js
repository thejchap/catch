import Object, { computed } from '@ember/object';
import Day from './day';
import TimeSlot from './time-slot';

export default Object.extend({
  days: computed(function() {
    return Day.buildWeek({ calendar: this });
  }),

  timeSlots: computed(function() {
    return TimeSlot.buildDay();
  }),

  occurrences: computed('component.occurrences.[]', function() {
    return this.component.occurrences;
  })
});
