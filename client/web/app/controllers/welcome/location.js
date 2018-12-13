import Controller from '@ember/controller';
import { computed } from '@ember/object';
import { inject as service } from '@ember/service';

const { reads } = computed;

export default Controller.extend({
  currentUser: service(),
  actions: {
    save(loc) {
      const settingsLocation = loc.modelId;

      this.currentUser.update({ settingsLocation }).then(() => {
        this.transitionToRoute('welcome.activities');
      });
    }
  }
});
