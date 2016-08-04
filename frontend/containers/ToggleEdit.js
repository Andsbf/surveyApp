import React from 'react'
import { connect } from 'react-redux'

let ToggleEdit = ({
  dispatch,
  rowId,
  editing
}) => {
  return (
    <button
      onClick={()=>
        dispatch({
          type:'TOGGLE_ROW_EDIT',
          rowId: editing ?
            undefined :
            rowId
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
