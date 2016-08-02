export const generateId = () => {
  var text = "";
  var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

  for( var i=0; i < 8; i++ )
      text += possible.charAt(Math.floor(Math.random() * possible.length));

  return text;
}

export const removeFieldId = (id, fields) => {
  const fieldIndex = fields.findIndex(fieldId => fieldId == id);
  return [
    ...fields.slice(0, fieldIndex),
    ...fields.slice(fieldIndex + 1)
  ]
}

export const fieldCreator = (type, id, formId) => {
  switch (type) {
    case 'dropdown':
      const field = {
        id: id,
        formId: formId,
        fieldType: type,
        label: 'Dropdown',
        options: [],
      }
      return field;
    default:
      alert('something wrong')
  }
}
