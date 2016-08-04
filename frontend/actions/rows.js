export const receiveRows = (rows) => {

  const rowsAsHash = {};
  rows.map(row => {rowsAsHash[row.id] = {...row} });
  return {
    type: 'RECEIVED_ROW',
    response: {
      entities:{
        rows: rowsAsHash
      }
    }
  }
}
