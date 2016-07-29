import { httpGet, httpPost } from '../utils/httpRequests'

export const addField = (type) => {
  // httpGet('http://localhost:3000/api/v1/forms')
  // .then(
  //   data => {
  //     debugger
  //   },
  //   error => {
  //     debugger
  //   }
  // );
  // return {
  //   type: 'ADD_FIELD',
  //   fieldType: type
  // }

  httpPost('http://localhost:3000/api/v1/forms', {banana: 'boa'})
  .then(
    data => {
      debugger
    }
  );
}

export const toggleEditField = (id) => {
  return {
    type:'TOGGLE_FIELD_EDIT',
    field_id: id
  }
}
