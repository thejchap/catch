import Route from '@ember/routing/route';
import { inject as service } from '@ember/service';

export default Route.extend({
  session: service(),

  actions: {
    authenticateWithFacebook() {
      this.session.authenticate(
        'authenticator:oauth2-assertion-grant-torii',
        'facebook-connect'
      );
    },
  }
});
