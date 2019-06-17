import React from 'react';

import styles from './Skills.module.css';

const Skills = skill => {
  return (
    <div className={styles.skills}>
      <h3 className={styles.skillsText}>Skills</h3>
      <div className={styles.addingButton}>
        <button className={styles.addingBlock}>+</button>
      </div>
      <p>{skill.information}</p>
    </div>
  );
};

export default Skills;
