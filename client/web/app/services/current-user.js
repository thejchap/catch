import Service, { inject as service } from '@ember/service';
import RSVP from 'rsvp';
import { set } from '@ember/object';
import me from './current-user/queries/me'
import meUpdate from './current-user/queries/me-update'

const { resolve } = RSVP;

export default Service.extend({
  session: service(),
  store: service(),
  apollo: service(),

  update(variables) {
    const mutation = meUpdate;

    const opts = {
      mutation,
      variables,
      refetchQueries: ['availabilities']
    };

    return this.apollo.mutate(opts, 'meUpdate.me').then((data) => {
      set(this, 'data', data);
      return data;
    });
  },

  load() {
    if (this.session.isAuthenticated) {
      return this.apollo.query({ query: me }, 'me').then((data) => {
        set(this, 'data', data);
        return data;
      });
    }

    return resolve();
  }
});
