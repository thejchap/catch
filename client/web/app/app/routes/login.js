import Route from '@ember/routing/route';
import UnauthenticatedRouteMixin from 'ember-simple-auth/mixins/unauthenticated-route-mixin';

export default Route.extend(UnauthenticatedRouteMixin, {
  actions: {
    authenticateWithFacebook() {
      this.get('session').authenticate(
        'authenticator:oauth2-assertion-grant-torii',
        'facebook-connect'
      );
    },
  }
});
