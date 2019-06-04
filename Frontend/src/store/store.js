import { createStore, applyMiddleware, combineReducers } from 'redux';
import { composeWithDevTools } from 'redux-devtools-extension';
import thunk from 'redux-thunk';
import { persistStore, persistReducer } from 'redux-persist';
import storage from 'redux-persist/lib/storage';
// reducers
import profilesReducer from '../redux/profiles/profilesReducer';
import userReducer from '../redux/user/userReducer';
import authReducer from '../redux/auth/authReducer';

const rootPersistConfig = {
  key: 'root',
  storage,
  whitelist: 'auth',
};
const sessionPersistConfig = {
  key: 'session',
  storage,
  whitelist: ['token'],
};

const rootReducer = combineReducers({
  profiles: profilesReducer,
  auth: persistReducer(sessionPersistConfig, authReducer),
  user: userReducer,
});

const persistedReducer = persistReducer(rootPersistConfig, rootReducer);
const middlewares = applyMiddleware(thunk);

const enhancer = composeWithDevTools(middlewares);

export const store = createStore(persistedReducer, enhancer);
export const persistor = persistStore(store);
