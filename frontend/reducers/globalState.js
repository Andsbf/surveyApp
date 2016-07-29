const globalState = (state = { editing_field: undefined }, action) => {
  switch (action.type) {
    case 'TOGGLE_FIELD_EDIT':
      return {
        ...state,
        editing_field:
          action.field_id == state.editing_field ?
            undefined :
            action.field_id
      };
    default:
      return state;
  }
};

export default globalState