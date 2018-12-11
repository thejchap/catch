import { helper } from '@ember/component/helper';
import moment from 'moment';

export function formatMinutes(params/*, hash*/) {
  return moment().startOf('day').add(params[0], 'minutes').format('h:mma');
}

export default helper(formatMinutes);
