import Route from '@ember/routing/route';
import { inject as service } from '@ember/service';
import gql from 'graphql-tag';

const query = gql`
query locations {
  locations {
    modelId
    id
    name
    lat
    lng
  }
}
`;

export default Route.extend({
  apollo: service(),
  currentUser: service(),
  redirect() {
    if (this.currentUser.data.location) {
      return this.transitionTo('welcome.activities');
    }
  },
  model() {
    return this.apollo.query({ query }, 'locations');
  }
});
