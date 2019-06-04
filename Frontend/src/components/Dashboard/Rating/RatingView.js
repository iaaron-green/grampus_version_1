import React from 'react';
// styles
import styles from './Rating.module.css';

const RatingView = ({ profiles = [] }) => {
  return (
    <ul className={styles.list}>
      {profiles.map(
        ({ id, profilePicture, fullName, jobTitle, addLike, addDislike }) => (
          <li key={id} className={styles.item}>
            <img src={profilePicture} className={styles.img} alt={id} />
            <p>{fullName}</p>
            <p>{jobTitle}</p>
            <button
              type="button"
              className={styles.button}
              onClick={() => addLike(id)}
            >
              Like
            </button>
            <button
              type="button"
              className={styles.button}
              onClick={() => addDislike(id)}
            >
              Dislike
            </button>
          </li>
        ),
      )}
    </ul>
  );
};

export default RatingView;
