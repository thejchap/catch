import Controller from '@ember/controller';
import { inject as service } from '@ember/service';
import { inject as controller } from '@ember/controller';
import { computed, setProperties } from '@ember/object';
import { run } from '@ember/runloop';

const { next } = run;
const { reads } = computed;

export default Controller.extend({
  apollo: service(),

  me: controller(),

  availabilities: reads('me.model'),

  actions: {
    calendarSelectOccurrence({ modelId }) {
      this.transitionToRoute('me.schedule.show', modelId);
    },
    calendarAddOccurrence(attrs) {
      next(() => this.send('availabilityAdded', attrs));
    },
    calendarUpdateOccurrence(availability, props, isPreview) {
      setProperties(availability, props);

      if (isPreview) {
        return;
      }

      next(() => this.send('availabilityUpdated', availability));
    }
  }
});
