import React from 'react';
import './MainRow.module.css';

const MainRow = ({ profile, feature }) => {
  return (
    <div className="mainRow">
      <div className="imgBlock">
        <img className="img" src={profile} alt={profile} />
      </div>
      <div className="featureName">
        <p>{feature}</p>
      </div>
    </div>
  );
};

export default MainRow;
