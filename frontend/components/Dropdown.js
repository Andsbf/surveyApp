import React, { PropTypes } from 'react'
import DropdownEdit from '../containers/DropdownEdit'

const Dropdown = ({
  row,
  dispatch,
  editing = false
 }) => {
debugger;
  let editForm;
  if (editing) {
    editForm = <DropdownEdit row={row} />;
  } else {
    editForm = '';
  }

  return (
    <div className=''>
      <div className='form-group row'>
        <label className='col-sm-3 col-form-label'>
          {row.label}:
        </label>
        <div className="col-sm-9">
          <select className='form-control'>
            {row.options.map(option =>
              <option key={option.id}>{option.value}</option>
            )}
          </select>
          { editForm }
        </div>
      </div>
    </div>
  );
}

Dropdown.propTypes = {
  row: PropTypes.object,
}

export default Dropdown
