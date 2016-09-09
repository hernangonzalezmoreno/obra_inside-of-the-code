class Motor{

  ControladorCamara camara1;
  
  Autolectura autolectura;

  //---------------------------------------- CONSTRUCTOR
  Motor(){
    
    camara1 = new ControladorCamara();
    camara1.setMovimientoCamara( Camara.MOVIMIENTO_CAMARA_VOLAR );
    
    autolectura = new Autolectura();
    
  }
  
  //---------------------------------------- ACTUALIZAR
  void actualizar(){
    camara1.actualizar();
    actualizarVentana3D();
  }
  
  void actualizarVentana3D(){
        
  }
  
  //---------------------------------------- DIBUJAR
  void dibujar(){
    
    dibujarSobreVentana3D( p5.g );
        
    camara1.dibujar( p5.g );
    
  }
  
  void dibujarSobreVentana3D( PGraphics pg ){
    
    
    //pg.beginDraw();
    
    pg.ambientLight(255,255,255);
    
    pg.pushStyle();
    
    pg.background( #E0E0E0 );

    // cualquier metodo llamado aca hay que enviarle alguna instancia de algun PGraphics para que pueda trabajar 
    
    autolectura.dibujar( pg );

    pg.popStyle();
    //pg.endDraw();
    
  }
  
  //-------------------------------------- EVENTOS
  void keyPressed(){
    camara1.keyPressed();
  }
  
  void keyReleased(){
    camara1.keyReleased();
  }
}