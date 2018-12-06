import Controller from '@ember/controller';
import Noty from 'noty';
import Availability from 'catch/models/availability';
import { inject as service } from '@ember/service';
import { inject as controller } from '@ember/controller';
import { computed, setProperties } from '@ember/object';
import { run } from '@ember/runloop';

const { next } = run;

export default Controller.extend({
  apollo: service(),

  me: controller(),

  availabilities: computed.reads('me.model'),

  actions: {
    calendarSelectOccurrence({ modelId }) {
      this.transitionToRoute('me.schedule.show', modelId);
    },
    calendarAddOccurrence(attrs) {
      const availability = Availability.create(attrs);
      this.me.model.pushObject(availability);

      next(() => {
        availability.save(this.apollo).then(() => {
          new Noty({ text: 'Gym session added' }).show();
        });
      });
    },
    calendarUpdateOccurrence(availability, props, isPreview) {
      if (availability.isSaving) {
        return;
      }

      setProperties(availability, props);

      if (isPreview) {
        return;
      }

      next(() => {
        availability.save(this.apollo).then(() => {
          new Noty({ text: 'Gym session updated' }).show();
        });
      });
    }
  }
});
