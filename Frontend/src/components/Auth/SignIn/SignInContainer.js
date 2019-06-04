import React, { Component } from 'react';
// components
import SignInView from './SignInView';
import withAuth from '../../../hocs/withAuth';

const INITIAL_STATE = {
  username: '',
  password: '',
};

class SignInContainer extends Component {
  state = { ...INITIAL_STATE };

  handleChange = e => {
    e.preventDefault();
    const { name, value } = e.target;
    this.setState({
      [name]: value,
    });
  };

  handleSubmit = e => {
    e.preventDefault();
    const { signIn } = this.props;
    signIn({ ...this.state });
    this.reset();
    console.log('You are signed in!');
  };

  reset = () => {
    this.setState({ ...INITIAL_STATE });
  };

  render() {
    return (
      <SignInView
        {...this.state}
        {...this.props}
        onChange={this.handleChange}
        onSubmit={this.handleSubmit}
      />
    );
  }
}
export default withAuth(SignInContainer);
