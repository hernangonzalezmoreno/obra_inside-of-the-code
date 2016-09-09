class Autolectura {

  String [] archivos;

  final String [][] palabras = {
    { "if", "else", "for", "try", "catch", "switch" }, 
    { "int", "float", "String", "boolean", "PGraphics", "PVector", "color", "char" }, 
    { "println", "fill", "textSize", "pushMatrix", "popMatrix", "translate", "text", "indexOf", "equals", "draw", "setup", "atan2", "dist", 
    "sin", "cos", "keyPressed", "keyReleased", "loadStrings", "textWidth", "charAt", "substring", "exit", "round", "noCursor", "textFont",
    "loadFont", "list", "tan", "hint", "popStyle", "pushStyle", "background", "ambientLight", "fullScreen" }, 
    { "false", "true", "class", "extends", "void", "final", "case", "break", "new", "null", "length", "this", "super", "static", "PI", "TWO_PI", "HALF_PI", "import",
      "P2D", "P3D", "ENTER", "return", "continue" }, 
    { "frameRate", "width", "height", "mouseX", "mouseY", "key" }
  };

  final color [] colores = {
    #689a03, 
    #e36a20, 
    #006699, 
    #359a80, 
    #d94a7a
  };

  final color colGeneral = #090909;
  final color colComentario = #999999;
  final color colString = #7d4793;

  Autolectura() {

    File directorio = new File( dataPath("..") );

    archivos = new String[ directorio.list().length - 1 ];
   
    int index = 0;
    for( String nombre : directorio.list() ){
      
      if( ! nombre.equals( "data" ) ){
        archivos[ index ] = nombre;
        index++;
      }
      
    }
    
    hint( DISABLE_DEPTH_TEST );
    
  }

  void dibujar( PGraphics pg ) {

    if ( archivos == null ) {
      println("La carpeta no existe o no se puede acceder");
    } else {
      
      /*
      for ( int i = archivos.length - 1; i >= 0 ; i-- ) {
        leerAvanzado( pg, archivos[ i ], i );
      }
      */
      
      for ( int i = 0; i < archivos.length ; i++ ) {
        leerAvanzado( pg, archivos[ i ], i );
      }
      
    }
  }

  void leer( PGraphics pg, String ruta, int z ) {
    String [] lines = loadStrings( ruta );

    int tamano = 30;
    pg.textSize( tamano );
    pg.fill( 224, 160, 64 );

    for ( int i = 0; i < lines.length; i++ ) {
      pg.pushMatrix();
      pg.translate( 0, i * tamano, z );
      pg.text( lines[ i ], 0, 0, 0 );
      pg.popMatrix();
    }
  }

  void leerAvanzado( PGraphics pg, String ruta, int indexArchivo ) {
    String [] lines = loadStrings( ruta );

    int tamano = 30;
    pg.textSize( tamano );


    for ( int i = 0; i < lines.length; i++ ) {

      pg.pushMatrix();
      pg.translate( 0, i * tamano, indexArchivo*200 );
      //pg.rotateY( ( TWO_PI / archivos.length ) * indexArchivo );
      pg.translate( 100, i * tamano, 0 );
      
      int [] aux = new int [6];

      for ( int j = 0; j < lines[ i ].length (); j++ ) {

        aux[0] = lines[ i ].indexOf(" ", j );
        aux[1] = lines[ i ].indexOf(".", j );
        aux[2] = lines[ i ].indexOf("(", j );
        aux[3] = lines[ i ].indexOf(";", j );
        aux[4] = lines[ i ].indexOf('"', j );
        aux[5] = lines[ i ].indexOf("//", j );

        if ( aux[ 0 ] == -1 && aux[1] == -1 && aux[2] == -1 && aux[3] == -1 && aux[ 4 ] == -1 && aux[ 5 ] == -1 ) {

          if ( j == 0 ) {
            pg.fill( colGeneral );
            pg.text( lines[ i ], 0, 0, 0 );
          } else {

            String recorte = lines[ i ].substring( j );

            pg. fill ( colGeneral );
            pg. text ( recorte, pg.textWidth( lines[i].substring( 0, j ) ), 0, 0 );
          }

          j = lines[ i ]. length ();
        } else {

          int auxMenor = ( aux[0] != -1 )? aux[0] : 100000 ;
          if ( aux[ 1 ] != -1 ) auxMenor = ( aux[1] < auxMenor )? aux[1] : auxMenor;
          if ( aux[ 2 ] != -1 ) auxMenor = ( aux[2] < auxMenor )? aux[2] : auxMenor;
          if ( aux[ 3 ] != -1 ) auxMenor = ( aux[3] < auxMenor )? aux[3] : auxMenor;
          
          boolean comillas = false;
          if( aux[ 4 ] != -1 ){
            if( aux[4] < auxMenor ){
              auxMenor = aux[4];
              comillas = true;
            }
          }
          
          if( aux[ 5 ] != -1 ){
            if( aux[5] < auxMenor ){
              
              auxMenor = aux[ 5 ];
              comillas = false;
              
              String recorte = lines[ i ].substring( j, auxMenor );
              color pintar = colGeneral;
              
              pg.fill( pintar );
              pg.text( recorte, pg.textWidth( lines[i].substring( 0, j ) ), 0, 0 );
              
              recorte = lines[ i ].substring( auxMenor, lines[ i ].length () );
              
              pintar = colComentario;
              pg.fill( pintar );
              pg.text( recorte, pg.textWidth( lines[i].substring( 0, auxMenor ) ), 0, 0 );
              
              break;
            }
          }
          
          if( comillas ){
            
            String recorte = lines[ i ].substring( j, auxMenor );
            color pintar = colGeneral;
            
            pg.fill( pintar );
            pg.text( recorte, pg.textWidth( lines[i].substring( 0, j ) ), 0, 0 );
            
            try {
              int finalComillas = lines[ i ].indexOf('"', auxMenor+1 );
              recorte = lines[ i ].substring( auxMenor, finalComillas );
              
              pintar = colString;
              pg.fill( pintar );
              pg.text( recorte + '"', pg.textWidth( lines[i].substring( 0, auxMenor ) ), 0, 0 );
              
              j = finalComillas;
              continue;
            } catch( Exception e ){
              j = auxMenor;
              continue;
            }
            
          }
            
          String recorte = lines[ i ]. substring ( j, auxMenor );

          color pintar = colGeneral;

          boolean salir = false;

          for ( int indexPalabras = 0; indexPalabras < palabras.length; indexPalabras++ ) {

            for ( int p = 0; p < palabras[ indexPalabras ].length; p++ ) {

              if ( palabras[ indexPalabras ][ p ].equals( recorte ) ) {

                pintar = colores[ indexPalabras ];
                salir = true;
                break;
              }

              if ( salir ) break;
            }
          }

          pg.fill( pintar );

          pg.text( recorte, pg.textWidth( lines[i].substring( 0, j ) ), 0, 0 );

          char caracter = lines[ i ].charAt( auxMenor );
          if ( caracter != ' ' ) {
            pg.fill ( colGeneral );
            pg.text( lines[ i ]. charAt ( auxMenor ), pg.textWidth( lines[i].substring( 0, auxMenor ) ), 0, 0 );
          }

          j = auxMenor;
        
        }
      }


      pg.popMatrix();
    }
  }
}