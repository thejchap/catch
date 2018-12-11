import Controller from '@ember/controller';
import { computed } from '@ember/object';
import { inject as service } from '@ember/service';

const { reads } = computed;

export default Controller.extend({
  currentUser: service(),
  settings: reads('currentUser.data.settings'),
  actions: {
    selectLocation(loc) {
      console.log(loc);
    }
  }
});
