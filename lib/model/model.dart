class Resource{

   final Status status;
  Resource({required this.status});
}

enum Status {
  // ignore: constant_identifier_names
  Success,
  // ignore: constant_identifier_names
  Error,
  // ignore: constant_identifier_names
  Cancelled
}
