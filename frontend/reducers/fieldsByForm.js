import fields from './fields'
import { removeFieldId } from '../utils/fields'

const InitState = {
 '765432': {
    isFetching: false,
    didInvalidate: false,
    fields: [765432, 765431]
  }
}

const fieldsByForm = (state = InitState, action) => {
  let form = state[action.formId] || {};
  switch (action.type) {
    case 'RECEIVE_FORM':
      return {
        ...state,
        [action.formId]: {
          ...form,
          isFetching: false,
          didInvalidate: false,
          fields: action.form.rows.map(field => field.id)
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

    case 'ADD_FIELD':
      return {
        ...state,
        [action.formId]: {
         ...form,
         fields: form.fields.concat(action.fieldId)
        }
      };

    case 'REMOVE_FIELD':
      return {
        ...state,
        [action.formId]: {
         ...form,
         fields: removeFieldId(action.fieldId, form.fields)
        }
      };

    default:
      return state;
  }
};

export default fieldsByForm
