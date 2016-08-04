import rows from './rows'
import { removeRowId } from '../utils/rows'

const InitState = {
 // '765432': {
 //    isFetching: false,
 //    didInvalidate: false,
 //    rows: [765432, 765431]
 //  }
}

const rowsByForm = (state = InitState, action) => {
  let form = state[action.formId] || {};
  switch (action.type) {
    case 'RECEIVE_FORM':
      return {
        ...state,
        [action.formId]: {
          ...form,
          isFetching: false,
          didInvalidate: false,
          rows: action.form.rows.map(row => row.id)
        }
      }

    case 'REQUEST_FORM':
      return {
        ...state,
        [action.formId]: {
          ...form,
          isFetching: true,
          didInvalidate: false,
        }
      }

    case 'ADD_ROW':
    debugger
      return {
        ...state,
        [action.formId]: {
         ...form,
         rows: form.rows.concat(action.rowId)
        }
      };

    case 'REMOVE_ROW':
      return {
        ...state,
        [action.formId]: {
         ...form,
         rows: removeRowId(action.rowId, form.rows)
        }
      };

    default:
      return state;
  }
};

export default rowsByForm
