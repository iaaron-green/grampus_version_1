import React from 'react';
import PropTypes from 'prop-types';

// styles
import styles from './SignIn.module.css';

const SignInView = ({
  username,
  password,
  onChange,
  onSubmit,
  handleChangeActiveAuth,
}) => (
  <>
    <form className={styles.form} onSubmit={onSubmit}>
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
      <button type="submit" className={styles.button}>
        Sign In
      </button>
    </form>
    <p className={styles.text}>
      Or you can create account and
      <strong>
        <button
          type="button"
          className={styles.link}
          onClick={handleChangeActiveAuth}
        >
          Sign Up
        </button>
      </strong>
    </p>
  </>
);

SignInView.propTypes = {
  username: PropTypes.string.isRequired,
  password: PropTypes.string.isRequired,
  onChange: PropTypes.func.isRequired,
  onSubmit: PropTypes.func.isRequired,
  handleChangeActiveAuth: PropTypes.func.isRequired,
};

export default SignInView;
