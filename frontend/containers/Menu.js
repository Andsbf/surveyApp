import React from 'react'
import { connect } from 'react-redux'
import Dropdown  from '../components/Dropdown'
import AddRow from '../components/AddRow'
import { requestNewRow } from '../actions/row'

const dropdownSample ={
  id: '765432',
  rowType: 'dropdown',
  label: 'Dropdown Sample',
    options: [
      { id: '1', value: 'Option 1' },
      { id: '2', value: 'Option 2' },
      { id: '3', value: 'Option ...' },
      { id: '4', value: 'Option 3' }
    ]
}

let Menu = ({formId, onAddRowClick}) => (
  <div>
    <h4>Menu</h4>

    <AddRow onAddRow={()=> onAddRowClick(formId,'dropdown')}/>
    <Dropdown row={dropdownSample}/>

  </div>
)


const mapStateToFormProps = (state) => {
  const formId = state.globalState.selectedForm

  return {
    formId
  };
}

const mapDispatchToProps = (dispatch) => {
  return {
    onAddRowClick: (formId, type) => {
      dispatch(requestNewRow(formId, type))
    }
  }
}


Menu = connect(mapStateToFormProps, mapDispatchToProps)(Menu);

export default Menu
