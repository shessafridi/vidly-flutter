class BadRequestError implements Exception {
  String? errorMessage;
  BadRequestError({this.errorMessage});

  @override
  String toString() {
    return errorMessage ?? super.toString();
  }
}
