import Component from '@ember/component';
import { computed } from '@ember/object';
import Model from './models/model';

const { reads } = computed;

export default Component.extend({
  days: reads('model.days'),

  init() {
    this._super(...arguments);
    this.model = Model.create({ component: this });
  }
});
