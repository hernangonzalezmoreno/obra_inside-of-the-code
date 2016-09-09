class Camara{
  
  PVector posicion, posicionFocal;
  float distanciaFocal, distanciaHorizontalFocal;
  float anguloHorizontal, anguloVertical;
  
  final float cameraZ = ( ( height / 2.0 ) / tan( PI * 60.0/360.0 ) );
  float anguloDeVision = PI/3.0;
  final float relacionDeAspecto = 1.6;//---> width/height
  
  int movimientoCamara;
  static final int MOVIMIENTO_CAMARA_CAMINAR = 0, MOVIMIENTO_CAMARA_VOLAR = 1;
  
  //-------------------------------------- CONSTRUCTOR
  Camara(){
    
    posicion = new PVector();
    posicionFocal = new PVector();
    
    
    anguloHorizontal = 0.0;
    anguloVertical = 0.0;
    distanciaFocal = 100;//100
    
    posicionFocal.z = distanciaFocal;
    
    
    setPosicionYFoco( new PVector(1080.565, 5915.6455, 539.20264), new PVector(1091.2621, 5993.935, 477.91367) );
  }
  
  //-------------------------------------- SETS
  void setPosicionYFoco( PVector p, PVector pf ){
    posicion = p;
    posicionFocal = pf;
  }
  
  void setMovimientoCamara( int mc ){
    if( mc == MOVIMIENTO_CAMARA_CAMINAR || mc == MOVIMIENTO_CAMARA_VOLAR ){
      movimientoCamara = mc;
    }else{
      println( "ADVERTENCIA: setMovimientoCamara( int ) parametro invalido. Usar variable static de Camara." );
    }
  }
  
  //-------------------------------------- ACTUALIZAR
  void actualizar(){
    calcular_YFocal();
    calcular_XFocalZFocal();
  }
  
  void actualizar_Angulos(float horizontal, float vertical){
    
    float nuevoAnguloHorizontal = anguloHorizontal + horizontal;
    
    if( nuevoAnguloHorizontal > PI ){
      anguloHorizontal = nuevoAnguloHorizontal - TWO_PI;
    }else if( nuevoAnguloHorizontal < -PI ){
      anguloHorizontal = nuevoAnguloHorizontal + TWO_PI;
    }else{
      anguloHorizontal = nuevoAnguloHorizontal;
    }
    
    float nuevoAnguloVertical = anguloVertical + vertical;
    
    anguloVertical = constrain( nuevoAnguloVertical, -HALF_PI + 0.0001, HALF_PI - 0.0001 );
    
  }
    
  void actualizar_XYZ( float movimiento_anteroposterior, float movimiento_vertical, float movimiento_transversal ){
    
    if( movimientoCamara == MOVIMIENTO_CAMARA_CAMINAR ){
      actualizarXYZ_CAMINAR( movimiento_anteroposterior, movimiento_transversal );
    }else{
      actualizarXYZ_VOLAR( movimiento_anteroposterior, movimiento_transversal );
    }

  }
  
  void actualizarXYZ_CAMINAR( float movimiento_anteroposterior, float movimiento_transversal ){
    
    float ma_componenteX = movimiento_anteroposterior * cos( anguloHorizontal );
    float ma_componenteZ = movimiento_anteroposterior * sin( anguloHorizontal );
    
    float mt_componenteX = movimiento_transversal * cos( anguloHorizontal + HALF_PI );
    float mt_componenteZ = movimiento_transversal * sin( anguloHorizontal + HALF_PI );
    
    float movimientoX = ma_componenteX + mt_componenteX;
    float movimientoZ = ma_componenteZ + mt_componenteZ;
    float movimientoY = 0;
    
    posicion.x = posicion.x + movimientoX;
    posicion.y = posicion.y + movimientoY;
    posicion.z = posicion.z + movimientoZ;
    
  }
  
  void actualizarXYZ_VOLAR( float movimiento_anteroposterior, float movimiento_transversal ){
    
    float ma_componenteY = movimiento_anteroposterior * sin( anguloVertical );
    
    float movimiento_anteroposterior_XZ = movimiento_anteroposterior * cos( anguloVertical );
    
    float ma_componenteX = movimiento_anteroposterior_XZ * cos( anguloHorizontal );
    float ma_componenteZ = movimiento_anteroposterior_XZ * sin( anguloHorizontal );
    
    float mt_componenteX = movimiento_transversal * cos( anguloHorizontal + HALF_PI );
    float mt_componenteZ = movimiento_transversal * sin( anguloHorizontal + HALF_PI );
    
    float movimientoX = ma_componenteX + mt_componenteX;
    float movimientoZ = ma_componenteZ + mt_componenteZ;
    float movimientoY = ma_componenteY;
    
    posicion.x = posicion.x + movimientoX;
    posicion.y = posicion.y + movimientoY;
    posicion.z = posicion.z + movimientoZ;
    
  }
  
  void calcular_YFocal(){
    posicionFocal.y = posicion.y + distanciaFocal * sin( anguloVertical );
    distanciaHorizontalFocal = distanciaFocal * cos( anguloVertical );
  }
  
  void calcular_XFocalZFocal(){
    posicionFocal.x = posicion.x + distanciaHorizontalFocal * cos( anguloHorizontal );
    posicionFocal.z = posicion.z + distanciaHorizontalFocal * sin( anguloHorizontal );
  }
  
  //-------------------------------------- DIBUJAR
  
  void dibujar(){
    beginCamera();
      perspective(anguloDeVision, relacionDeAspecto, cameraZ/10.0, cameraZ*10.0);
      camera( posicion.x, posicion.y, posicion.z, posicionFocal.x, posicionFocal.y, posicionFocal.z, 0.0, 1.0, 0.0 );
    endCamera();
  }

  void dibujar( PGraphics pg ){
    pg.beginCamera();
      pg.perspective(anguloDeVision, relacionDeAspecto, cameraZ/10.0, cameraZ*10.0);
      pg.camera( posicion.x, posicion.y, posicion.z, posicionFocal.x, posicionFocal.y, posicionFocal.z, 0.0, 1.0, 0.0 );
    pg.endCamera();
  }
  
}