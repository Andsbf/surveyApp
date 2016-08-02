export const changeOptionText = (id, options, text) =>{
  const optionIndex = options.findIndex(option => option.id == id);
  const updateOption = {
    id: id,
    value: text
  };
  return [
    ...options.slice(0, optionIndex),
    updateOption,
    ...options.slice(optionIndex + 1)
  ];
}

export const removeOptionId = (id, options) => {
  const optionIndex = options.findIndex(option => option.id == id);
  return [
    ...options.slice(0, optionIndex),
    ...options.slice(optionIndex + 1)
  ]
}

export const addOption = (options, params) =>{
  return [
    ...options,
    {
      id: params.optionId,
      value: params.text
    }
  ];
}
