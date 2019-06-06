import React from 'react';
// styles
import styles from './AboutUs.module.css';

const AsyncAboutUsPage = () => {
  return (
    <div className={styles.about}>
      <section className={styles.team}>
        <h2 className={styles.team__text}>About our team</h2>
        <ul className={styles.team__list}>
          <li className={styles.team__list__item}>
            <img
              className={styles.team__list__image}
              src="../assets/img/foto.jpg"
              alt="Foto of you"
            />
            <p className={styles.team__list__name}>Lorem ipsum dolor</p>
            <p className={styles.team__list__position}>Lorem ipsum dolor</p>
          </li>
          <li className={styles.team__list__item}>
            <img
              className={styles.team__list__image}
              src="../assets/img/foto.jpg"
              alt="Foto of you"
            />
            <p className={styles.team__list__name}>Lorem ipsum dolor</p>
            <p className={styles.team__list__position}>Lorem ipsum dolor</p>
          </li>
          <li className={styles.team__list__item}>
            <img
              className={styles.team__list__image}
              src="../assets/img/foto.jpg"
              alt="Foto of you"
            />
            <p className={styles.team__list__name}>Lorem ipsum dolor</p>
            <p className={styles.team__list__position}>Lorem ipsum dolor</p>
          </li>
        </ul>
        <ul className={styles.team__list}>
          <li className={styles.team__list__item}>
            <img
              className={styles.team__list__image}
              src="../assets/img/foto.jpg"
              alt="Foto of you"
            />
            <p className={styles.team__list__name}>Lorem ipsum dolor</p>
            <p className={styles.team__list__position}>Lorem ipsum dolor</p>
          </li>
          <li className={styles.team__list__item}>
            <img
              className={styles.team__list__image}
              src="../assets/img/foto.jpg"
              alt="Foto of you"
            />
            <p className={styles.team__list__name}>Lorem ipsum dolor</p>
            <p className={styles.team__list__position}>Lorem ipsum dolor</p>
          </li>
          <li className={styles.team__list__item}>
            <img
              className={styles.team__list__image}
              src="../assets/img/foto.jpg"
              alt="Foto of you"
            />
            <p className={styles.team__list__name}>Lorem ipsum dolor</p>
            <p className={styles.team__list__position}>Lorem ipsum dolor</p>
          </li>
        </ul>
        <ul className={styles.team__list}>
          <li className={styles.team__list__item}>
            <img
              className={styles.team__list__image}
              src="../assets/img/foto.jpg"
              alt="Foto of you"
            />
            <p className={styles.team__list__name}>Lorem ipsum dolor</p>
            <p className={styles.team__list__position}>Lorem ipsum dolor</p>
          </li>
          <li className={styles.team__list__item}>
            <img
              className={styles.team__list__image}
              src="../assets/img/foto.jpg"
              alt="Foto of you"
            />
            <p className={styles.team__list__name}>Lorem ipsum dolor</p>
            <p className={styles.team__list__position}>Lorem ipsum dolor</p>
          </li>
          <li className={styles.team__list__item}>
            <img
              className={styles.team__list__image}
              src="../assets/img/foto.jpg"
              alt="Foto of you"
            />
            <p className={styles.team__list__name}>Lorem ipsum dolor</p>
            <p className={styles.team__list__position}>Lorem ipsum dolor</p>
          </li>
        </ul>
      </section>
    </div>
  );
};

export default AsyncAboutUsPage;
