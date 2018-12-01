import Component from '@ember/component';
import { computed } from '@ember/object';
import { htmlSafe } from '@ember/string';

export default Component.extend({
  classNames: ['time-table-occurrence'],
  attributeBindings: ['style'],
  top: computed('startTime', 'timeSlotHeight', function() {
    return (this.model.startsAt / 30) * this.timeSlotHeight;
  }),
  height: computed('duration', 'timeSlotHeight', function() {
    return this.timeSlotHeight * (this.model.duration / 30);
  }),
  style: computed('top', function() {
    return htmlSafe(`top: ${this.top}px; height: ${this.height}px`);
  })
});
