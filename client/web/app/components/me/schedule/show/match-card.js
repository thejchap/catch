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
  activities: computed('node.activities.[]', 'parent.activities.[]', function() {
    return this.parent.activities.map((name) => {
      const activity = this.activity.build(name);

      return {
        activity,
        matched: this.node.activities.includes(activity.name)
      };
    }).sortBy('matched').reverse();
  })
});
