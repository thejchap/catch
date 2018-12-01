import Controller from '@ember/controller';
import Object from '@ember/object';

export default Controller.extend({
  actions: {
    calendarAddOccurrence(occurrence) {
      const { startsAt, endsAt, day } = occurrence;
      this.model.pushObject(Object.create({ startsAt, endsAt, day }));
    },
    calendarUpdateOccurrence(occurrence, props, isPreview) {
      occurrence.setProperties(props);

      if (isPreview) {
        return;
      }
    }
  }
});
