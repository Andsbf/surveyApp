function(array, old_index, new_index) {
  var copy = Object.assign([], array);
    while (old_index < 0) {
        old_index += copy.length;
    }
    while (new_index < 0) {
        new_index += copy.length;
    }
    if (new_index >= copy.length) {
        var k = new_index - copy.length;
        while ((k--) + 1) {
            copy.push(undefined);
        }
    }
    copy.splice(new_index, 0, copy.splice(old_index, 1)[0]);
    return copy; // for testing purposes
};
