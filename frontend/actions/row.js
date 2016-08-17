import { generateId, rowCreator } from '../utils/rows'
import { httpPost, httpGet } from '../utils/httpRequests'

export function requestNewRow(formId, type) {
  return dispatch => {
    return httpGet(`http://localhost:3000/api/v1/rows/new.json`)
      .then(response => {
        dispatch(addRow(response.row, formId));
      })
  }
}

export const addRow = (row, formId) => {
  return {
    type: 'ADD_ROW',
    formId: formId,
    rowId: row.id,
    entities: {
      rows : {
        [row.id]: {
          ...row,
          formId: formId
        }
      }
    }
  }
}

export const removeRow = (rowId, formId) => {
  return {
    type:'REMOVE_ROW',
    rowId: rowId,
    formId: formId
  }
}

export const toggleEditRow = (id) => {
  return {
    type:'TOGGLE_ROW_EDIT',
    rowId: id
  }
}
