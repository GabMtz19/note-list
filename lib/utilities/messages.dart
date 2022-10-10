String errorCodeFormating(String errorCode) {
  if(errorCode == 'unknown') {
    return 'MISSING CONTENT ON TEXT FIELD(S)';
  }
  return errorCode.replaceAll(RegExp(r'-'), ' ').toUpperCase();
}