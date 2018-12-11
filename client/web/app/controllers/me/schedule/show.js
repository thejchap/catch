import Controller from '@ember/controller';
import { inject as service } from '@ember/service';
import { computed } from '@ember/object';
import moment from 'moment';

export default Controller.extend({
  currentUser: service()
});
