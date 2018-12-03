import Route from '@ember/routing/route';
import { inject as service } from '@ember/service';

export default Route.extend({
  session: service(),

  redirect() {
    const path = this.session.isAuthenticated ? 'app' : 'login';
    return this.transitionTo(path);
  }
});
