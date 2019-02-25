import Controller from '@ember/controller';
import { inject as service } from '@ember/service';
import Noty from 'noty';

export default Controller.extend({
  currentUser: service(),
  actions: {
    save(loc) {
      const settingsLocation = loc.modelId;

      this.currentUser.update({ settingsLocation }).then(() => {
        new Noty({ text: 'Location updated successfully' }).show();
      });
    }
  }
});
