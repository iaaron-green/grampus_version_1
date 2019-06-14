import React, { Component } from 'react';
import { connect } from 'react-redux';
// components
import RatingView from './RatingView';
import SearchBar from './SearchBar';

import { profilesSelectors, profilesOperations } from '../../../redux/profiles';

class RatingContainer extends Component {
  state = {};

  componentDidMount() {
    const { fetchAllProfiles } = this.props;

    fetchAllProfiles();
  }

  render() {
    const { profiles, addLikes, addDislikes } = this.props;
    return (
      <div>
        <SearchBar />
        <RatingView
          profiles={profiles}
          addLikes={addLikes}
          addDislikes={addDislikes}
        />
      </div>
    );
  }
}
const mapStateToProps = state => ({
  profiles: profilesSelectors.getAllProfiles(state),
});

const mapDispatchToProps = {
  fetchAllProfiles: profilesOperations.fetchAllProfiles,
};

export default connect(
  mapStateToProps,
  mapDispatchToProps,
)(RatingContainer);
