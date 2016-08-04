import React, { Component } from 'react'
import { connect } from 'react-redux'
import Editing from '../components/Editing'
import { fetchForms } from '../actions/forms'
import { selectForm } from '../actions/form'
import { mapObject } from '../utils/objectHelpers'

class App extends Component {
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
        { selectedForm ? <Editing/> : '' }
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
    // onToggleEditRow: (id) => dispatch(toggleEditRow(id)),
    // onRemoveRow: (rowId, formId) => dispatch(removeRow(rowId, formId)),
    onSelectForm: (id) => dispatch(selectForm(id)),
    onFetchForms: () => dispatch(fetchForms())
  }
}

App = connect(mapStateToProps, mapDispatchToProps)(App);

export default App

