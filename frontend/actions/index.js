import { httpGet, httpPost } from '../utils/httpRequests'

export const saveForm = (fields) => {
  return (dispatch, getState) => {
    // debugger;
  }
  // return {
  //   type:'SAVE_FORM'
  // }
}

export function fetchPostsIfNeeded(reddit) {
  return (dispatch, getState) => {
    if (shouldFetchPosts(getState(), reddit)) {
      return dispatch(fetchPosts(reddit))
    }
  }
}
