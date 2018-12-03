import Route from '@ember/routing/route';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';
import Availability from 'catch/models/availability';
import { RouteQueryManager } from "ember-apollo-client";

export default Route.extend(AuthenticatedRouteMixin, RouteQueryManager, {
  model() {
    return Availability.watchQuery(this.apollo);
  }
});
