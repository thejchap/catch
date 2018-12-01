import Controller from '@ember/controller';

export default Controller.extend({
  actions: {
    calendarUpdateOccurrence(occurrence, props, isPreview) {
      occurrence.setProperties(props);

      if (isPreview) {
        return;
      }
    }
  }
});
