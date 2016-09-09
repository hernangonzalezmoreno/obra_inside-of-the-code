class ControladorCamara extends Camara{
  
  final int W = 87;
  final int A = 65;
  final int S = 83;
  final int D = 68;
  final int SHIFT_TECLA = 16;
  
  final float F_CAMINAR = 4;
  final float F_CORRER = 10;
  
  boolean avanzar, retroceder, izquierda, derecha, correr;
  boolean mirar_Arriba, mirar_Abajo, mirar_Izquierda, mirar_Derecha; 
  
  float velocidad, factorCorrer;
  float umbral;
  
  //-------------------------------------- CONSTRUCTOR
  ControladorCamara(){
    super();
    velocidad = 2;
    umbral = height * 0.25;
  }
  
  //-------------------------------------- ACTUALIZAR
  void actualizar(){
    actualizar_mirada();
    actualizar_movimiento();
    super.actualizar();
  }
  
  void actualizar_mirada(){
    
    float distancia = dist( rmx, rmy, prmx, prmy );
    float angulo = 0.0;
    
    if( distancia > 0 ){
      angulo = atan2( rmy - prmy, rmx - prmx );
    }
    
    float rotacion_horizontal = distancia * cos( angulo );
    float rotacion_vertical = distancia *sin( angulo );
    
    rotacion_horizontal *= 0.002;
    rotacion_vertical *= 0.002;
    
    actualizar_Angulos( rotacion_horizontal, rotacion_vertical );
    
    
  }
  
  void actualizar_movimiento(){
    
    factorCorrer = ( correr )? F_CORRER : F_CAMINAR;
    
    float movimientoAnteroposterior = calcular_movimientoAnteroposterior();
    float movimientoVertical = 0;
    float movimientoTransversal = calcular_movimientoTransversal();
    
    actualizar_XYZ( movimientoAnteroposterior, movimientoVertical, movimientoTransversal );
  }
  
  float calcular_movimientoAnteroposterior(){
    float ma = 0;
      if( avanzar ){
        ma = velocidad * factorCorrer;
      }
      if( retroceder ){
        ma = -velocidad * factorCorrer;
      }
    return ma;
  }
  
  float calcular_movimientoTransversal(){
    float mt = 0;
      if( derecha ){
        mt = velocidad * factorCorrer;
      }
      if( izquierda ){
        mt = -velocidad * factorCorrer;
      }
    return mt;
  }
  

  
  //-------------------------------------- EVENTO
  void keyPressed(){
    switch( keyCode ){
      case W:
        avanzar = true;
        break;
      case S:
        retroceder = true;
        break;
      case A:
        izquierda = true;
        break;
      case D:
        derecha = true;
        break;
      case SHIFT_TECLA:
        correr = true;
        break;
      default:
        break;
    }
  }
  
  void keyReleased(){
    switch( keyCode ){
      case W:
        avanzar = false;
        break;
      case S:
        retroceder = false;
        break;
      case A:
        izquierda = false;
        break;
      case D:
        derecha = false;
        break;
      case SHIFT_TECLA:
        correr = false;
        break;
      default:
        break;
    }
  }
  
}