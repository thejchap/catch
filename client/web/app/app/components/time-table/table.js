import Component from '@ember/component';
import $ from 'jquery';
import { run } from '@ember/runloop';
import { computed, set } from '@ember/object';
import { htmlSafe } from '@ember/string';
import interact from 'interactjs';

const { reads } = computed;

export default Component.extend({
  classNames: ['time-table-table', 'd-flex', 'flex-column'],
  days: reads('model.days'),
  timeSlots: reads('model.timeSlots'),
  dayWidth() {
    return $('.time-table-day-col:first').outerWidth();
  },
  labeledTimeSlots: computed('timeSlots.[]', function() {
    return this.get('timeSlots').filter((_, index) => (index % 2) === 0);
  }),
  timeSlotLabelStyle: computed('timeSlotHeight', function() {
    return htmlSafe(`height: ${2 * this.timeSlotHeight}px;`);
  }),
  timeSlotStyle: computed('timeSlotHeight', function() {
    return htmlSafe(`height: ${this.timeSlotHeight}px`);
  }),
  didInsertElement() {
    set(this, 'referenceElement', this.$('#time-table-content'));
    this._setupInteractionListeners();
  },
  _setupInteractionListeners() {
    this.$('#time-table-content').click(this._contentClicked.bind(this));
    const interactable = interact(this.$('#time-table-content')[0]);
    this._setupDragHandler(interactable);
  },
  _setupDragHandler(interactable) {
    return;

    interactable.draggable({
      ignoreFrom:   '.time-table-occurrence',
      hold:         1000,
      onstart:      (event) => { run(this, this._dragStart, event) },
      onmove:       (event) => { run(this, this._dragMove,  event) },
      onend:        (event) => { run(this, this._dragEnd,   event) }
    });
  },

  _dragStart(event) {
    this.attrs.onSelectTimeSlot(60, 1);
  },
  _dragMove(event) {
    console.log(event);
  },
  _dragEnd(event) {
  },

  firstColWidth() {
    return $('.time-table-first-col:first').outerWidth();
  },
  _contentClicked(event) {
    const $target = $(event.target);

    if (!$target.hasClass('available-time-slot')) {
      return;
    }

    const offset = this.$('#time-table-content').offset();
    const offsetX = event.pageX - Math.floor(offset.left + this.firstColWidth());
    const offsetY = event.pageY - Math.floor(offset.top);
    const day = Math.floor(offsetX / this.dayWidth());
    const timeSlotIndex = Math.floor(offsetY / this.timeSlotHeight);
    const timeSlot = this.timeSlots.objectAt(timeSlotIndex);
    this.attrs.onSelectTimeSlot(timeSlot.time, day);
  }
});
