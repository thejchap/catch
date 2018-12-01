import Object, { computed } from '@ember/object';

const { reads } = computed;

export default Object.extend({
  startsAt: reads('content.startsAt'),
  endsAt: reads('content.endsAt'),
  duration: computed('startsAt', 'endsAt', function() {
    return this.endsAt - this.startsAt;
  })
});
