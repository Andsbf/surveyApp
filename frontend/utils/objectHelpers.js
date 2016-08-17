export function mapObject(object, callback) {
  return Object.keys(object).map(function (key) {
    return callback(key, object[key]);
  });
}

export function arrayToHashByProp(array, prop) {
  const hash = {};
  array.forEach(item => hash[item[prop]] = item );
  return hash
}
