import Service, { inject as service } from '@ember/service';
import RSVP from 'rsvp';
import { set } from '@ember/object';
import gql from 'graphql-tag';

const { resolve, reject } = RSVP;

const query = gql`
  query me {
    me {
      id
      firstName
      lastName
      pictureUrl
      location {
        name
        lat
        lng
      }
      settings {
        activities
      }
    }
  }
`;

export default Service.extend({
  session: service(),
  store: service(),
  apollo: service(),

  load() {
    if (this.session.isAuthenticated) {
      return this.apollo.query({ query }, 'me').then((data) => {
        set(this, 'data', data);
        return data;
      });
    }

    return resolve();
  }
});
