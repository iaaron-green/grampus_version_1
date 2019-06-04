import { combineReducers } from 'redux';
// actionTypes
import types from './userActionTypes';

const userId = (state = null, { type, payload }) => {
  switch (type) {
    case types.USER_FETCH_SUCCESS:
      return payload.id;

    case types.USER_FETCH_ERROR:
      return null;

    default:
      return state;
  }
};

const userName = (state = null, { type, payload }) => {
  switch (type) {
    case types.USER_FETCH_SUCCESS:
      return payload.username;

    case types.USER_FETCH_ERROR:
      return null;

    default:
      return state;
  }
};

const fullName = (state = null, { type, payload }) => {
  switch (type) {
    case types.USER_FETCH_SUCCESS:
      return payload.fullName;

    case types.USER_FETCH_ERROR:
      return null;

    default:
      return state;
  }
};

const jobTitle = (state = null, { type, payload }) => {
  switch (type) {
    case types.USER_FETCH_SUCCESS:
      return payload.jobTitle;

    case types.USER_FETCH_ERROR:
      return null;

    default:
      return state;
  }
};

export default combineReducers({
  userId,
  userName,
  fullName,
  jobTitle,
});
