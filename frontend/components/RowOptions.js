import React, { PropTypes }  from 'react'

const check = <i className="fa fa-check-square" aria-hidden="true"></i>;
const wrench = <i className="fa fa-wrench" aria-hidden="true"></i>;

const RowOptions = ({
  onRemoveRow,
  onToggleEditRow,
  editing
}) => (
  <div className='col-md-6'>
    <button
      className=" btn btn-info btn-sm"
      onClick={onToggleEditRow}
    >
      { editing ? check : wrench }
    </button>

    <button
      className="btn btn-danger btn-sm"
      onClick={onRemoveRow}
    >
      <i className="fa fa-trash-o" aria-hidden="true"></i>
    </button>
  </div>
)

RowOptions.propTypes = {
  onRemoveRow: PropTypes.func,
  onToggleEditRow: PropTypes.func
}

export default RowOptions





