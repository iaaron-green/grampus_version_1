import types from './authActionTypes';

const signUpRequest = () => ({
  type: types.SIGNUP_REQUEST,
});

const signUpSuccess = data => ({
  type: types.SIGNUP_SUCCESS,
  payload: data,
});

const signUpError = error => ({
  type: types.SIGNUP_ERROR,
  payload: error,
});

const loginRequest = () => ({
  type: types.LOGIN_REQUEST,
});

const loginSuccess = data => ({
  type: types.LOGIN_SUCCESS,
  payload: data,
});

const loginError = error => ({
  type: types.LOGIN_ERROR,
  payload: error,
});

const signOut = () => ({
  type: types.SIGN_OUT,
});

export default {
  signUpRequest,
  signUpSuccess,
  signUpError,
  loginRequest,
  loginSuccess,
  loginError,
  signOut,
};
