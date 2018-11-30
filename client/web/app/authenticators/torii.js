import { inject as service } from '@ember/service';
import { Promise } from 'rsvp';
import Torii from 'ember-simple-auth/authenticators/torii';

export default Torii.extend({
  torii: service(),

  authenticate() {
    return this._super(...arguments).then((auth) => {
      const { provider } = auth;

      return new Promise((resolve) => {
        window.FB.api('/me', { fields: 'email,first_name,last_name,picture' }, (me) => {
          resolve({ me, auth, provider });
        });
      });
    });
  }
});
