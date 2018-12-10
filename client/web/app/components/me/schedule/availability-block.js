import Occurrence from 'catch/components/time-table/table/occurrence';
import { computed } from '@ember/object';

const { alias } = computed;

export default Occurrence.extend({
  classNames: ['availability-block'],
  classNameBindings: ['hasMatches:has-matches'],
  availability: alias('model.content'),
  hasMatches: alias('availability.matches.any')
});
