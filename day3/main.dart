import 'dart:io';

class Claim {
  int id;
  int left;
  int top;
  int width;
  int height;

  @override
  String toString() {
    return 'Claim(id: $id, left: $left, top: $top, width: $width, height: $height)';
  }

  Claim(this.id, this.left, this.top, this.width, this.height);

  factory Claim.fromString(String input) {
    int id;
    int left;
    int top;
    int width;
    int height;

    // input.split(' ') = [1, @, 265,241:, 16x26]
    List<String> splitInput = input.split(' ');

    List<String> leftTopPart = splitInput[2].split(',');
    List<String> widthHeightPart = splitInput[3].split('x');

    id = int.parse(splitInput[0].substring(1));
    left = int.parse(leftTopPart[0]);
    top = int.parse(leftTopPart[1].substring(0, leftTopPart[1].length - 1));
    width = int.parse(widthHeightPart[0]);
    height = int.parse(widthHeightPart[1]);

    return Claim(id, left, top, width, height);
  }
}

typedef XY = (int, int);

void main() async {
  String file_input = await File('input.txt').readAsString();
  List<Claim> processed_input = file_input
      .trim()
      .split('\n')
      .map((line) => Claim.fromString(line))
      .toList();

  print('Silver: ${silver(processed_input)}');
  print('Gold: ${gold(processed_input)}');
}

int silver(List<Claim> claims) {
  Map<XY, int> fabric = {};

  claims.forEach((claim) {
    for (int i = 0; i < claim.width; i++) {
      for (int j = 0; j < claim.height; j++) {
        XY xy = (claim.left + i, claim.top + j);
        fabric[xy] = (fabric[xy] ?? 0) + 1;
      }
    }
  });

  return fabric.values.where((value) => value > 1).length;
}

int? gold(List<Claim> claims) {
  Map<XY, int> fabric = {};

  // Create a map of fabric
  claims.forEach((claim) {
    for (int i = 0; i < claim.width; i++) {
      for (int j = 0; j < claim.height; j++) {
        XY xy = (claim.left + i, claim.top + j);
        fabric[xy] = (fabric[xy] ?? 0) + 1;
      }
    }
  });

  for (Claim claim in claims) {
    bool overlapping = false;
    for (int i = 0; i < claim.width; i++) {
      for (int j = 0; j < claim.height; j++) {
        XY xy = (claim.left + i, claim.top + j);
        if (fabric[xy] != 1) {
          overlapping = true;
          break;
        }
      }
      if (overlapping) break;
    }
    if (!overlapping) return claim.id;
  }
  return null;
}
