import React from 'react';
import { connect } from 'react-redux';

import Person from './Person/Person';
import Achives from './Achives/Achives';
import Information from './Information/Information';
import Skills from './Skills/Skills';

import { userSelectors } from '../../../redux/user';
import { profilesSelectors } from '../../../redux/profiles';

import styles from './Profile.module.css';

const Profile = ({ profiles = [], user }) => {
  const userProfile = profiles.filter(profile => profile.id === user.userId);
  return (
    <div className={styles.profile}>
      <Person user={user} profile={userProfile} />
      <Achives />
      <Information profile={userProfile} />
      <Skills />
    </div>
  );
};

const mapStateToProps = state => ({
  user: userSelectors.getUser(state),
  profiles: profilesSelectors.getAllProfiles(state),
});

export default connect(
  mapStateToProps,
  null,
)(Profile);
