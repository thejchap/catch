import Component from '@ember/component';
import { computed, set, setProperties } from '@ember/object';
import { htmlSafe } from '@ember/string';
import { run } from '@ember/runloop';
import $ from 'jquery';
import interact from 'interactjs'

const { reads } = computed;

export default Component.extend({
  classNames: ['time-table-occurrence'],
  attributeBindings: ['style'],
  classNameBindings: ['isInteracting'],
  calendar: reads('model.calendar'),
  referenceElement: reads('table.referenceElement'),
  preview: reads('calendar.occurrencePreview'),
  top: computed('startTime', 'timeSlotHeight', function() {
    return (this.model.startsAt / 30) * this.timeSlotHeight;
  }),
  height: computed('duration', 'timeSlotHeight', function() {
    return this.timeSlotHeight * (this.model.duration / 30);
  }),
  style: computed('top', function() {
    return htmlSafe(`top: ${this.top}px; height: ${this.height}px`);
  }),
  didInsertElement() {
    this._setupInteractions();
  },
  _setupInteractions() {
    const interactable = interact(this.$()[0]);
    this._setupDragHandler(interactable);
  },
  _setupDragHandler(interactable) {
    interactable.draggable({
      onmove:   (event) => { run(this, this._dragMove,  event); },
      onstart:  (event) => { run(this, this._dragStart, event); },
      onend:    (event) => { run(this, this._dragEnd,   event); }
    });
  },
  _dragStart(event) {
    const $el = this.$();
    const $ref = $(this.referenceElement);

    setProperties(this, {
      isInteracting:                true,
      dragVerticalOffset:           0,
      dragTopDistance:              $ref.offset().top - $el.offset().top,
      dragBottomDistance:           ($ref.offset().top + $ref.height()) - ($el.offset().top + $el.height()),
      'calendar.occurrencePreview': this.model.copy()
    });
  },
  _dragEnd(event) {
    set(this, 'isInteracting', false);
  },
  _dragMove(event) {
    set(this, 'dragVerticalOffset', this.dragVerticalOffset + event.dy);

    console.log(this.dragVerticalOffset);
  }
});
