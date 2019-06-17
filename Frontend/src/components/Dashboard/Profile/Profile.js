import React from 'react';
import { connect } from 'react-redux';

import Person from './Person/Person';
import Achives from './Achives/Achives';
import Information from './Information/Information';
import Skills from './Skills/Skills';
import Chart from './Chart/Chart';

import { userOperations, userSelectors } from '../../../redux/user';
import { authSelectors } from '../../../redux/auth';

import styles from './Profile.module.css';

const Profile = ({ user, token, updateCurrentUser }) => {
  return (
    <div className={styles.profile}>
      <Person user={user} />
      <Achives />
      <Information
        info={user.information}
        token={token}
        update={updateCurrentUser}
      />
      <Skills skill={user.skills} token={token} update={updateCurrentUser} />
      <Chart />
    </div>
  );
};

const mapStateToProps = state => ({
  user: userSelectors.getUser(state),
  token: authSelectors.getToken(state),
});

const mapDispatchToProps = {
  updateCurrentUser: userOperations.updateCurrentUser,
};

export default connect(
  mapStateToProps,
  mapDispatchToProps,
)(Profile);
