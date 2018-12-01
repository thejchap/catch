import Object, { computed } from '@ember/object';

const { reads } = computed;

const OccurrenceProxy = Object.extend({
  startsAt: reads('content.startsAt'),
  endsAt: reads('content.endsAt'),
  duration: computed('startsAt', 'endsAt', function() {
    return this.endsAt - this.startsAt;
  }),
  copy() {
    const { calendar, startsAt, endsAt } = this;

    return OccurrenceProxy.create({
      calendar,
      content: Object.create({
        startsAt,
        endsAt
      })
    });
  }
});

export default OccurrenceProxy;
