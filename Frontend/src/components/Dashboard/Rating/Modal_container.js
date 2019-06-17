import React, { Component } from 'react';

// import './Modal.module.css';

const modalButton = {
  width: '500px',
  maxWidth: '100%',
  margin: '0 auto',
  position: 'fixed',
  left: '0',
  top: '0',
  transform: 'translate(-50%, -50%)',
  zIndex: '999',
  backGround: '#eee',
  padding: '10px 20px 40px',
  borderRadius: '50%',
  display: 'flex',
  flexDirection: 'column',
};

const modalDisplayButton = {
  marginBottom: '150px',
  padding: '3px 8px',
  cursor: 'pointer',
  borderRadius: '50%',
  border: 'none',
  width: '30px',
  height: '30px',
  fontWeight: 'bold',
  alignSelf: 'flex-end',
};

class Modal extends Component {
  state = {};

  render() {
    let dialog = (
      <div style={modalButton}>
        <button style={modalDisplayButton}>X</button>
        <div>{this.props.children}</div>
      </div>
    );
    if (!this.props.isOpen) {
      dialog = null;
    }
    return <div>{dialog}</div>;
  }
}

export default Modal;
