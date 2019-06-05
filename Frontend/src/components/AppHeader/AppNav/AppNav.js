import React from 'react';
import { NavLink } from 'react-router-dom';
import { connect } from 'react-redux';
import { authSelectors } from '../../../redux/auth';
// configs
import routes from '../../../configs/routes';
// styles
import styles from './AppNav.module.css';

const AppNav = ({ items = [], isAuthenticated }) => (
  <div className={styles.navigation}>
    {isAuthenticated ? (
      <button type="button" className={styles.button}>
        <NavLink exact path to={routes.PROFILE} className={styles.nav}>
          Go Back To Profile
        </NavLink>
      </button>
    ) : null}
    <nav className={styles.navigation__items}>
      <ul className={styles.list}>
        {items.map(({ name, path }) => (
          <li key={name} className={styles.link}>
            <NavLink
              exact
              to={path}
              activeClassName={styles.active}
              className={styles.link}
            >
              {name}
            </NavLink>
          </li>
        ))}
      </ul>
    </nav>
  </div>
);

const mapStateToProps = state => ({
  isAuthenticated: authSelectors.getIsAuthenticated(state),
});

export default connect(
  mapStateToProps,
  null,
)(AppNav);
