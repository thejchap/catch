import Route from '@ember/routing/route';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';
import { A } from '@ember/array';

export default Route.extend(AuthenticatedRouteMixin, {
  model() {
    return A();
  }
});
