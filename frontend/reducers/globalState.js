import { combineReducers } from 'redux'

const initState = {
  selectedForm: '765432',
  selectedField: undefined
}

const globalState = (state = initState, action) => {
  switch (action.type) {
    case 'SELECT_FORM':
      return {
        ...state,
        selectedForm: action.formId
      }

    case 'TOGGLE_FIELD_EDIT':
      return {
        ...state,
        selectedField:
          action.fieldId == state.selectedField ?
            undefined :
            action.fieldId
      };
    default:
      return state;
  }
};

export default globalState
