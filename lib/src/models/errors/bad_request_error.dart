class BadRequestError implements Exception {
  String? errorMessage;
  BadRequestError({this.errorMessage});
}
