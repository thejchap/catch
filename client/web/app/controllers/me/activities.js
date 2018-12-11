import Controller from '@ember/controller';
import { computed } from '@ember/object';
import { inject as service } from '@ember/service';
import Noty from 'noty';

const { reads } = computed;

export default Controller.extend({
  currentUser: service(),
  activitySettings: reads('currentUser.data.settings.activities'),
  actions: {
    save(settingsActivities) {
      this.currentUser.update({ settingsActivities }).then(() => {
        new Noty({ text: 'Activities updated successfully' }).show();
      });
    }
  }
});
