import Service from '@ember/service';
import gql from 'graphql-tag';
import { inject as service } from '@ember/service';
import { merge } from '@ember/polyfills';

const query = gql`
  query activities {
    __type(name: "Activity") {
      enumValues {
        name
      }
    }
  }
`;

const META = {
  BOULDER: {
    label: 'Boulder',
    copy: 'Trade beta or give eachother spots on hard problems'
  },
  LEAD: {
    label: 'Lead',
    copy: 'Taking whippers is no fun when there\'s nobody at the other end of the rope...'
  },
  TOPROPE: {
    label: 'Top Rope',
    copy: 'Trade belays on your top rope projects and training sessions'
  },
  WORKOUT: {
    label: 'Workout/Yoga',
    copy: 'Looking for a spotter or yoga buddy? Look no further'
  }
};

export default Service.extend({
  apollo: service(),

  all() {
    return this.apollo.query({ query }, '__type.enumValues').then((result) => {
      return result.map((value) => {
        const meta = META[value.name]
        const { copy, label } = meta;
        return merge(value, { copy, label });
      });
    });
  }
});
