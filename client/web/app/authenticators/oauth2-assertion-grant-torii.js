import { inject as service } from '@ember/service';
import { run } from '@ember/runloop';
import { isEmpty } from '@ember/utils';
import {
  merge,
  assign as emberAssign
} from '@ember/polyfills';
import { Promise } from 'rsvp';
import Oauth2PasswordGrant from 'ember-simple-auth/authenticators/oauth2-password-grant';

const assign = emberAssign || merge;

export default Oauth2PasswordGrant.extend({
  torii: service(),

  serverTokenEndpoint: '/oauth/token',

  authenticate(provider) {
    return this.get('torii').open(provider).then((auth) => {
      const { serverTokenEndpoint } = this;
      const data = {
        grant_type: 'assertion',
        provider:   provider,
        assertion:  auth.accessToken
      };

      return new Promise((resolve, reject) =>{
        this.makeRequest(serverTokenEndpoint, data).then((response) =>{
          run(() => {
            if (!this._validate(response)) {
              reject('access_token is missing in server response');
            }

            const expiresAt = this._absolutizeExpirationTime(response['expires_in']);
            this._scheduleAccessTokenRefresh(response['expires_in'], expiresAt, response['refresh_token']);
            if (!isEmpty(expiresAt)) {
              response = assign(response, { 'expires_at': expiresAt });
            }

            resolve(response);
          });
        });
      });
    });
  }
});
