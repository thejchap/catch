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
  model() {
    return this.apollo.query({ query }, 'locations');
  }
});
