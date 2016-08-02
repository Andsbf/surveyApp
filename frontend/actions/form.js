import { httpGet } from '../utils/httpRequests'
import { receiveFields } from './field'

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
  return {
    type: 'RECEIVE_FORM',
    formId: form.id,
    form: form,
    receivedAt: Date.now(),
    response: {
      entities: {
        forms: {
          [form.id]: {...form}
        }
      }
    }
  }
}

export function fetchFormIfNeeded(formId) {
  return (dispatch, getState) => {
    if (shouldFetchForm(getState(), formId)) {
      return dispatch(fetchForm(formId))
    }
  }
}

export function fetchForm(formId) {
  return dispatch => {
    dispatch(requestForm(formId));

    return httpGet(`http://localhost:3000/api/v1/forms/${formId}.json`)
      .then(response => {
        dispatch(receiveForm(response.form));
        dispatch(receiveFields(response.form.rows));
        dispatch(selectForm(formId)); // Tempo
        // response.json();
      })
      // .then(json => dispatch(receivePosts(reddit, json))) handle error
  }
}

function shouldFetchForm(state, reddit) {
  const posts = state.postsByReddit[reddit]
  if (!posts) {
    return true
  }
  if (posts.isFetching) {
    return false
  }
  return posts.didInvalidate
}
