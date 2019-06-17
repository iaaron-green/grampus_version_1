import React from 'react';
import MainRow from './MainRow';

import styles from './Achives.module.css';

const Achives = () => {
  return (
    <div className={styles.achives}>
      <h3 className={styles.title}>Achievements</h3>
      <MainRow />
    </div>
  );
};

export default Achives;
