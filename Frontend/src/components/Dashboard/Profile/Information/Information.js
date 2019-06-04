import React from 'react';

import styles from './Information.module.css';

const Information = ({ profile }) => {
  return (
    <div className={styles.information}>
      <h3>Information</h3>
      <p>{profile.information}</p>
    </div>
  );
};

export default Information;
