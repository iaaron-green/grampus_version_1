import axios from 'axios';

import actions from './profilesActions';
import setJWTToken from '../../securityUtils/setJWTToken';
import setBaseURL from '../../configs/base-url';

const fetchAllProfiles = token => dispatch => {
  dispatch(actions.fetchProfilesRequest());
  setBaseURL();
  setJWTToken(token);

  axios
    .get(`/api/profiles/all`)
    .then(({ data }) => {
      dispatch(actions.fetchProfilesSuccess(data));
    })
    .catch(error => dispatch(actions.fetchProfilesError(error)));
};

export default {
  fetchAllProfiles,
};
