import React, { Component } from 'react'
import { connect } from 'react-redux'
import Dropdown  from '../components/Dropdown'
import { removeRow, toggleEditRow } from '../actions/row'
import { fetchFormIfNeeded, fetchForm, saveForm } from '../actions/form'
import RowOptions from '../components/RowOptions'

class Form extends Component {
  render () {
    const {
      form,
      rows,
      globalState,
      dispatch,
      onToggleEditRow,
      onRemoveRow,
      onSaveForm
     } = this.props

    return (
      <div className='row m-t-3'>
        <p className="text-xs-center">{form.title}</p>
        <div className="col-md-6 offset-md-4">
          {
            rows.map( row => {

            if (row.deleted){
              return ''
            }
            const editing = globalState.selectedRow == row.id;

            switch (row.rowType) {
              case 'dropdown':
                  return (
                    <div className='row' key={row.id}>
                      <Dropdown row={row} editing={editing} />
                      <RowOptions
                        onRemoveRow={() => onRemoveRow(row.id, form.id)}
                        onToggleEditRow={() => onToggleEditRow(row.id)}
                        editing={editing}
                      />
                    </div>
                  );

              default:
                return '';
            }
          })}
          <button
            className='btn btn-success btn-sm offset-md-3'
            onClick={() => onSaveForm(form.id) }
          >
          Save <i className="fa fa-floppy-o" aria-hidden="true"></i>
          </button>
        </div>
      </div>
    );
  }
}

const mapStateToFormProps = (state) => {
  const globalState = state.globalState;
  const form = state.entities.forms[globalState.selectedForm];
  const rows = state.rowsByForm[form.id].rows.map(id => state.entities.rows[id])
  debugger

  return {
    globalState,
    form,
    rows
  };
}

const mapDispatchToProps = (dispatch) => {
  return {
    onToggleEditRow: (id) => dispatch(toggleEditRow(id)),
    onRemoveRow: (rowId, formId) => dispatch(removeRow(rowId, formId)),
    // fetchForm: () => dispatch(fetchForm('57a0b8556f3e5a50b3a2fd42')),
    onSaveForm: (formId) => dispatch(saveForm(formId))
  }
}

Form = connect(mapStateToFormProps, mapDispatchToProps)(Form);

export default Form
