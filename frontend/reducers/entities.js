import merge from 'lodash/merge'
import rows from './rows'

const formsInitState = {
 // '765432': {id: '765432',title: 'vovo'},
 // '765431': {id: '765431',title: 'xuxu'}
}

const rowsInitState = {
  // '765432': {
  //   id: '765432',
  //   formId: '765432',
  //   rowType: 'dropdown',
  //   label: 'a',
  //   options:[
  //     { id:'1', value:'1'},
  //     { id:'2', value:'2'}
  //   ]
  // },
  // '765431': {
  //   id: '765431',
  //   formId: '765432',
  //   rowType: 'dropdown',
  //   label: 'b',
  //   options:[
  //     { id:'1', value:'c' },
  //     { id:'2', value:'d' }
  //   ]
  // }
}

function entities(state = { forms: formsInitState, rows: rowsInitState }, action) {
  if (action.entities) {
    return merge({}, state, action.entities);
  }


  switch (action.type) {
    case 'REMOVE_ROW':
    case 'LABEL_CHANGE':
    case 'ADD_OPTION':
    case 'REMOVE_OPTION':
    case 'CHANGE_OPTION_TEXT':
      return {
        ...state,
        rows: rows(state.rows, action)
      };
    default:
      return state;
  }

}

export default entities
