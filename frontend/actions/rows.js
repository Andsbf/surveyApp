import {  httpPost, httpDelete } from '../utils/httpRequests'
import {  arrayToHashByProp } from '../utils/objectHelpers'

export const receiveRows = (rows) => {
  return {
    type: 'RECEIVED_ROW',
    entities:{
      rows: arrayToHashByProp(rows, 'id')
    }
  }
}

export const rowsUpdater = (formId, getState, dispatch) => {
  const rowsIds = getState().rowsByForm[formId].rows;
  rowIds.forEach(id => {
    let row = getState().entities.rows[id];
    if (row.deleted) {
      deleteRow(row.id, dispatch);
    } else {
      upsertRow(row, dispatch);
    }
  });
}

const deleteRow = (rowId, dispatch) => {
  httpDelete(`http://localhost:3000/api/v1/rows/${rowId}.json`)
  .then(response => {
    debugger
    // dispatch()
  })
}

const upsertRow = (row, dispatch) => {
  httpPost(`http://localhost:3000/api/v1/rows`, {row: row})
  .then(response => {
    debugger
    // dispatch()
  })
}


