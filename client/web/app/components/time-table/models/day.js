import Object, { computed } from '@ember/object';
import { A } from '@ember/array';

const { alias } = computed;
const LABELS = [
  'Sun',
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat'
];

const Day = Object.extend({
  occurrences: computed('calendar.occurrences.@each.startsAt', function() {
    const { index } = this;

    return this.calendar.occurrences.filter((occurrence) => {
      const { day } = occurrence;
      return day == index;
    });
  }),
  occurrencePreview: computed('calendar.occurrencePreview.day', function() {
    const preview = this.calendar.occurrencePreview;

    if (!preview || preview.day !== this.index) {
      return;
    }

    return preview;
  }),
  label: computed('index', function() {
    return LABELS[this.index];
  })
});

Day.reopenClass({
  buildWeek({ calendar }) {
    let week = A([]);

    for (let index = 0; index < 7; index++) {
      week.pushObject(Day.create({ calendar, index }));
    }

    return week;
  }
});

export default Day;
