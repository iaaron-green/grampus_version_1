import React, { Component } from 'react';
import SignInContainer from './SignIn/SignInContainer';
import SignUpContainer from './SignUp/SignUpContainer';

// styles
import styles from './Authentication.module.css';

export default class Authentication extends Component {
  state = {};

  componentDidMount() {
    this.setState({
      activeAuth: (
        <SignInContainer
          handleChangeActiveAuth={this.handleChangeActiveAuthSignUp}
        />
      ),
    });
  }

  shouldComponentUpdate(nextProps, nextState) {
    const { activeAuth } = this.state;
    return nextState.activeAuth !== activeAuth;
  }

  handleChangeActiveAuthSignUp = () => {
    this.setState({
      activeAuth: (
        <SignUpContainer
          handleChangeActiveAuth={this.handleChangeActiveAuthSignIn}
        />
      ),
    });
  };

  handleChangeActiveAuthSignIn = () => {
    this.setState({
      activeAuth: (
        <SignInContainer
          handleChangeActiveAuth={this.handleChangeActiveAuthSignUp}
        />
      ),
    });
  };

  render() {
    const { activeAuth } = this.state;

    return <div className={styles.auth}>{activeAuth}</div>;
  }
}
