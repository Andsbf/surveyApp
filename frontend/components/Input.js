import React, { PropTypes } from 'react'

const Input = ({
  onChange,
  value = ''
}) => {
  return (
    <input
      ref={node => {
        if (node !== null) {
          node.value = value;
        }
      }}

      onChange={
        (event) =>
          onChange(event.target.value)
      }
    />
  );
}

Input.propTypes = {
  onChange: PropTypes.func,
  value: PropTypes.string
}

export default Input
