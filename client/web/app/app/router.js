import EmberRouter from '@ember/routing/router';
import config from './config/environment';

const Router = EmberRouter.extend({
  location: config.locationType,
  rootURL: config.rootURL
});

Router.map(function() {
  this.route('login');
  this.route('app', { path: 'me' },  function() {
    this.route('schedule', function () {
      this.route('show', { path: '/:id' });
    });
    this.route('activities');
    this.route('location');
  });
});

export default Router;
