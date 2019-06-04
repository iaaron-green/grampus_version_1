import React, { Component } from 'react';
import { Route, Switch, Redirect } from 'react-router-dom';

// configs
import routes from '../configs/routes';
import navItems from '../configs/main-nav';

// components
import AppNav from './AppHeader/AppNav/AppNav';
import MainPage from '../pages/MainPage';
import BusinessPage from '../pages/BusinessPage';
import FeaturesPage from '../pages/FeaturesPage';
import AboutUsPage from '../pages/AboutUsPage';

// styles
import './App.css';

export default class App extends Component {
  state = {};

  render() {
    return (
      <div>
        <AppNav items={navItems} />

        <Switch>
          <Route exact path={routes.BUSINESS} component={BusinessPage} />
          <Route exact path={routes.FEATURES} component={FeaturesPage} />
          <Route exact path={routes.ABOUT} component={AboutUsPage} />
          <Route path={routes.MAIN} component={MainPage} />
          <Redirect to="/" />
        </Switch>
      </div>
    );
  }
}
