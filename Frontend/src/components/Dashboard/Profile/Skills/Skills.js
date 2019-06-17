import React, { useState } from 'react';

import Modals from '../../../Modals/Modals';

import styles from './Skills.module.css';

const Update = ({ skill, token, update }) => {
  const [newSkill, setSkill] = useState(skill);
  return (
    <div>
      <h3 className={styles.title}>Skills</h3>
      <input
        className={styles.input}
        type="text"
        value={newSkill}
        onChange={e => setSkill(e.target.value)}
      />

      <button
        className={styles.btn}
        onClick={() =>
          update({
            token,
            update: { skills: newSkill },
          })
        }
      >
        +
      </button>
    </div>
  );
};

const Skills = ({ skill, token, update }) => {
  const [modalIsOpen, toggleModal] = useState(false);

  return (
    <div className={styles.skills}>
      <Modals
        modalIsOpen={modalIsOpen}
        toggleModal={toggleModal}
        component={<Update skill={skill} token={token} update={update} />}
      />
      <h3 className={styles.title}>Skills</h3>
      <div className={styles.content}>
        <div>{skill}</div>
        <button className={styles.btn} onClick={toggleModal}>
          +
        </button>
      </div>
    </div>
  );
};

export default Skills;
