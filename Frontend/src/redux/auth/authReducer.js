import { combineReducers } from 'redux';
// actionTypes
import types from './authActionTypes';

const token = (state = null, { type, payload }) => {
  switch (type) {
    case types.LOGIN_SUCCESS:
      return payload;

    case types.LOGIN_ERROR:
    case types.SIGN_OUT:
      return null;

    default:
      return state;
  }
};

const isAuthenticated = (state = false, { type }) => {
  switch (type) {
    case types.LOGIN_SUCCESS:
      return true;

    case types.LOGIN_ERROR:
    case types.SIGN_OUT:
      return false;
    default:
      return state;
  }
};

export default combineReducers({
  token,
  isAuthenticated,
});
