import Controller from '@ember/controller';
import Noty from 'noty';
import Availability from 'catch/models/availability';
import { inject as service } from '@ember/service';
import { inject as controller } from '@ember/controller';
import { computed } from '@ember/object';
import { run } from '@ember/runloop';

const { next } = run;

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

      next(() => {
        availability.save(this.apollo).then(() => {
          new Noty({
            text: 'Gym session added',
            theme: 'bootstrap-v4',
            layout: 'bottomRight',
            type: 'info',
            timeout: 1000
          }).show();
        });
      });
    },
    calendarUpdateOccurrence(availability, props, isPreview) {
      if (availability.isSaving) {
        return;
      }

      availability.setProperties(props);

      if (isPreview) {
        return;
      }

      next(() => {
        availability.save(this.apollo).then(() => {
          new Noty({
            text: 'Gym session updated',
            theme: 'bootstrap-v4',
            layout: 'bottomRight',
            type: 'info',
            timeout: 1000
          }).show();
        });
      });
    }
  }
});