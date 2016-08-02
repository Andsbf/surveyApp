import React from 'react'
import { connect } from 'react-redux'
import { addField } from '../actions/field'

let AddField = ({
  onAddField
}) => (
  <button href='#'
    onClick={onAddField}
  >
    {' + '}
  </button>
)

AddField = connect()(AddField);

export default AddField
