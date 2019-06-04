import React, { Component } from 'react';
// components
import SignUpView from './SignUpView';
import withAuth from '../../../hocs/withAuth';

const INITIAL_STATE = {
  fullName: '',
  username: '',
  password: '',
};

class SignUpContainer extends Component {
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
    const { signUp } = this.props;
    signUp({ ...this.state });
    this.reset();
    console.log('You are signed up!');
  };

  reset = () => {
    this.setState({ ...INITIAL_STATE });
  };

  render() {
    return (
      <SignUpView
        {...this.state}
        {...this.props}
        onChange={this.handleChange}
        onSubmit={this.handleSubmit}
      />
    );
  }
}
export default withAuth(SignUpContainer);
