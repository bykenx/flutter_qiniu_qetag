import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_qiniu_qetag/flutter_qiniu_qetag.dart';

void main() {
  test('adds one to input values', () {
    expect(getQetag('assets/test_file.txt'), 'FhSjGK2aKedtzpSgJsFFhUwLekAN');
  });
}
