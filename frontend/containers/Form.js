import React from 'react'
import { connect } from 'react-redux'
import Dropdown  from '../components/Dropdown'
import { toggleEditField } from '../actions'

let Form = ({ fields, globalState, dispatch }) => (
  <div>
    { fields.map( field => {
      const editing = globalState.editing_field == field.id;
      switch (field.fieldType) {
        case 'dropdown':
            return (
              <div key={field.id}>
                <Dropdown field={field} editing={editing} />
                <button onClick={() => dispatch(toggleEditField(field.id))} >
                  { editing ? 'done' : 'edit' }
                </button>
              </div>
            );

        default:
          return (<p>ERROR</p>);
      }
    })}
  </div>
)

const mapStateToFormProps = (state) => {
  return {
    globalState: state.globalState,
    fields: state.formFields
  };
}

Form = connect(mapStateToFormProps, null)(Form);

export default Form
