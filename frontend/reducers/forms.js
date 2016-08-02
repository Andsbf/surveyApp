import { fieldCreator, generateId } from '../utils/fields'
import { changeOptionText, removeOptionId, addOption }  from '../utils/options'

const forms = (state = {}, action) => {
  switch (action.type) {
    case 'Template':
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

export default forms
