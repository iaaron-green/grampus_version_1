import axios from 'axios';

const setJWTToken = token => {
  if (token) {
    axios.defaults.headers.common.Authorization = token;
  } else {
    axios.defaults.headers.common.Authorization = null;
  }
};

export default setJWTToken;
