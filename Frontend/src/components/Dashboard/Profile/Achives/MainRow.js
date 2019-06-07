import React from 'react';
import './MainRow.module.css';

// import { ReactComponent as None } from '../../../../assets/svg/none.svg';
// import { ReactComponent as BestLooker } from '../../../../assets/svg/best_looker.svg';
// import { ReactComponent as DeadLiner } from '../../../../assets/svg/dedliner.svg';

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
