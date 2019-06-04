import React from 'react';
import PropTypes from 'prop-types';

import styles from './SignUp.module.css';

const SignUpView = ({
  fullName,
  username,
  password,
  onChange,
  onSubmit,
  handleChangeActiveAuth,
}) => (
  <>
    <form className={styles.form} onSubmit={onSubmit}>
      <label className={styles.name}>
        <input
          className={styles.input}
          type="text"
          name="fullName"
          value={fullName}
          placeholder="Write your name"
          onChange={onChange}
          required
        />
      </label>
      <label className={styles.email}>
        <input
          className={styles.input}
          type="text"
          name="username"
          value={username}
          placeholder="Enter your email"
          onChange={onChange}
          required
        />
      </label>
      <label className={styles.lock}>
        <input
          className={styles.input}
          type="password"
          name="password"
          value={password}
          placeholder="Enter your password"
          onChange={onChange}
          required
        />
      </label>
      <button className={styles.button} type="submit">
        Sign Up
      </button>
    </form>
    <p className={styles.text}>
      Have you already created your account?
      <strong>
        <button
          type="button"
          className={styles.link}
          onClick={handleChangeActiveAuth}
        >
          Sign In
        </button>
      </strong>
    </p>
  </>
);

SignUpView.propTypes = {
  fullName: PropTypes.string.isRequired,
  username: PropTypes.string.isRequired,
  password: PropTypes.string.isRequired,
  onChange: PropTypes.func.isRequired,
  onSubmit: PropTypes.func.isRequired,
  handleChangeActiveAuth: PropTypes.func.isRequired,
};

export default SignUpView;
