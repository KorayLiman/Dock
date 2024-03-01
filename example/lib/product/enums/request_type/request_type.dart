enum RequestType {
  get('GET'),
  post('POST'),
  delete('PUT'),
  put('DELETE');

  const RequestType(this.type);

  final String type;
}
