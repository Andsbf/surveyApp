import { httpGet, httpPut, httpPost } from '../utils/httpRequests'
import { receiveRows } from './rows'

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
    response: {
      entities: {
        forms: {
          [form.id]: cleanForm
        }
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
        // dispatch(selectForm(formId)); // Tempo
      })
      // .then(json => dispatch(receivePosts(reddit, json))) handle error
  }
}

export function saveForm(formId) {
  return (dispatch, getState) => {
    // debugger;
    // dispatch(requestForm(formId));

    const data = {
      form: {
        ...getState().entities.forms[formId],
      }
    }

    getState().rowsByForm[formId].rows.map(id => {
      let row = getState().entities.rows[id]

      const data = {
        row: {
          ...row,
          formId: formId
        }
      }

      httpPost(`http://localhost:3000/api/v1/rows`, data)
        .then(response => {
          debugger
        })
    })

    return httpPut(`http://localhost:3000/api/v1/forms/${formId}.json`, data)
      .then(response => {
        dispatch(receiveRows(response.form.rows));
        dispatch(receiveForm(response.form));
        dispatch(selectForm(formId)); // Tempo
        // response.json();
      })
      // .then(json => dispatch(receivePosts(reddit, json))) handle error
  }
}
