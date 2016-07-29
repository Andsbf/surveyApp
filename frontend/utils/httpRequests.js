import fetch        from 'isomorphic-fetch';
import { polyfill } from 'es6-promise';

const defaultHeaders = {
  'Accept': 'application/json',
  'Content-Type': 'application/json',
};

// function buildHeaders() {
//   const authToken = localStorage.getItem('TrelloHubAuthToken');

//   return { ...defaultHeaders, Authorization: authToken };
// }

export function handleError(response) {
  var error = new Error(response);
  error.response = response;
  throw error;
}

export function checkStatus(response) {
  if (response.status >= 200 && response.status < 300) {
    return response;
  } else {
    var error = new Error(response.statusText);
    error.response = response;
    throw error;
  }
}

export function parseJSON(response) {
  return response.json();
}

export function httpGet(url) {
  return fetch(url, {
    headers: defaultHeaders,
  })
  .then(checkStatus, handleError)
  .then(parseJSON);
}

export function httpPost(url, data) {
  const body = JSON.stringify(data);

  return fetch(url, {
    method: 'post',
    headers: defaultHeaders,
    body: body,
  })
  .then(checkStatus)
  .then(parseJSON);
}

export function httpPut(url, data) {
  const body = JSON.stringify(data);

  return fetch(url, {
    method: 'put',
    headers: defaultHeaders,
    body: body,
  })
  .then(checkStatus)
  .then(parseJSON);
}

export function httpDelete(url) {

  return fetch(url, {
    method: 'delete',
    headers: defaultHeaders,
  })
  .then(checkStatus)
  .then(parseJSON);
}
