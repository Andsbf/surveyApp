import React, { Component } from 'react'
import { connect } from 'react-redux'
import Dropdown  from '../components/Dropdown'
import { removeRow, toggleEditRow } from '../actions/row'
import { fetchFormIfNeeded, fetchForm, saveForm } from '../actions/form'

class Form extends Component {

  componentDidMount() {
    // const { fetchForm } = this.props;
    // fetchForm()
  }

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
      <div className='row'>
        <div className="col-md-6 offset-md-3">
          {
            rows.map( row => {

            const editing = globalState.selectedRow == row.id;
            const check = <i className="fa fa-check-square" aria-hidden="true"></i>;
            const wrench = <i className="fa fa-wrench" aria-hidden="true"></i>;

            switch (row.rowType) {
              case 'dropdown':
                  return (
                    <div className='row p-b-1' key={row.id}>
                      <div className="col-md-6">
                        <Dropdown row={row} editing={editing} />
                      </div>
                      <button
                        className="col-md-1 btn btn-info btn-sm"
                        onClick={() => onToggleEditRow(row.id)}
                      >
                        { editing ? check : wrench }
                      </button>

                      {'   '}

                      <button
                        className="col-md-1 btn btn-danger btn-sm"
                        onClick={() => onRemoveRow(row.id, form.id)}
                      >
                        <i className="fa fa-trash-o" aria-hidden="true"></i>
                      </button>
                    </div>
                  );

              default:
                return (<p>ERROR</p>);
            }
          })}
          <button
            onClick={ () => onSaveForm(form.id) }
          >Save
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
