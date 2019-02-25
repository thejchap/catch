import Service, { inject as service } from '@ember/service';
import { set, getProperties } from '@ember/object';
import availabilityCreate from "catch/models/availability/queries/availability-create";
import availabilityUpdate from "catch/models/availability/queries/availability-update";
import availabilityDelete from "catch/models/availability/queries/availability-delete";
import query from "catch/models/availability/queries/my-availabilities";
import Availability from 'catch/models/availability';

export const POLL_INTERVAL = 1 * 1000;

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
          activities: [],
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
      optimisticResponse
    };

    return this.proxy.mutate(opts, 'availabilityCreate.availability');
  },

  del({ id }) {
    const mutation = availabilityDelete;
    const variables = { id };

    const update = (proxy) => {
      const data = proxy.readQuery({ query });
      const avail = data.availabilities.findBy('id', id);
      data.availabilities.removeObject(avail);
      proxy.writeQuery({ query, data });
    };

    const optimisticResponse = {
      __typename: "Mutation",
      availabilityDelete: {
        __typename: "AvailabilityDelete",
        success: true
      }
    };

    const opts = {
      mutation,
      variables,
      update,
      optimisticResponse
    };

    return this.proxy.mutate(opts, 'availabilityDelete.success');
  },

  update(availability) {
    const mutation = availabilityUpdate;
    const variables = getProperties(
      availability,
      'day',
      'startsAt',
      'endsAt',
      'id'
    )

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
      optimisticResponse
    };

    return this.proxy.mutate(opts, 'availabilityUpdate.availability');
  },

  watchQuery(proxy) {
    set(this, 'proxy', proxy);

    return proxy.watchQuery({ query }, 'availabilities');
  }
});
