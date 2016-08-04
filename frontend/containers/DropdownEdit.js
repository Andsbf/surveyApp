import React from 'react'
import { connect } from 'react-redux'
import Input from '../components/Input'
import { generateId } from '../utils/rows'

let DropdownEdit = ({
  dispatch,
  row,
  editing
}) => (
    <div>
      <p>editing:</p>

      Label:

      <Input
        onChange={(value) => {
          dispatch({
            type: 'LABEL_CHANGE',
            rowId: row.id,
            label: value
          })
        }}
        value={row.label}
      />

      <p>options:</p>

      {row.options.map(option =>
        <div key={option.id}>
          <Input
            onChange={value =>
              dispatch({
                type: 'CHANGE_OPTION_TEXT',
                rowId: row.id,
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
                rowId: row.id,
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
            rowId: row.id,
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
