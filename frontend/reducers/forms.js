import { rowCreator, generateId } from '../utils/rows'
import { changeOptionText, removeOptionId, addOption }  from '../utils/options'

const forms = (state = {}, action) => {
  switch (action.type) {
    case 'Template':
      if (state.id !== action.rowId) {
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
