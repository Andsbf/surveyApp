import { generateId, rowCreator } from '../utils/rows'
import { httpPost, httpGet } from '../utils/httpRequests'

export function requestNewRow(formId, type) {
  return dispatch => {
    // dispatch(requestRowCreation(formId));
    const data = {
      row: {
        formId: formId,
        rowType: type
      }
    }

    return httpGet(`http://localhost:3000/api/v1/rows/new.json`)
      .then(response => {
        dispatch(addRow(response.row, formId))
      })
      // .then(json => dispatch(receivePosts(reddit, json))) handle error
  }
}

export const addRow = (row, formId) => {
  return {
    type: 'ADD_ROW',
    formId: formId,
    rowId: row.id,
    response: {
      entities: {
        rows : {
          [row.id]: row
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
