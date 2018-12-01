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
  day: reads('model.day'),
  referenceElement: reads('table.referenceElement'),
  firstColWidth() {
    return $('.time-table-first-col:first').outerWidth();
  },
  dayWidth() {
    return $('.time-table-day-col:first').outerWidth();
  },
  preview: reads('calendar.occurrencePreview'),
  top: computed('model.startsAt', 'timeSlotHeight', function() {
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
  click() {
    alert('test');
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
    const { model, preview: { content: { startsAt, endsAt, day } } } = this
    this.attrs.onUpdate(model.content, { startsAt, endsAt, day }, false);

    setProperties(this, {
      isInteracting: false,
      dragVerticalOffset: null,
      dragTopDistance: null,
      dragBottomDistance: null,
      'calendar.occurrencePreview': null
    });
  },
  _dragMove(event) {
    set(this, 'dragVerticalOffset', this.dragVerticalOffset + event.dy);

    const dragTimeSlotOffset = this._dragTimeSlotOffset();
    const dragDayOffset = this._dragDayOffset(event);
    const startsAt = this.model.startsAt + dragTimeSlotOffset;
    const endsAt = startsAt + this.model.duration;
    const day = Math.max(Math.min(this.model.day + dragDayOffset, 6), 0);

    this._updatePreview({ startsAt, endsAt, day });
  },
  _updatePreview(attrs) {
    if (!this._validatePreviewChanges(attrs)) {
      return;
    }

    this.attrs.onUpdate(this.preview.content, attrs, true);
  },
  _validatePreviewChanges(attrs) {
    return true;
  },
  _dragDayOffset(event) {
    const $ref = $(this.referenceElement);
    const offsetX = this._clamp(event.pageX - $ref.offset().left - this.firstColWidth(), 0, $ref.width() - 1);
    const result = Math.floor(offsetX / this.dayWidth()) - this.day;
    return result;
  },
  _dragTimeSlotOffset() {
    const verticalDrag = this._clamp(
      this.dragVerticalOffset,
      this.dragTopDistance,
      this.dragBottomDistance
    );

    const offset = Math.floor(verticalDrag / this.timeSlotHeight);
    const result = offset * this.timeSlotDuration;
    return result;
  },
  _clamp(number, min, max) {
    return Math.max(min, Math.min(number, max));
  }
});
