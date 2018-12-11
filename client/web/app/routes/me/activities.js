import Route from '@ember/routing/route';
import { inject as service } from '@ember/service';

export default Route.extend({
  activity: service(),

  model() {
    return this.activity.all();
  }
});
