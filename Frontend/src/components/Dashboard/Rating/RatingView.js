import React from 'react';
// styles
import styles from './Rating.module.css';

const buttonStyling = {
  width: '200px',
  marginLeft: '60%',
};

const RatingView = ({ profiles = [] }) => {
  return (
    <ul className={styles.list}>
      {profiles.map(
        ({ id, profilePicture, fullName, jobTitle, addLike, addDislike }) => (
          <li key={id} className={styles.item}>
            <img src={profilePicture} className={styles.img} alt={id} />

            <div className={styles.titles}>
              <p>Name: {fullName}</p>
              <p>Occupation: {jobTitle}</p>
            </div>

            <div style={buttonStyling}>
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
            </div>
          </li>
        ),
      )}
    </ul>
  );
};

export default RatingView;
