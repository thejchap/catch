import Route from '@ember/routing/route';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';
import { inject as service } from '@ember/service';

export default Route.extend(AuthenticatedRouteMixin, {
  currentUser: service(),
  authenticationRoute: 'index',
  beforeModel() {
    this._super(...arguments);
    return this._loadCurrentUser();
  },

  _loadCurrentUser() {
    return this.currentUser.load().catch(() => {
      this.session.invalidate();
    });
  }
});
