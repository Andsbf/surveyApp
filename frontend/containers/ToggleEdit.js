import React from 'react'
import { connect } from 'react-redux'

let ToggleEdit = ({
  dispatch,
  field_id,
  editing
}) => {
  return (
    <button
      onClick={()=>
        dispatch({
          type:'TOGGLE_FIELD_EDIT',
          field_id: editing ?
            undefined :
            field_id
        })
      }
    >
      {
        editing ?
        'done' :
        'edit'
      }
    </button>
  );
}

ToggleEdit = connect()(ToggleEdit);

export default ToggleEdit