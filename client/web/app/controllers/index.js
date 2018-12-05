import Controller from '@ember/controller';
import { inject as service } from '@ember/service';
import ENV from 'catch/config/environment';

export default Controller.extend({
  currentUser: service(),
  session: service(),
  prelaunch: ENV.APP.prelaunch
});
