import React, { useState } from 'react';

import Modals from '../../../Modals/Modals';

import styles from './Information.module.css';

const Update = ({ info, token, update }) => {
  const [newInfo, setInfo] = useState(info);
  return (
    <div>
      <h3 className={styles.title}>Information</h3>
      <input
        className={styles.input}
        type="text"
        value={newInfo}
        onChange={e => setInfo(e.target.value)}
      />

      <button
        className={styles.btn}
        onClick={() =>
          update({
            token,
            update: { information: newInfo },
          })
        }
      >
        +
      </button>
    </div>
  );
};

const Information = ({ info, token, update }) => {
  const [modalIsOpen, toggleModal] = useState(false);
  return (
    <div className={styles.information}>
      <Modals
        modalIsOpen={modalIsOpen}
        toggleModal={toggleModal}
        component={<Update info={info} token={token} update={update} />}
      />
      <h3 className={styles.title}>Information</h3>
      <div className={styles.content}>
        <div className={styles.info}>{info}</div>
        <button className={styles.btn} onClick={toggleModal}>
          +
        </button>
      </div>
    </div>
  );
};

export default Information;
