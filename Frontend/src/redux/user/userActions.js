import types from './userActionTypes';

const fetchUserRequest = () => ({
  type: types.USER_FETCH_REQUEST,
});

const fetchUserSuccess = user => ({
  type: types.USER_FETCH_SUCCESS,
  payload: user,
});

const fetchUserError = error => ({
  type: types.USER_FETCH_ERROR,
  payload: error,
});

export default {
  fetchUserRequest,
  fetchUserSuccess,
  fetchUserError,
};
