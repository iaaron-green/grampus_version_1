import React from 'react';
// styles
import styles from './Spiner.module.css';

const Spiner = () => {
  return (
    <div className={styles.container}>
      <div className={styles.ring} />
    </div>
  );
};

export default Spiner;
