import { combineReducers } from 'redux'
import globalState from './globalState'
import formFields from './formFields'

const surveyApp = combineReducers({
  globalState,
  formFields,
})

export default surveyApp
