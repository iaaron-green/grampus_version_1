import React from 'react';
// styles
import styles from './FeaturesPage.module.css';

const AsyncFeaturesPage = () => {
  return (
    <div className={styles.features}>
      <h3 className={styles.title}>Our features for this project</h3>
      <ul className={styles.list}>
        <li className={styles.item}>Our app should be...</li>
        <li className={styles.item}>Using of React/Redax...</li>
      </ul>
    </div>
  );
};

export default AsyncFeaturesPage;
