import 'dart:io';

Future<String> readFromFile(String filename) async {
  return await File(filename).readAsString();
}

void main() async {
  final input = await readFromFile('input.txt');
  final ids = input.trim().split('\n');
   
}
