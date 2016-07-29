import React, { PropTypes } from 'react'
import DropdownEdit from '../containers/DropdownEdit'

const Dropdown = ({
  field,
  dispatch,
  editing = false
 }) => {

  let editForm;
  if (editing) {
    editForm = <DropdownEdit field={field} />;
  } else {
    editForm = '';
  }

  return (
    <div className='field' >
      {field.label} <span>: </span>
      <select>
        {field.options.map(option =>
          <option key={option.id}>{option.value}</option>
        )}
      </select>

      { editForm }

    </div>
  );
}

Dropdown.propTypes = {
  field: PropTypes.object,
}

export default Dropdown
