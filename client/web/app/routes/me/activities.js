import Route from '@ember/routing/route';
import { inject as service } from '@ember/service';
import gql from 'graphql-tag';

const query = gql`
  query activities {
    __type(name: "Activity") {
      enumValues {
        name
      }
    }
  }
`;
export default Route.extend({
  apollo: service(),

  model() {
    return this.apollo.query({ query }, '__type.enumValues');
  }
});
