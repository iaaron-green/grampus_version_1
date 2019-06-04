const getIsAuthenticated = state => state.auth.isAuthenticated;
const getToken = state => state.auth.token;

export default { getIsAuthenticated, getToken };
