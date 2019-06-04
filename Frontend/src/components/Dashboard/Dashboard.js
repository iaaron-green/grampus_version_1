import React, { Component } from 'react';
import { Switch, Redirect } from 'react-router-dom';
import { connect } from 'react-redux';
// components
import UserNav from '../UserNav/UserNav';

import Profile from './Profile/Profile';
import RatingContainer from './Rating/RatingContainer';
import MyInfo from './MyInfo/MyInfo';
import SmartCalendar from './SmartCalendar/SmartCalendar';

import ProtectedRoute from '../../hocs/ProtectedRoute';

// configs
import userNavItems from '../../configs/user-nav';
import userSettingsItems from '../../configs/user-settings';
import routes from '../../configs/routes';
import { authSelectors } from '../../redux/auth';
import { userOperations } from '../../redux/user';
import { profilesOperations } from '../../redux/profiles';

// styles
import styles from './Dashboard.module.css';

class Dashboard extends Component {
  state = {};

  componentDidMount() {
    const { token, getCurrentUser, fetchAllProfiles } = this.props;
    getCurrentUser(token);
    fetchAllProfiles(token);
  }

  componentDidUpdate() {
    const { token, getCurrentUser, fetchAllProfiles } = this.props;
    getCurrentUser(token);
    fetchAllProfiles(token);
  }

  render() {
    return (
      <div className={styles.dashboard}>
        <div className={styles.menu}>
          <UserNav items={userNavItems} settings={userSettingsItems} />
        </div>
        <div className={styles.contant}>
          <Switch>
            <ProtectedRoute
              exact
              path={routes.PROFILE}
              component={Profile}
              redirectTo="/"
            />
            <ProtectedRoute
              exact
              path={routes.RATING}
              component={RatingContainer}
              redirectTo="/"
            />
            <ProtectedRoute
              exact
              path={routes.CALENDAR}
              component={SmartCalendar}
              redirectTo="/"
            />
            <ProtectedRoute
              exact
              path={routes.MYINFO}
              component={MyInfo}
              redirectTo="/"
            />
            <Redirect to="profile" />
          </Switch>
        </div>
      </div>
    );
  }
}

const mapStateToProps = state => ({
  token: authSelectors.getToken(state),
});

const mapDispatchToProps = {
  getCurrentUser: userOperations.getCurrentUser,
  fetchAllProfiles: profilesOperations.fetchAllProfiles,
};

export default connect(
  mapStateToProps,
  mapDispatchToProps,
)(Dashboard);
