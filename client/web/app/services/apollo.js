import ApolloService from 'ember-apollo-client/services/apollo';
import { computed } from "@ember/object";
import { inject as service } from "@ember/service";
import { setContext } from "apollo-link-context";

export default ApolloService.extend({
  session: service(),

  link: computed(function() {
    const httpLink = this._super(...arguments);
    const authLink = setContext(this._authorize.bind(this));
    return authLink.concat(httpLink);
  }),

  _authorize() {
    if (!this.session.isAuthenticated) {
      return {};
    }

    const { access_token } = this.session.data.authenticated;
    return { headers: { 'Authorization': `Bearer ${access_token}` } };
  }
});
