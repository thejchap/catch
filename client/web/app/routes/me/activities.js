import Route from '@ember/routing/route';
import { inject as service } from '@ember/service';

export default Route.extend({
  currentUser: service(),

  actions: {
    save() {
      console.log('test');
      console.log(this.currentUser);
    }
  }
});
