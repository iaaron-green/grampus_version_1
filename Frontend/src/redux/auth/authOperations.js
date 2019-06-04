import axios from 'axios';

import setJWTToken from '../../securityUtils/setJWTToken';
import setBaseURL from '../../configs/base-url';
import actions from './authActions';

const signUp = credentials => dispatch => {
  dispatch(actions.signUpRequest());
  setBaseURL();
  axios
    .post('/api/users/register', credentials)
    .then(data => {
      dispatch(actions.signUpSuccess(data));
    })
    .catch(error => dispatch(actions.signUpError(error)));
};

const signIn = credentials => dispatch => {
  dispatch(actions.loginRequest());
  setBaseURL();
  axios
    .post('/api/users/login', credentials)
    .then(({ data }) => {
      setJWTToken(data.token);
      dispatch(actions.loginSuccess(data.token));
    })
    .catch(error => dispatch(actions.loginError(error)));
};

export default {
  signUp,
  signIn,
};
