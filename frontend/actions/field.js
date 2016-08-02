import { generateId, fieldCreator } from '../utils/fields'


export const addField = (formId, type) => {
  // httpPost('http://localhost:3000/api/v1/forms', {banana: 'boa'})
  // .then(
  //   data => {

  //   }
  // );
  const id = generateId();
  const fields = {}
  fields[id] = fieldCreator('dropdown', id, formId)

  // I don't like this, but couldn't figure out a better way of doing it
  // and still make use of the action.response on the entities reducer
  return {
    type: 'ADD_FIELD',
    formId: formId,
    fieldId: id,
    response: {
      entities: {
        fields
      }
    }
  }
}

export const receiveFields = (fields) => {

  const fieldsAsHash = {};
  fields.map(field => {fieldsAsHash[field.id] = {...field} });
  return {
    type: 'RECEIVED_FIELD',
    response: {
      entities:{
        fields: fieldsAsHash
      }
    }
  }
}

export const removeField = (fieldId, formId) => {
  return {
    type:'REMOVE_FIELD',
    fieldId: fieldId,
    formId: formId

  }
}

export const toggleEditField = (id) => {
  return {
    type:'TOGGLE_FIELD_EDIT',
    fieldId: id
  }
}
