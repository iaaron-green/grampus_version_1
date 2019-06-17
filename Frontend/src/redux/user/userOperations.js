import axios from 'axios';
import jwtDecode from 'jwt-decode';

// actions
import actions from './userActions';
import setJWTToken from '../../securityUtils/setJWTToken';
import setBaseURL from '../../configs/base-url';

const getCurrentUser = token => dispatch => {
  dispatch(actions.fetchUserRequest());
  setBaseURL();
  setJWTToken(token);

  const decoded = jwtDecode(token);
  axios
    .get(`/api/profiles/${decoded.id}`)
    .then(({ data }) => {
      console.log(data);
      dispatch(actions.fetchUserSuccess(data.profile));
    })
    .catch(error => dispatch(actions.fetchUserError(error)));
};

const updateCurrentUser = userData => dispatch => {
  dispatch(actions.fetchUserRequest());
  setBaseURL();
  setJWTToken(userData.token);

  axios
    .post(`/api/profiles/`, userData.update)
    .then(({ data }) => {
      dispatch(actions.fetchUserSuccess(data));
    })
    .catch(error => dispatch(actions.fetchUserError(error)));
};

export default {
  getCurrentUser,
  updateCurrentUser,
};
