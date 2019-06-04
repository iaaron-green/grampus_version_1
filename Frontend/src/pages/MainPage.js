import React from 'react';
import { connect } from 'react-redux';
// components
import Slogan from '../components/Slogan/Slogan';
import Authentication from '../components/Auth/Authentication';
import Dashboard from '../components/Dashboard/Dashboard';

import { authSelectors } from '../redux/auth';

// styles
import styles from './Main.module.css';

const MainPage = ({ isAuthenticated }) => {
  return (
    <main>
      {!isAuthenticated ? (
        <section className={styles.auth}>
          <div className={styles.home}>
            <Slogan />
            <Authentication />
          </div>
        </section>
      ) : (
        <section className={styles.dashboard}>
          <Dashboard />
        </section>
      )}
    </main>
  );
};

const mapStateToProps = state => ({
  isAuthenticated: authSelectors.getIsAuthenticated(state),
});

export default connect(
  mapStateToProps,
  null,
)(MainPage);
