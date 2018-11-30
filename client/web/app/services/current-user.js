import Service, { inject as service } from '@ember/service';
import RSVP from 'rsvp';

const { resolve, reject } = RSVP;

export default Service.extend({
  session: service(),
  store: service(),
  load() {
    if (this.get('session.isAuthenticated')) {
      this.user = {};
      return resolve();
    }

    return resolve();
  }
});
