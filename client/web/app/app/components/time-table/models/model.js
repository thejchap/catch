import Object, { computed } from '@ember/object';
import Day from './day';
import TimeSlot from './time-slot';
import { merge } from '@ember/polyfills';
import OccurrenceProxy from './occurrence-proxy';
import { A } from '@ember/array';

export default Object.extend({
  days: computed(function() {
    return Day.buildWeek({ calendar: this });
  }),
  timeSlots: computed(function() {
    return TimeSlot.buildDay();
  }),
  occurrences: computed('component.occurrences.[]', function() {
    let proxies = A();

    this.component.occurrences.forEach((content) => {
      proxies.pushObject(OccurrenceProxy.create({ calendar: this, content }));
    });

    return proxies;
  }),
  createOccurrence(attrs) {
    const content = merge({ endsAt: attrs.startsAt + 120 }, attrs);

    return OccurrenceProxy.create({
      calendar: this,
      content: Object.create(content)
    });
  },
});
