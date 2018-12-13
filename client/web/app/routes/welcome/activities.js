import Route from '@ember/routing/route';
import { inject as service } from '@ember/service';

export default Route.extend({
  activity: service(),
  currentUser: service(),
  redirect() {
    if (!this.currentUser.data.location) {
      return this.transitionTo('welcome.location');
    } else if (this.currentUser.data.settings.activities.length > 0) {
      return this.transitionTo('me');
    }
  },
  model() {
    return this.activity.all();
  }
});
