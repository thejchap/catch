import Route from '@ember/routing/route';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';
import { A } from '@ember/array';
import Object from '@ember/object';

export default Route.extend(AuthenticatedRouteMixin, {
  model() {
    return A([Object.create({ id: 1, startsAt: 30, endsAt: 90, day: 2 })]);
  }
});
