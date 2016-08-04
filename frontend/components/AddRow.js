import React, { PropTypes }  from 'react'

const AddRow = ({
  onAddRow
}) => (
  <button href='#'
    onClick={onAddRow}
  >
    {' + '}
  </button>
)

AddRow.propTypes = {
  onAddRow: PropTypes.func
}

export default AddRow
