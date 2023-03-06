void DDA(float startX, float startY, float endX, float endY) {
  PVector rayStart = new PVector(startX / pxSize, startY / pxSize);
  PVector rayEnd = new PVector(endX / pxSize, endY / pxSize);
  PVector rayDir = new PVector();
  rayDir = (rayEnd.sub(rayStart)).normalize();

  //rayDir = PVector.fromAngle(PI);

  PVector rayStep = new PVector(sqrt(1 + (rayDir.y * rayDir.y) / (rayDir.x * rayDir.x)), sqrt(1 + (rayDir.x * rayDir.x) / (rayDir.y * rayDir.y)));
  PVector axisStep = new PVector();
  PVector rayLength = new PVector();

  PVector mapCheck = new PVector(int(startX / pxSize), int(startY / pxSize));

  boolean found = false;

  float foundLen = 0;
  float maxLen = 100;

  if (rayDir.x < 0) {
    axisStep.x = -1;
    rayLength.x = (rayStart.x - mapCheck.x) * rayStep.x;
  } else {
    axisStep.x = 1;
    rayLength.x = (mapCheck.x + 1 - rayStart.x) * rayStep.x;
  }
  if (rayDir.y < 0) {
    axisStep.y = -1;
    rayLength.y = (rayStart.y - mapCheck.y) * rayStep.y;
  } else {
    axisStep.y = 1;
    rayLength.y = (mapCheck.y + 1 - rayStart.y) * rayStep.y;
  }

  while (!found && foundLen < maxLen) {
    if (rayLength.x < rayLength.y) {
      mapCheck.x += axisStep.x;
      foundLen = rayLength.x;
      rayLength.x += rayStep.x;
    } else {
      mapCheck.y += axisStep.y;
      foundLen = rayLength.y;
      rayLength.y += rayStep.y;
    }

    if (mapCheck.y >= 0 && mapCheck.y < mapHeight && mapCheck.x >= 0 && mapCheck.x < mapWidth)
      if (map[int(mapCheck.y)][int(mapCheck.x)] == 1)
        found = true;
  }

  if (found) {
    PVector intersection = new PVector();
    intersection.set(rayStart.add(rayDir.mult(foundLen)));

    if (debug) {
      noStroke();
      fill(#EDE722);
      circle(intersection.x * pxSize, intersection.y * pxSize, 16);
    }
  }
}

float DDA(float startX, float startY, float angle) {
  PVector rayStart = new PVector(startX / pxSize, startY / pxSize);
  PVector rayDir = new PVector();
  rayDir = (PVector.fromAngle(angle)).normalize();

  //rayDir = PVector.fromAngle(PI);

  PVector rayStep = new PVector(sqrt(1 + (rayDir.y * rayDir.y) / (rayDir.x * rayDir.x)), sqrt(1 + (rayDir.x * rayDir.x) / (rayDir.y * rayDir.y)));
  PVector axisStep = new PVector();
  PVector rayLength = new PVector();

  PVector mapCheck = new PVector(int(startX / pxSize), int(startY / pxSize));

  boolean found = false;

  float foundLen = 0;
  float maxLen = 100;

  if (rayDir.x < 0) {
    axisStep.x = -1;
    rayLength.x = (rayStart.x - mapCheck.x) * rayStep.x;
  } else {
    axisStep.x = 1;
    rayLength.x = (mapCheck.x + 1 - rayStart.x) * rayStep.x;
  }
  if (rayDir.y < 0) {
    axisStep.y = -1;
    rayLength.y = (rayStart.y - mapCheck.y) * rayStep.y;
  } else {
    axisStep.y = 1;
    rayLength.y = (mapCheck.y + 1 - rayStart.y) * rayStep.y;
  }

  while (!found && foundLen < maxLen) {
    if (rayLength.x < rayLength.y) {
      mapCheck.x += axisStep.x;
      foundLen = rayLength.x;
      rayLength.x += rayStep.x;
      hitWallSide = 1;
    } else {
      mapCheck.y += axisStep.y;
      foundLen = rayLength.y;
      rayLength.y += rayStep.y;
      hitWallSide = 0;
    }

    if (mapCheck.y >= 0 && mapCheck.y < mapHeight && mapCheck.x >= 0 && mapCheck.x < mapWidth)
      if (map[int(mapCheck.y)][int(mapCheck.x)] == 1)
        found = true;
  }

  if (found) {
    PVector intersection = new PVector();
    intersection.set(rayStart.add(rayDir.mult(foundLen)));

    if (debug) {
      noStroke();
      fill(#EDE722);
      circle(intersection.x * pxSize, intersection.y * pxSize, 16);
    }

    return foundLen;
  } else return -1;
}
