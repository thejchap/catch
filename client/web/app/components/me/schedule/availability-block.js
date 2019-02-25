import Occurrence from 'catch/components/time-table/table/occurrence';
import { computed, observer } from '@ember/object';

const { alias } = computed;

export default Occurrence.extend({
  classNames: ['availability-block'],
  classNameBindings: ['hasMatches:has-matches'],
  availability: alias('model.content'),
  hasMatches: alias('availability.matches.any'),
  notifyInteracting: observer('isInteracting', function() {
    this.onInteractionChange(this.isInteracting);
  }),
  actions: {
    destroy() {
      this.onDestroy(this.availability);
    }
  }
});
