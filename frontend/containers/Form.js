import React, { Component } from 'react'
import { connect } from 'react-redux'
import Dropdown  from '../components/Dropdown'
import { removeField, toggleEditField, saveForm } from '../actions/field'
import { fetchFormIfNeeded, fetchForm } from '../actions/form'

class Form extends Component {

  componentDidMount() {
    const { fetchForm } = this.props;
    fetchForm()
  }

  render () {
    const {
      form,
      fields,
      globalState,
      dispatch,
      onToggleEditField,
      onRemoveField
     } = this.props

    return (
      <div>
        {
          fields.map( field => {
          const editing = globalState.selectedField == field.id;
          switch (field.fieldType) {
            case 'dropdown':
                return (
                  <div key={field.id}>
                    <Dropdown field={field} editing={editing} />
                    <button onClick={() => onToggleEditField(field.id)} >
                      { editing ? 'done' : 'edit' }
                    </button>
                    <button onClick={() => onRemoveField(field.id, form.id)} >
                      { 'Remove Field' }
                    </button>
                  </div>
                );

            default:
              return (<p>ERROR</p>);
          }
        })}
        <button
          onClick={ () => {
            saveForm(form)
          }}
        >Save
        </button>
      </div>
    );
  }
}

const mapStateToFormProps = (state) => {
  const globalState = state.globalState;
  const form = state.entities.forms[globalState.selectedForm];
  const fields = state.fieldsByForm[form.id].fields.map(id => state.entities.fields[id])

  return {
    globalState,
    form,
    fields
  };
}

const mapDispatchToProps = (dispatch) => {
  return {
    onToggleEditField: (id) => dispatch(toggleEditField(id)),
    onRemoveField: (fieldId, formId) => dispatch(removeField(fieldId, formId)),
    fetchForm: () => dispatch(fetchForm('57a0b8556f3e5a50b3a2fd42'))
  }
}

Form = connect(mapStateToFormProps, mapDispatchToProps)(Form);

export default Form
