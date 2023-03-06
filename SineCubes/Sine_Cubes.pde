float angle_offset = 0;
float magic_angle = atan(1/sqrt(2));

int box_size = 20;
int x_box_number = 15;
int y_box_number = 15;

float moving_angle_offset;
float dist_angle_offset;

void setup() {
  size(1080, 720, P3D);

  ortho(-600, 600, -500, 500);
  noStroke();
}

void draw() {
  background(#febad4);
  rectMode(CENTER);


  //Isometric view//
  translate(328, 105);
  rotateX(-magic_angle);
  rotateY(QUARTER_PI);


  //Camera lights & color
  lightSpecular(55, 45, 55);
  directionalLight(82, 79, 83, 0, 1, 0);
  directionalLight(96, 68, 96, -1, 0, -1);
  emissive(119, 93, 178);
  specular(24, 19, 21);


  //Box drawing loop
  for (int y = 0; y < y_box_number; y++)
    for (int x = 0; x < x_box_number; x ++) {
      push();

      translate(x * box_size, height/2, y * box_size);
      dist_angle_offset = dist(x, y, x_box_number / 2, y_box_number / 2) * 0.7;
      box(box_size, sin(moving_angle_offset - dist_angle_offset) * 100 + 150, box_size);
      //box(box_size, map(noise(x, y, moving_angle_offset * 0.1), 0, 1, 50, 500), box_size);

      pop();
    }
  moving_angle_offset += 0.05;
}
