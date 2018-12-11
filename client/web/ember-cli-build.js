'use strict';

const EmberApp = require('ember-cli/lib/broccoli/ember-app');

module.exports = function(defaults) {
  let app = new EmberApp(defaults, {
    'ember-cli-bootstrap-4': {
      js: null
    },
    'ember-google-maps': {
      only: ['marker']
    },
    fingerprint: {
      exclude: ['et-bg-dark.jpg'],
      prepend: 'https://d158rsbl5gvkw0.cloudfront.net/' + EmberApp.env() + '/client/web/ember/build/'
    }
  });

  app.import('vendor/feather.min.js');

  // Use `app.import` to add additional libraries to the generated
  // output files.
  //
  // If you need to use different assets in different
  // environments, specify an object as the first parameter. That
  // object's keys should be the environment name and the values
  // should be the asset to use in that environment.
  //
  // If the library that you are including contains AMD or ES6
  // modules that you would like to import into your application
  // please specify an object with the list of modules as keys
  // along with the exports of each module as its value.

  return app.toTree();
};
