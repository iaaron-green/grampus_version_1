import React from 'react';
import './MainRow.module.css';

import { ReactComponent as None } from '../../../../assets/svg/none.svg';
import { ReactComponent as BestLooker } from '../../../../assets/svg/best_looker.svg';
import { ReactComponent as DeadLiner } from '../../../../assets/svg/dedliner.svg';

const MainRow = () => {
  return (
    <div className="mainRow">
      <ul>
        <li className="listElement">
          <None />
          <p>Best Looker</p>
        </li>
        <li className="listElement">
          <BestLooker />
          <p>Best Looker</p>
        </li>
        <li className="listElement">
          <DeadLiner />
          <p>Dead Liner</p>
        </li>
      </ul>
    </div>
  );
};

export default MainRow;
