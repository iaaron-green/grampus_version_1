import React from 'react';
import Modal from 'react-modal';

const customStyles = {
  content: {
    minWidth: '500px',
    top: '50%',
    left: '50%',
    right: 'auto',
    bottom: 'auto',
    marginRight: '-50%',
    transform: 'translate(-50%, -50%)',
  },
};

const Modals = ({ modalIsOpen = false, toggleModal, component = null }) => {
  return (
    <Modal
      isOpen={!!modalIsOpen}
      ariaHideApp={false}
      onRequestClose={() => toggleModal(!modalIsOpen)}
      style={customStyles}
    >
      {component}
    </Modal>
  );
};

export default Modals;
