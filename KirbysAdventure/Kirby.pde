// GLOBALE VARIABLEN
int SCALE = 1;

KeyHandler key_handler;
Background sky_background;

void setup()
{
  size(800, 600);
  key_handler = new KeyHandler();
  sky_background = new Background();
}

void draw()
{
  sky_background.drawing(0,0);
}

void keyPressed() 
{
  key_handler.pressed();
}

void keyReleased() 
{
  key_handler.released();
}
