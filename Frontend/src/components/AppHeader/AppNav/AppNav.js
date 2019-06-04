import React from 'react';
import { NavLink } from 'react-router-dom';
// styles
import styles from './AppNav.module.css';

const AppNav = ({ items = [] }) => (
  <div className={styles.navigation}>
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

export default AppNav;
