import { fieldCreator, generateId } from '../utils/fields'
import { changeOptionText, removeOptionId, addOption }  from '../utils/options'

const fields = (state = {}, action) => {
  switch (action.type) {

    case 'REMOVE_FIELD':
      return {
        ...state,
        [action.fieldId]: {
          ...state[action.fieldId],
          formId: undefined
        }
      }

    case 'ADD_OPTION':
      return {
        ...state,
        [action.fieldId]: {
          ...state[action.fieldId],
          options: addOption(state[action.fieldId].options, action)
        }
      }

    case 'LABEL_CHANGE':
      return {
        ...state,
        [action.fieldId]: {
          ...state[action.fieldId],
          label: action.label
        }
      }

    case 'CHANGE_OPTION_TEXT':
      return {
       ...state,
        [action.fieldId]: {
          ...state[action.fieldId],
          options: changeOptionText(
            action.optionId,
            state[action.fieldId].options,
            action.text
          )
        }
      }

    case 'REMOVE_OPTION':
      return {
        ...state,
        [action.fieldId]: {
          ...state[action.fieldId],
          options: removeOptionId(action.optionId, state[action.fieldId].options)
        }
      }

    default:
      return state;
  }
};

export default fields
