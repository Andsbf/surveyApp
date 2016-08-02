import React from 'react'
import { connect } from 'react-redux'
import Input from '../components/Input'
import { generateId } from '../utils/fields'

let DropdownEdit = ({
  dispatch,
  field,
  editing
}) => (
    <div>
      <p>editing:</p>

      Label:

      <Input
        onChange={(value) => {
          dispatch({
            type: 'LABEL_CHANGE',
            fieldId: field.id,
            label: value
          })
        }}
        value={field.label}
      />

      <p>options:</p>

      {field.options.map(option =>
        <div key={option.id}>
          <Input
            onChange={value =>
              dispatch({
                type: 'CHANGE_OPTION_TEXT',
                fieldId: field.id,
                optionId: option.id,
                text: value
              })
            }
            value={option.value}
          />
          <button href='#'
            onClick={ () =>
              dispatch({
                type: 'REMOVE_OPTION',
                fieldId: field.id,
                optionId: option.id
              })
            }
          >
            {' - '}
          </button>
        </div>
      )}
      <button href='#'
        onClick={()=>
          dispatch({
            type: 'ADD_OPTION',
            fieldId: field.id,
            optionId: generateId(),
            text: ''
          })
        }
      >
        {' + '}
      </button>
      <div>
      </div>
    </div>
)

DropdownEdit = connect()(DropdownEdit);

export default DropdownEdit
