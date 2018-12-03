import Controller from '@ember/controller';
import Availability from 'catch/models/availability';
import { inject as service } from '@ember/service';
import { inject as controller } from '@ember/controller';
import { computed } from '@ember/object';

export default Controller.extend({
  apollo: service(),

  app: controller(),

  availabilities: computed('app.model.@each.length', function() {
    return this.app.model.getEach('node').map((node) => {
      return Availability.create(node);
    });
  }),

  actions: {
    calendarSelectOccurrence({ modelId }) {
      this.transitionToRoute('app.schedule.show', modelId);
    },
    calendarAddOccurrence(attrs) {
      const availability = Availability.create(attrs);
      this.availabilities.pushObject(availability);
      availability.save(this.apollo);
    },
    calendarUpdateOccurrence(availability, props, isPreview) {
      availability.setProperties(props);

      if (isPreview) {
        return;
      }

      availability.save(this.apollo);
    }
  }
});
