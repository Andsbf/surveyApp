import React from 'react'
import { connect } from 'react-redux'
import Dropdown  from '../components/Dropdown'
import AddField from '../containers/AddField'
import { addField } from '../actions/field'

const dropdownSample ={
  id: '765432',
  fieldType: 'dropdown',
  label: 'Dropdown Sample',
    options: [
      { id: '1', value: 'Option 1' },
      { id: '2', value: 'Option 2' },
      { id: '3', value: 'Option ...' },
      { id: '4', value: 'Option 3' }
    ]
}

let Menu = ({formId, onAddFieldClick}) => (
  <div>
    <h4>Menu</h4>

    <AddField onAddField={()=> onAddFieldClick(formId,'dropdown')}/>
    <Dropdown field={dropdownSample}/>

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
    onAddFieldClick: (formId, type) => {
      dispatch(addField(formId, type))
    }
  }
}


Menu = connect(mapStateToFormProps, mapDispatchToProps)(Menu);

export default Menu
