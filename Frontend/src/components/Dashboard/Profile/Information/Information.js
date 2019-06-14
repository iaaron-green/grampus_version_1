import React from 'react';

import styles from './Information.module.css';

const Information = ({ profile }) => {
  return (
    <div className={styles.information}>
      <h3 className={styles.informationText}>Information</h3>
      <div className={styles.addingButton}>
        <button className={styles.addingBlock}>+</button>
      </div>
      <p>{profile.information}</p>
    </div>
  );
};

export default Information;
