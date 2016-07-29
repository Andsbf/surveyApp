import { fieldCreator, generateId } from '../utils/fields'
import { changeOptionText, removeOptionId, addOption }  from '../utils/options'

const field = (state, action) => {
  switch (action.type) {
    case 'ADD_FIELD':
      return  fieldCreator(action.fieldType);

    case 'ADD_OPTION':
      if (state.id !== action.field_id) {
        return state;
      }

      return {
        ...state,
        options:  addOption(state.options, action)
      }
    case 'CHANGE_OPTION_TEXT':
      if (state.id !== action.field_id) {
        return state;
      }
      return {
        ...state,
        options:  changeOptionText(action.option_id, state.options, action.text)
      }

    case 'REMOVE_OPTION':
      if (state.id !== action.field_id) {
        return state;
      }

      return {
        ...state,
        options:  removeOptionId(action.option_id, state.options)
      }

    case 'LABEL_CHANGE':
      if (state.id !== action.field_id) {
        return state;
      }

      return {
        ...state,
        label:  action.label
      }

    default:
      return state;
  }
};

export default field