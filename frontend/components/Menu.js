import React, { PropTypes } from 'react'
import Dropdown  from '../components/Dropdown'
import AddField from '../containers/AddField'

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

const Menu = () => (
  <div>
    <h4>Menu</h4>

    <AddField type='dropdown'/>
    <Dropdown field={dropdownSample}/>

  </div>
)

Menu.propTypes = {
}

export default Menu
