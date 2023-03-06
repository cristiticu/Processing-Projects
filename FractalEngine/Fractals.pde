int precision = 255;

int widthPixelValue;
int heightPixelValue;

float mappedWidth;
float mappedHeight;

int fadeCount = 0;

int result;
int mappedResult;

color screenColor;
int brightness;

int CopacDubios(float cim, float cre) {
  float fcim, fcre;

  int counter = 0;

  for (; counter < precision && abs(cim + cre) < 16; counter++) {
    fcre = 2*cim*cre;
    fcim = cre*cre - cim*cim;

    cim += fcim;
    cre += fcre;
  }
  return counter;
}

int Mandelbrot(float cim, float cre) {
  float copcim = cim, copcre = cre;
  float rescim, rescre;
  int counter = 0;

  for (; counter < precision && abs(cim + cre) < 16; counter++) {
    rescre = cre * cre - cim * cim;
    rescim = 2 * cre * cim;

    cim = copcim + rescim;
    cre = copcre + rescre;
  }
  return counter;
}

int SinkingShip(float cim, float cre) {
  float copcim = cim, copcre = cre;
  float rescre;
  int counter = 0;

  for (; counter < precision && abs(cim + cre) < 4; counter++) {
    rescre = cre * cre - cim * cim + copcre;
    cim = abs(2*cre*cim) + copcim;

    cre = rescre;
  }
  return counter;
}

int TestFractal(float cim, float cre) {
  float copcim = cim;
  float rescim, rescre;
  int counter = 0;

  for (; counter < precision && abs(cim + cre) < 12; counter++) {
    rescim = copcim * cim + log(cre);
    rescre = rescim - cre * cre;

    cre = rescim;
    cim = rescre;
  }
  return counter;
}

int ChirikovMap(float cim, float cre) {
  float copcim = cim, copcre = cre;
  int counter = 0;

  for (; counter < precision && abs(cim + cre) < 16; counter++) {
    cim += copcim*sin(cre);
    cre += copcre * cim;
  }
  return counter;
}

void setup() {
  fullScreen(P2D);
  //size(1080, 720, P2D);
  colorMode(HSB);
}

void draw() {
  fadeCount++;

  if (fadeCount == 256) {
    fadeCount = 0;
  }

  for (widthPixelValue = 0; widthPixelValue < width; widthPixelValue++)
    for (heightPixelValue = 0; heightPixelValue < height; heightPixelValue++) {
      //Pentru Chirikov: -10, 10 la map
      //Pentru Mandelbrot, Copac si Sinking trebuie -2, 2
      //Mandelbrot better : -2.2, 1 WIDTH, -1.2 1.2 HEIGHT

      mappedWidth = map(widthPixelValue, 0, width, -2.2, 1);
      mappedHeight = map(heightPixelValue, 0, height, -1.2, 1.2);

      result = Mandelbrot(mappedHeight, mappedWidth);   
      
      screenColor = color(result+16, 149, 120);

      set(widthPixelValue, heightPixelValue, screenColor);
    }
}
