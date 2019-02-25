import Controller from '@ember/controller';
import { inject as service } from '@ember/service';

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
