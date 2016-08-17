import { rowCreator, generateId } from '../utils/rows'
import { changeOptionText, removeOptionId, addOption }  from '../utils/options'

const rows = (state = {}, action) => {
  switch (action.type) {

    case 'REMOVE_ROW':
      return {
        ...state,
        [action.rowId]: {
          ...state[action.rowId],
          deleted: true
        }
      }

    case 'ADD_OPTION':
      return {
        ...state,
        [action.rowId]: {
          ...state[action.rowId],
          options: addOption(state[action.rowId].options, action)
        }
      }

    case 'LABEL_CHANGE':
      return {
        ...state,
        [action.rowId]: {
          ...state[action.rowId],
          label: action.label
        }
      }

    case 'CHANGE_OPTION_TEXT':
      return {
       ...state,
        [action.rowId]: {
          ...state[action.rowId],
          options: changeOptionText(
            action.optionId,
            state[action.rowId].options,
            action.text
          )
        }
      }

    case 'REMOVE_OPTION':
      return {
        ...state,
        [action.rowId]: {
          ...state[action.rowId],
          options: removeOptionId(action.optionId, state[action.rowId].options)
        }
      }

    default:
      return state;
  }
};

export default rows
