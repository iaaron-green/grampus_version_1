import { combineReducers } from 'redux';
// actionTypes
import types from './userActionTypes';

const userId = (state = null, { type, payload }) => {
  switch (type) {
    case types.USER_FETCH_SUCCESS:
      return payload.user.id;

    case types.USER_FETCH_ERROR:
      return null;

    default:
      return state;
  }
};

const userName = (state = null, { type, payload }) => {
  switch (type) {
    case types.USER_FETCH_SUCCESS:
      return payload.user.username;

    case types.USER_FETCH_ERROR:
      return null;

    default:
      return state;
  }
};

const fullName = (state = null, { type, payload }) => {
  switch (type) {
    case types.USER_FETCH_SUCCESS:
      return payload.user.fullName;

    case types.USER_FETCH_ERROR:
      return null;

    default:
      return state;
  }
};

const jobTitle = (state = null, { type, payload }) => {
  switch (type) {
    case types.USER_FETCH_SUCCESS:
      return payload.user.jobTitle;

    case types.USER_FETCH_ERROR:
      return null;

    default:
      return state;
  }
};

const information = (state = null, { type, payload }) => {
  switch (type) {
    case types.USER_FETCH_SUCCESS:
      return payload.information;

    case types.USER_FETCH_ERROR:
      return null;

    default:
      return state;
  }
};

const skills = (state = null, { type, payload }) => {
  switch (type) {
    case types.USER_FETCH_SUCCESS:
      return payload.skills;

    case types.USER_FETCH_ERROR:
      return null;

    default:
      return state;
  }
};

const userPicture = (state = null, { type, payload }) => {
  switch (type) {
    case types.USER_FETCH_SUCCESS:
      return payload.profilePicture;

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
  information,
  skills,
  userPicture,
});
