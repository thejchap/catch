import Controller from '@ember/controller';
import Object from '@ember/object';

export default Controller.extend({
  actions: {
    calendarSelectOccurrence(occurrence) {
      this.transitionToRoute('app.schedule.show', occurrence.id);
    },
    calendarAddOccurrence(occurrence) {
      const { startsAt, endsAt, day } = occurrence;
      const id = Math.round(Math.random() * (4000 - 1000) + 1000);
      this.model.pushObject(Object.create({ startsAt, endsAt, day, id }));
    },
    calendarUpdateOccurrence(occurrence, props, isPreview) {
      occurrence.setProperties(props);

      if (isPreview) {
        return;
      }
    }
  }
});
