import merge from 'lodash/merge'
import fields from './fields'

const formsInitState = {
 '765432': {id: '765432',title: 'vovo'},
 '765431': {id: '765431',title: 'xuxu'}
}

const fieldsInitState = {
  '765432': {
    id: '765432',
    formId: '765432',
    fieldType: 'dropdown',
    label: 'a',
    options:[
      { id:'1', value:'1'},
      { id:'2', value:'2'}
    ]
  },
  '765431': {
    id: '765431',
    formId: '765432',
    fieldType: 'dropdown',
    label: 'b',
    options:[
      { id:'1', value:'c' },
      { id:'2', value:'d' }
    ]
  }
}

function entities(state = { forms: formsInitState, fields: fieldsInitState }, action) {
  if (action.response && action.response.entities) {
    return merge({}, state, action.response.entities);
  }


  switch (action.type) {
    case 'REMOVE_FIELD':
    case 'LABEL_CHANGE':
    case 'ADD_OPTION':
    case 'REMOVE_OPTION':
    case 'CHANGE_OPTION_TEXT':
      return {
        ...state,
        fields: fields(state.fields, action)
      };
    default:
      return state;
  }

}

export default entities
