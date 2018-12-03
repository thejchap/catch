import Object, { set } from '@ember/object';
import myAvailabilities from "catch/models/availability/queries/my-availabilities";
import availabilityCreate from "catch/models/availability/queries/availability-create";
import availabilityUpdate from "catch/models/availability/queries/availability-update";

const Availability = Object.extend({
  save(apollo) {
    const { startsAt, endsAt, day, id } = this;

    set(this, 'isSaving', true);

    const mutation = this.id ? availabilityUpdate : availabilityCreate;
    let variables = { startsAt, endsAt, day }

    if (id) {
      variables.id = id;
    }

    apollo.mutate({ mutation, variables }, 'availability').finally(() => {
      set(this, 'isSaving', false)
    });
  }
});

Availability.reopenClass({
  watchQuery(apollo) {
    return apollo.watchQuery({
      query: myAvailabilities
    }, 'availabilities.edges');
  }
});

export default Availability;
