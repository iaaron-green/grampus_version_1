import React, { Component } from 'react';
import { connect } from 'react-redux';

import operations from '../redux/auth/authOperations';
import selectors from '../redux/auth/authSelectors';

const withAuth = WrappedComponent => {
  class WithAuth extends Component {
    // componentDidUpdate() {
    //   const { isAuthenticated, history, location } = this.props;

    //   const { from } = location.state || { from: { pathname: '/' } };

    //   if (isAuthenticated) {
    //     history.push({
    //       pathname: from.pathname,
    //       state: { from: location },
    //     });
    //   }
    // }
    shouldComponentUpdate(nextProps) {
      const { isAuthenticated, history, location } = this.props;

      const { from } = location.state || { from: { pathname: '/' } };

      if (isAuthenticated && nextProps.isAuthenticated !== isAuthenticated) {
        history.push({
          pathname: from.pathname,
          state: { from: location },
        });
      }
    }

    render() {
      return <WrappedComponent {...this.props} />;
    }
  }
  const mapStateToProps = state => ({
    isAuthenticated: selectors.getIsAuthenticated(state),
  });

  const mapDispatchToProps = {
    signIn: operations.signIn,
    signUp: operations.signUp,
  };
  return connect(
    mapStateToProps,
    mapDispatchToProps,
  )(WithAuth);
};

export default withAuth;
