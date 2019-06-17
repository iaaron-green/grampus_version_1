import React, { Component } from 'react';
import Modal from './Modal_container';

class ModalBlock extends Component {
  state = { isOpen: false };

  render() {
    return (
      <div>
        <button type="button" onClick={e => this.setState({ isOpen: true })}>
          Like
        </button>
        <Modal isOpen={this.state.isOpen}>some text will be here </Modal>
      </div>
    );
  }
}

export default ModalBlock;

// show={this.state.show} handleClose={this.hideModal}
