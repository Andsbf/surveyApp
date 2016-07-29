import field from './field'

const fieldsInitState = [
 {id: '765432',fieldType: 'dropdown', label: 'a', options:[{id:'1', value:'1'},{id:'2', value:'2'}]},
 {id: '765431',fieldType: 'dropdown', label: 'b', options:[{id:'1', value:'c'},{id:'2', value:'d'}]}
]
const formFields = (state = fieldsInitState, action) => {
  switch (action.type) {
    case 'ADD_FIELD':
      return [
        ...state,
        field(undefined, action)
      ];

    case 'ADD_OPTION':
      return state.map(t =>
          field(t, action)
        );

    case 'CHANGE_OPTION_TEXT':
      return state.map(t =>
          field(t, action)
        );

    case 'REMOVE_OPTION':
      return state.map(t =>
        field(t, action)
      );

    case 'LABEL_CHANGE':
      return state.map(t =>
        field(t, action)
      );
    default:
      return state;
  }
};

export default formFields