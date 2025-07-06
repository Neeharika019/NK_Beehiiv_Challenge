import { useState } from "react";
import Modal, { ModalBody, ModalFooter } from '../Modal'
import PropTypes from 'prop-types';

// Components
import Button, { SecondaryButton } from '../Button';
import Toast from '../Toast';

// Services
import { updateSubscriber } from "../../services/subscriber";

const SubscriberStatusModal = (props) => {
  const { isOpen, onSuccess, onClose, subscriberId, status } = props;
  const [isDeleting, setIsDeleting] = useState(false)
  const [errorMessage, setErrorMessage] = useState('')
  const [showError, setShowError] = useState(false)
  const [successMessage, setSuccessMessage] = useState('')
  const [showSuccess, setShowSuccess] = useState(false)

  const onUpdate = () => {
    const payload = {
      status: status === 'active' ? 'inactive' : 'active'
    }

    setIsDeleting(true)
    setShowError(false)
    updateSubscriber(subscriberId, payload)
    .then(() => {
      const action = status === 'active' ? 'unsubscribed' : 'subscribed'
      setSuccessMessage(`Subscriber ${action} successfully!`)
      setShowSuccess(true)
      setTimeout(() => {
        onSuccess()
      }, 1500)
    })
    .catch((payload) => {
      const error = payload?.response?.data?.message || payload?.response?.data?.errors?.join(', ') || 'Something went wrong'
      setErrorMessage(error)
      setShowError(true)
    })
    .finally(() => {
      setIsDeleting(false)
    })
  }

  const modalTitleText = status === 'active' ? 
    "Unsubscribe" : "Resubscribe"
  const messageBodyText = status === 'active' ? 
    "Are you sure you'd like to unsubscribe this subscriber?" :
    "Are you sure you'd like to resubscribe this subscriber?"
  const buttonText = status === 'active' ? 
    "Unsubscribe" : "Resubscribe"

  return (
    <>
      <Toast 
        message={errorMessage}
        type="error"
        isVisible={showError}
        onClose={() => setShowError(false)}
      />
      <Toast 
        message={successMessage}
        type="success"
        isVisible={showSuccess}
        onClose={() => setShowSuccess(false)}
      />
      <Modal modalTitle={modalTitleText} showModal={isOpen} onCloseModal={onClose}>
        <>
          <ModalBody>
          {messageBodyText}
        </ModalBody>
        <ModalFooter>
          <SecondaryButton
            className="mx-2"
            onClick={onClose}
          >
            Cancel
          </SecondaryButton>
          <Button
            type="primary"
            loading={isDeleting}
            onClick={onUpdate}
          >
            {buttonText}
          </Button>
        </ModalFooter>
        </>
      </Modal>
    </>
  );
};

SubscriberStatusModal.propTypes = {
  isOpen: PropTypes.bool,
  onClose: PropTypes.func,
  onSuccess: PropTypes.func,
  subscriberId: PropTypes.oneOfType([PropTypes.number, PropTypes.string]),
  status: PropTypes.string
}

export default SubscriberStatusModal;
