import React from 'react';

import styles from './Skills.module.css';

const Skills = ({ skill, token, update }) => {
  return (
    <div className={styles.skills}>
      <h3 className={styles.title}>Skills</h3>
      <div className={styles.content}>
        <div>{skill}</div>
        <button
          className={styles.btn}
          onClick={() =>
            update({
              token,
              update: { skills: Math.random() },
            })
          }
        >
          +
        </button>
      </div>
    </div>
  );
};

export default Skills;
