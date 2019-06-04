// Core
import React, { Component } from 'react';

// Instruments
import 'antd/dist/antd.css';
import { Calendar, Alert } from 'antd';
import moment from 'moment';

class SmartCalendar extends Component {
  state = {
    value: moment('2019-01-01'),
    selectedValue: moment('2019-01-01'),
  };

  onSelect = value => {
    this.setState({
      value,
      selectedValue: value,
    });
  };

  onPanelChange = value => {
    this.setState({ value });
  };

  render() {
    const { value, selectedValue } = this.state;
    return (
      <div>
        <Alert
          message={`You selected date: ${selectedValue &&
            selectedValue.format('YYYY-MM-DD')}`}
        />
        <Calendar
          value={value}
          onSelect={this.onSelect}
          onPanelChange={this.onPanelChange}
        />
      </div>
    );
  }
}

// const SmartCalendar = () => {
//   return <div>SmartCalendar</div>;
// };

export default SmartCalendar;
