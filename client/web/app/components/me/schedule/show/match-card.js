import Component from '@ember/component';
import { computed } from '@ember/object';
import { inject as service } from '@ember/service';

const { alias } = computed;

export default Component.extend({
  activity: service(),
  classNames: ['card', 'shadow-sm'],
  classNameBindings: ['model.bestMatch:border-success'],
  node: alias('model.node'),
  user: alias('node.user'),
  activitiesIntersection: computed('model.activitiesIntersection', function() {
    return this.model.activitiesIntersection.map((name) => {
      return this.activity.build(name);
    });
  })
});
