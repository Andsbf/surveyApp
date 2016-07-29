export const addField = (type) => {
  return {
    type: 'ADD_FIELD',
    fieldType: type
  }
}

export const toggleEditField = (id) => {
  return {
    type:'TOGGLE_FIELD_EDIT',
    field_id: id
  }
}