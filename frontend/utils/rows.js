export const generateId = () => {
  var text = "";
  var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

  for( var i=0; i < 8; i++ )
      text += possible.charAt(Math.floor(Math.random() * possible.length));

  return text;
}

export const removeRowId = (id, rows) => {
  const rowIndex = rows.findIndex(rowId => rowId == id);
  return [
    ...rows.slice(0, rowIndex),
    ...rows.slice(rowIndex + 1)
  ]
}

export const rowCreator = (type, id, formId) => {
  switch (type) {
    case 'dropdown':
      const row = {
        id: id,
        formId: formId,
        rowType: type,
        label: 'Dropdown',
        options: [],
      }
      return row;
    default:
      alert('something wrong')
  }
}
