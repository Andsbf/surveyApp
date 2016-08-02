import { combineReducers } from 'redux'
import globalState from './globalState'
import entities from './entities'
import fields from './fields'
import fieldsByForm from './fieldsByForm'

const surveyApp = combineReducers({
  entities,
  globalState,
  fieldsByForm,
})

export default surveyApp
