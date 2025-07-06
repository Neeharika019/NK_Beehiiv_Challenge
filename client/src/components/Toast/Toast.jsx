import React from 'react';
import PropTypes from 'prop-types';
import cx from 'classnames';

const Toast = ({ message, type = 'error', isVisible, onClose }) => {
  if (!isVisible) return null;

  const toastClasses = cx(
    'fixed top-4 right-4 z-50 p-4 rounded-md shadow-lg max-w-sm',
    {
      'bg-red-100 border border-red-400 text-red-700': type === 'error',
      'bg-green-100 border border-green-400 text-green-700': type === 'success',
      'bg-yellow-100 border border-yellow-400 text-yellow-700': type === 'warning',
      'bg-blue-100 border border-blue-400 text-blue-700': type === 'info'
    }
  );

  const iconClasses = cx(
    'inline-flex items-center justify-center flex-shrink-0 w-8 h-8 rounded-lg',
    {
      'bg-red-200 text-red-500': type === 'error',
      'bg-green-200 text-green-500': type === 'success',
      'bg-yellow-200 text-yellow-500': type === 'warning',
      'bg-blue-200 text-blue-500': type === 'info'
    }
  );

  return (
    <div className={toastClasses} role="alert">
      <div className="flex items-center">
        <div className={iconClasses}>
          {type === 'error' && (
            <svg className="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
              <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clipRule="evenodd" />
            </svg>
          )}
          {type === 'success' && (
            <svg className="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
              <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clipRule="evenodd" />
            </svg>
          )}
        </div>
        <div className="ml-3 text-sm font-normal flex-1">{message}</div>
        <button
          type="button"
          className="ml-auto -mx-1.5 -my-1.5 bg-white text-gray-400 hover:text-gray-900 rounded-lg focus:ring-2 focus:ring-gray-300 p-1.5 hover:bg-gray-100 inline-flex h-8 w-8 items-center justify-center"
          onClick={onClose}
        >
          <span className="sr-only">Close</span>
          <svg className="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
            <path fillRule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clipRule="evenodd" />
          </svg>
        </button>
      </div>
    </div>
  );
};

Toast.propTypes = {
  message: PropTypes.string.isRequired,
  type: PropTypes.oneOf(['error', 'success', 'warning', 'info']),
  isVisible: PropTypes.bool.isRequired,
  onClose: PropTypes.func.isRequired
};

export default Toast; 