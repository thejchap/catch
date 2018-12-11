import Service, { inject as service } from '@ember/service';
import { getObservable } from 'ember-apollo-client';
import { setProperties, set, getProperties } from '@ember/object';
import availabilityCreate from "catch/models/availability/queries/availability-create";
import availabilityUpdate from "catch/models/availability/queries/availability-update";
import query from "catch/models/availability/queries/my-availabilities";
import Availability from 'catch/models/availability';

export default Service.extend({
  apollo: service(),

  create(variables) {
    const availability = Availability.create(variables);
    const mutation = availabilityCreate;
    const { startsAt, endsAt, day } = availability;
    const id = Math.round(Math.random() * -1000000);

    const optimisticResponse = {
      __typename: "Mutation",
      availabilityCreate: {
        __typename: "AvailabilityCreate",
        availability: {
          __typename: "Availability",
          startsAt,
          endsAt,
          day,
          matches: {
            any: false,
            count: 0,
            edges: [],
            __typename: "AvailabilityMatchConnection"
          },
          modelId: id,
          id: `gid://catch/Availability/${id}`
        }
      }
    };

    const update = (proxy, { data: { availabilityCreate: { availability } } }) => {
      const data = proxy.readQuery({ query });
      data.availabilities.push(availability);
      proxy.writeQuery({ query, data });
    };

    const opts = {
      mutation,
      variables,
      update,
      optimisticResponse,
      refetchQueries: ['availabilities']
    };

    return this.proxy.mutate(opts, 'availabilityCreate.availability');
  },

  update(availability) {
    const mutation = availabilityUpdate;
    const variables = getProperties(availability, 'day', 'startsAt', 'endsAt', 'id')

    const optimisticResponse = {
      __typename: "Mutation",
      availabilityUpdate: {
        __typename: "AvailabilityUpdate",
        availability
      }
    };

    const opts = {
      mutation,
      variables,
      optimisticResponse,
      refetchQueries: ['availabilities']
    };

    return this.proxy.mutate(opts, 'availabilityUpdate.availability');
  },

  watchQuery(proxy) {
    set(this, 'proxy', proxy);
    return proxy.watchQuery({ query }, 'availabilities');
  }
});
