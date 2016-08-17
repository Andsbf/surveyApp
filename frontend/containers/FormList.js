import React, { Component } from 'react'
import { connect } from 'react-redux'
import { fetchForms } from '../actions/forms'
import { selectForm } from '../actions/form'
import { mapObject } from '../utils/objectHelpers'

class FormList extends Component {
  componentDidMount() {
    const { onFetchForms } = this.props;
    onFetchForms()
  }

  render() {
    const {
      forms,
      selectedForm,
      onSelectForm
    } = this.props

    return(
      <div>
        { mapObject(forms, (_,form) => (
          <button
            className={
              selectedForm == form.id ? 'btn btn-outline-primary' : 'btn btn-secondary '
            }
            key={form.id}
            onClick={() => onSelectForm(form.id) }
          >
            { form.title }
          </button>
        ))}
      </div>
    );
  }
}

const mapStateToProps = (state) => {
  const selectedForm = state.globalState.selectedForm;
  const forms = state.entities.forms;

  return {
    selectedForm,
    forms
  };
}

const mapDispatchToProps = (dispatch) => {
  return {
    onSelectForm: (id) => dispatch(selectForm(id)),
    onFetchForms: () => dispatch(fetchForms())
  }
}

FormList = connect(mapStateToProps, mapDispatchToProps)(FormList);

export default FormList

