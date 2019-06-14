import React from 'react';
import { PieChart } from 'react-chartkick';
import 'chart.js';
import './Chart.module.css';

const styles = {
  margin: '10px',
  width: '150px',
  padding: '13px',
  color: '#6F6161',
};

const Chart = () => {
  return (
    <div className="chart">
      <h4 style={styles}>Statistic Charts</h4>
      <PieChart
        data={[['Best Looker', 130], ['Super Worker', 150], ['Extrovert', 74]]}
      />
    </div>
  );
};

export default Chart;
