import { httpGet, httpPut, httpPost } from '../utils/httpRequests'
import { receiveRows } from './rows'
import { receiveForm } from './form'

export function fetchForms() {
  return dispatch => {
    return httpGet(`http://localhost:3000/api/v1/forms.json`)
      .then(response => {
        response.forms.forEach(form => {
          dispatch(receiveRows(form.rows));
          dispatch(receiveForm(form));
        })
      })
  }
}
