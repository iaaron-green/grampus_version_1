import React from 'react';
// styles
import styles from './Slogan.module.css';

const Slogan = () => {
  return (
    <div className={styles.slogan}>
      <h3 className={styles.title}>
        {`"The harder I work, the more luck I have"`}
      </h3>
    </div>
  );
};

export default Slogan;
