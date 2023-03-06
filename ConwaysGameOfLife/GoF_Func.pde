class GoF_Func {
  int pxheight;
  int pxwidth;
  int pxcell_size;

  int cell_matrix[][];
  int temp_cell_matrix[][];
  int matrix_width;
  int matrix_height;

  int step_array[];
  
  int neighbour_number;

  //Constructor//
  GoF_Func(int tempheight, int tempwidth, int tempcell_size) {
    pxheight = tempheight;
    pxwidth = tempwidth;
    pxcell_size = tempcell_size;

    matrix_width = pxwidth/pxcell_size;
    matrix_height = pxheight/pxcell_size;

    cell_matrix = new int[matrix_height][matrix_width];
    step_array = new int[]{-1, 0, 1};
  }

  void think() {
    temp_cell_matrix = new int[matrix_height][matrix_width];

    for (int i = 0; i < matrix_height; i++)
      for (int j = 0; j < matrix_width; j++) {
        neighbour_number = (cell_matrix[i][j] == 1) ? -1 : 0;
        
        for(int istep = 0; istep < 3; istep++)
          for(int jstep = 0; jstep < 3; jstep++){
            int tempi = i + step_array[istep];
            int tempj = j+ step_array[jstep];
            
            if(tempi < 0)
              tempi = matrix_height - 1;
            else if(tempi >= matrix_height)
              tempi = 0;
              
            if(tempj < 0)
              tempj = matrix_width - 1;
            else if(tempj >= matrix_width)
              tempj = 0;
              
              neighbour_number += cell_matrix[tempi][tempj];
          }
      
      if((neighbour_number == 2 || neighbour_number == 3) && cell_matrix[i][j] == 1)
        temp_cell_matrix[i][j] = 1;
      else if(neighbour_number == 3 && cell_matrix[i][j] == 0)
        temp_cell_matrix[i][j] = 1;
      else temp_cell_matrix[i][j] = 0;
      }
    cell_matrix = temp_cell_matrix.clone();
  }

  void render() {
    background (#343434);
    
    for(int i = 0; i < matrix_height; i++)
      for(int j = 0; j < matrix_width; j++)
        if(cell_matrix[i][j] == 1){
          square(j*pxcell_size, i*pxcell_size, pxcell_size);
        }
  }
  
  void setlive(int icoord, int jcoord){
    icoord /= pxcell_size;
    jcoord /= pxcell_size;
    
    cell_matrix[icoord][jcoord] = 1;
  }
  
}
