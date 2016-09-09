// "Inside Of The Code" by Hernán GM
// 20/4/2016

import java.awt.Robot;

Robot robot;
float rmx, rmy, prmx, prmy;

PApplet p5;
Motor motor;

//solo para probar como funcionaban aca xD
Reloj reloj;
Consola c;
//-----

void setup() {
  
  //size( 800, 600, P3D );
  fullScreen ( P3D );
  noCursor ();
  textFont( loadFont( "SourceCodePro-Regular-48.vlw" ) );

  p5 = this;
  
  try {
    iniciar();
    motor = new Motor();
  }
  catch( Exception e ) {
    println ( "SETUP ERROR: " + e.getMessage() );
    exit ();
    return;
  }
  
  reloj = new Reloj();
  c = new Consola();
}

void draw() {
  
  reloj.actualizar();

  if ( frameRate < 2 ) {
    println("salir, frameRate inferior a 2");
    exit();
    return;
  }

  try {
    SeguimientoMouseVirtual();
    motor.actualizar();
    motor.dibujar();
  }
  catch( Exception e ) {
    println( "DRAW ERROR: " + e.getMessage() );
    exit();
    return;
  }
  
  c.ejecutar( true );
  
}

void iniciar() {
  try { 
    robot = new Robot();
  }  
  catch(Throwable e) {
  }
}

void keyPressed() {
  motor.keyPressed();
  
  c.printlnAlerta("Alerta presiono la tecla " + key );
  
}

void keyReleased() {
  motor.keyReleased();
  
  if( key == ENTER ){
    println( "Camara:" );
    println( "posicion: " + motor.camara1.posicion );
    println( "posicionFocal: " + motor.camara1.posicionFocal );
    save( "data/capturas/captura_"+ year() + "_" + month() + "_" + day() + "_" + hour() + "_" + minute() + "_" + second() + "_" + millis() + ".png" );
  }
  
}

void SeguimientoMouseVirtual () {

  prmx = rmx;
  prmy = rmy;

  robot.mouseMove(
  round( width * 0.5 ), 
  round( height * 0.5 ) );

  rmx += mouseX - width * 0.5;  
  rmy += mouseY - height * 0.5;
}