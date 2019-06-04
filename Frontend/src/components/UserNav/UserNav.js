import React, { Component } from 'react';
import { NavLink, Link, withRouter } from 'react-router-dom';
import { connect } from 'react-redux';

import { authActions } from '../../redux/auth';
import routes from '../../configs/routes';
// styles
import styles from './UserNav.module.css';

class UserNav extends Component {
  state = {
    isSettingsOpen: false,
  };

  shouldComponentUpdate(nextProps, nextState) {
    const { isSettingsOpen } = this.state;

    return nextState.isSettingsOpen !== isSettingsOpen;
  }

  toggleSettings = () => {
    this.setState(state => ({ isSettingsOpen: !state.isSettingsOpen }));
  };

  handleExitUser = () => {
    const { logOut, history } = this.props;

    history.push({
      pathname: routes.MAIN,
    });

    logOut();
  };

  render() {
    const { isSettingsOpen } = this.state;
    const { items = [], settings = [] } = this.props;

    return (
      <div className={styles.navigation}>
        <nav className={styles.navigation__items}>
          <ul className={styles.list}>
            {items.map(({ name, path }) => (
              <li key={name} className={styles.link}>
                <NavLink
                  exact
                  to={path}
                  activeClassName={styles.active}
                  className={styles.linkNav}
                >
                  {name}
                </NavLink>
              </li>
            ))}
          </ul>
          <div className={styles.settings}>
            <span onClick={this.toggleSettings}>Settings</span>
            {isSettingsOpen && (
              <ul className={styles.list}>
                {settings.map(({ name, path }) => (
                  <li key={name} className={styles.link}>
                    <Link exact to={path} className={styles.linkNav}>
                      {name}
                    </Link>
                  </li>
                ))}
                <li key="logOut" className={styles.link}>
                  <button
                    type="button"
                    className={styles.btn}
                    onClick={this.handleExitUser}
                  >
                    Log Out
                  </button>
                </li>
              </ul>
            )}
          </div>
        </nav>
      </div>
    );
  }
}

const mapDispatchToProps = {
  logOut: authActions.signOut,
};

export default connect(
  null,
  mapDispatchToProps,
)(withRouter(UserNav));
