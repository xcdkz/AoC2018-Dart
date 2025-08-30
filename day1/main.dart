import 'dart:io';

Future<String> readFromFile(String filename) async {
  return await File(filename).readAsString();
}

void main() async {
  final input = await readFromFile('input.txt');
  final frequencyChanges = input
      .trim()
      .split('\n')
      .map((frequencyChange) => int.parse(frequencyChange))
      .toList();
  print("Silver: ${silver(frequencyChanges)}");
  print("Gold: ${gold(frequencyChanges)}");
}

int silver(List<int> frequencyChanges) {
  return frequencyChanges.fold(
    0,
    (previousValue, element) => previousValue + element,
  );
}

int gold(List<int> frequencyChanges) {
  int initialFrequency = 0;
  Set<int> reachedFrequencies = {initialFrequency};
  while (true) {
    for (int frequencyChange in frequencyChanges) {
      initialFrequency += frequencyChange;
      if (reachedFrequencies.contains(initialFrequency)) {
        return initialFrequency;
      } else {
        reachedFrequencies.add(initialFrequency);
      }
    }
  }
}
