import React from 'react'
import { connect } from 'react-redux'
import { addField } from '../actions'

let AddField = ({
  type,
  dispatch
}) => (
  <button href='#'
    onClick={() => dispatch(addField(type))}
  >
    {' + '}
  </button>
)

AddField = connect()(AddField);

export default AddField