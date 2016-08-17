import { httpGet, httpPut, httpPost } from '../utils/httpRequests'
import { receiveRows, rowsUpdater } from './rows'

export function requestForm(formId) {
  return {
    type: 'REQUEST_FORM',
   formId
  }
}

export function selectForm(formId) {
  return {
    type: 'SELECT_FORM',
   formId
  }
}

export function receiveForm(form) {
  const {rows, ...cleanForm} = form;
  return {
    type: 'RECEIVE_FORM',
    formId: form.id,
    form: form,
    receivedAt: Date.now(),
    entities: {
      forms: {
        [form.id]: cleanForm
      }
    }
  }
}


export function fetchForm(formId) {
  return dispatch => {
    dispatch(requestForm(formId));

    return httpGet(`http://localhost:3000/api/v1/forms/${formId}.json`)
      .then(response => {
        dispatch(receiveRows(response.form.rows));
        dispatch(receiveForm(response.form));
      })
  }
}

export function saveForm(formId) {
  return (dispatch, getState) => {
    const form = getState().entities.forms[formId];
    rowsUpdater(formId, getState, dispatch);

    return httpPut(`http://localhost:3000/api/v1/forms/${formId}.json`, {form: form})
      .then(response => {
        dispatch(receiveRows(response.form.rows));
        dispatch(receiveForm(response.form));
        dispatch(selectForm(formId)); // Tempo
      })
  }
}

export function requestNewForm() {
  return dispatch => {
    return httpGet(`http://localhost:3000/api/v1/forms/new.json`)
      .then(response => {
        dispatch(receiveForm(response.form));
      })
  }
}

