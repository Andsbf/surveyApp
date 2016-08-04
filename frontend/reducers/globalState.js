import { combineReducers } from 'redux'

const initState = {

  selectedForm: undefined,
  selectedRow: undefined
}

const globalState = (state = initState, action) => {
  switch (action.type) {
    case 'SELECT_FORM':
      return {
        ...state,
        selectedForm: action.formId
      }

    case 'TOGGLE_ROW_EDIT':
      return {
        ...state,
        selectedRow:
          action.rowId == state.selectedRow ?
            undefined :
            action.rowId
      };
    default:
      return state;
  }
};

export default globalState
