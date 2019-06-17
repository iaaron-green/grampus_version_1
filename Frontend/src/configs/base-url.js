import axios from 'axios';

const setBaseURL = () => {
  // axios.defaults.baseURL = 'http://10.11.1.48:8080';
  axios.defaults.baseURL = 'http://localhost:8080';
};

export default setBaseURL;
