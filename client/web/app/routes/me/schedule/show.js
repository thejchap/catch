import Route from '@ember/routing/route';

export default Route.extend({
  model({ id }) {
    return this.modelFor('me').findBy('modelId', id);
  }
});
