import Object, { computed } from '@ember/object';
import { A } from '@ember/array';

const { alias, sum } = computed;

const DURATION = 30;
const MINUTES_IN_DAY = 60*24;

const TimeSlot = Object.extend({
  start: alias('time'),
  end: computed('start', function() {
    return this.start + this.duration;
  }),
  inRange(start, end) {
    return this.start >= start && this.end <= end;
  },
  next() {
    return TimeSlot.create({
      time: this.time + DURATION,
      duration: DURATION
    });
  }
});

TimeSlot.reopenClass({
  buildDay() {
    let day = A([]);
    let cur = this.create({ time: 0, duration: DURATION });

    while (cur.inRange(0, MINUTES_IN_DAY)) {
      day.pushObject(cur);
      cur = cur.next();
    }

    return day;
  }
});

export default TimeSlot;
