import Object, { computed } from '@ember/object';

const { reads } = computed;

const OccurrenceProxy = Object.extend({
  startsAt: reads('content.startsAt'),
  endsAt: reads('content.endsAt'),
  day: reads('content.day'),
  duration: computed('startsAt', 'endsAt', function() {
    return this.endsAt - this.startsAt;
  }),
  copy() {
    const { calendar, startsAt, endsAt, day } = this;

    return OccurrenceProxy.create({
      calendar,
      content: Object.create({
        startsAt,
        endsAt,
        day
      })
    });
  }
});

export default OccurrenceProxy;
