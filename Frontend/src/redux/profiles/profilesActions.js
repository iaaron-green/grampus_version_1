import types from './profilesActionTypes';

const fetchProfilesRequest = () => ({
  type: types.PROFILES_FETCH_REQUEST,
});

const fetchProfilesSuccess = profiles => ({
  type: types.PROFILES_FETCH_SUCCESS,
  payload: profiles,
});

const fetchProfilesError = error => ({
  type: types.PROFILES_FETCH_ERROR,
  payload: error,
});

export default {
  fetchProfilesRequest,
  fetchProfilesSuccess,
  fetchProfilesError,
};
