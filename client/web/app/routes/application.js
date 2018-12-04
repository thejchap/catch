import Route from '@ember/routing/route';
import $ from 'jquery';
import { inject as service } from '@ember/service';
import { run } from '@ember/runloop';
import ApplicationRouteMixin from 'ember-simple-auth/mixins/application-route-mixin';

const { next } = run;

export default Route.extend(ApplicationRouteMixin, {
  currentUser: service(),
  session: service(),

  activate() {
    $('#decoy').remove();
  },

  routeAfterAuthentication: 'me',

  afterModel() {
    this._super(...arguments);

    if (!this.session.isAuthenticated) {
      return;
    }

    next(() => this.currentUser.load());
  }
});
