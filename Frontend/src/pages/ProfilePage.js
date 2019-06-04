import React from 'react';
// components
import Profile from '../components/Profile/Profile';

const ProfilePage = props => {
  return (
    <div>
      <Profile {...props} />
    </div>
  );
};

export default ProfilePage;
