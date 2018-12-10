import Controller from '@ember/controller';
import { inject as service } from '@ember/service';
import { computed } from '@ember/object';

export default Controller.extend({
  currentUser: service(),
  endsAtLabel: computed('model.endsAt', function() {
    return moment().startOf('day').add(this.model.endsAt, 'minutes').format('h:mma');
  }),
  startsAtLabel: computed('model.startsAt', function() {
    return moment().startOf('day').add(this.model.startsAt, 'minutes').format('h:mma');
  }),
});
