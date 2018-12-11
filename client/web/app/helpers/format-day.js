import { helper } from '@ember/component/helper';
import moment from 'moment';

export function formatDay(params/*, hash*/) {
  return moment().weekday(params[0]).format('dddd');
}

export default helper(formatDay);
