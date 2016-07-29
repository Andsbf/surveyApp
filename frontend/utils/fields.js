export const generateId = () => {
  var text = "";
  var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

  for( var i=0; i < 8; i++ )
      text += possible.charAt(Math.floor(Math.random() * possible.length));

  return text;
}

export const fieldCreator = (type) => {
  switch (type) {
    case 'dropdown':
      return {
        id: generateId(),
        fieldType: type,
        label: 'Dropdown',
        options: [],
      };
    default:
      alert('something wrong')
  }
}
