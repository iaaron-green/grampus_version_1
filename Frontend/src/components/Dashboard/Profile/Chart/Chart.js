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
      <PieChart data={[['Likes', 130], ['Dislikes', 150]]} />
    </div>
  );
};

export default Chart;
