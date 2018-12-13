import Route from '@ember/routing/route';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';
import Noty from 'noty';
import { RouteQueryManager } from "ember-apollo-client";
import { inject as service } from '@ember/service';

export default Route.extend(AuthenticatedRouteMixin, RouteQueryManager, {
  currentUser: service(),
  session: service(),
  apollo: service(),
  availability: service(),

  authenticationRoute: 'index',

  beforeModel() {
    this._super(...arguments);
    return this._loadCurrentUser();
  },

  model() {
    return this.availability.watchQuery(this.apollo);
  },

  _loadCurrentUser() {
    return this.currentUser.load().catch(() => {
      this.session.invalidate();
    }).then((user) => {
      if (!user.location) {
        this.transitionTo('welcome');
      }
    });
  },

  actions: {
    availabilityAdded(variables) {
      this.availability.create(variables);
    },
    availabilityUpdated(availability) {
      this.availability.update(availability);
    },
    availabilityDestroyed(availability) {
      this.availability.del(availability);
    }
  }
});
