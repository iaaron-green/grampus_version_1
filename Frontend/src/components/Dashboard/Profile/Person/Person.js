import React from 'react';

import styles from './Person.module.css';

const Person = ({ user }) => {
  return (
    <div className={styles.person}>
      <div className={styles.imgBG}>
        <img
          className={styles.img}
          src={user.userPicture}
          alt={user.userId}
          width="150px"
          height="100px"
        />
      </div>
      <div>
        <div className={styles.userName}>{user.fullName}</div>
        <br />
        <div className={styles.jobTitle}>{user.jobTitle}</div>
      </div>
    </div>
  );
};

export default Person;
