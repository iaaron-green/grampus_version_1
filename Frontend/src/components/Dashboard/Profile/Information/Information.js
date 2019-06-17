import React from 'react';

import styles from './Information.module.css';

const Information = ({ info, token, update }) => {
  return (
    <div className={styles.information}>
      <h3 className={styles.title}>Information</h3>
      <div className={styles.content}>
        <div className={styles.info}>{info}</div>
        <button
          className={styles.btn}
          onClick={() =>
            update({
              token,
              update: { information: Math.random() },
            })
          }
        >
          +
        </button>
      </div>
    </div>
  );
};

export default Information;
