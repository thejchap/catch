import EmberRouter from '@ember/routing/router';
import config from './config/environment';

const Router = EmberRouter.extend({
  location: config.locationType,
  rootURL: config.rootURL
});

Router.map(function() {
  this.route('welcome', function() {
    this.route('location');
    this.route('activities');
  });
  this.route('me', function() {
    this.route('schedule', function () {
      this.route('show', { path: '/:id' });
    });
    this.route('activities');
    this.route('location');
    this.route('account');
  });
});

export default Router;
