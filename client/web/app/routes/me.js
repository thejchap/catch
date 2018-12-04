import Route from '@ember/routing/route';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';
import Availability from 'catch/models/availability';
import { RouteQueryManager } from "ember-apollo-client";
import { inject as service } from '@ember/service';

export default Route.extend(AuthenticatedRouteMixin, RouteQueryManager, {
  currentUser: service(),
  session: service(),

  authenticationRoute: 'index',

  beforeModel() {
    this._super(...arguments);
    return this._loadCurrentUser();
  },

  model() {
    return Availability.watchQuery(this.apollo);
  },

  _loadCurrentUser() {
    return this.currentUser.load().catch(() => {
      this.session.invalidate();
    });
  }
});
