import { combineReducers } from 'redux'
import globalState from './globalState'
import entities from './entities'
import rowsByForm from './rowsByForm'

const surveyApp = combineReducers({
  entities,
  globalState,
  rowsByForm,
})

export default surveyApp
