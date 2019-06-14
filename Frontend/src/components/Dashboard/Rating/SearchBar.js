import React, { Component } from 'react';
import ReactSearchBox from 'react-search-box';

class SearchBar extends Component {
  data = [
    {
      key: 'john',
      value: 'John Doe',
    },
    {
      key: 'jane',
      value: 'Jane Doe',
    },
    {
      key: 'mary',
      value: 'Mary Phillips',
    },
    {
      key: 'robert',
      value: 'Robert',
    },
    {
      key: 'karius',
      value: 'Karius',
    },
  ];

  render() {
    return (
      <ReactSearchBox
        placeholder="Insert Data..."
        data={this.data}
        callback={record => console.log(record)}
      />
    );
  }
}
export default SearchBar;
