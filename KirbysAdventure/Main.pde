// GLOBALE VARIABLEN
int SCALE = 2;
int KIRBY_SPEED = 2;
int SHOOTING_STAR_SPEED = 50;
int SPEED = 4;
float STAR_ANIMATION_SPEED = 0.8;

float kirby_x;
float kirby_y;
float lower_border;

KeyHandler key_handler;
Background sky_background;
Kirby kirby;
EnergyBall energy_ball;
KirbyStar kirby_star;

void setup()
{
  size(800, 600);
  key_handler = new KeyHandler();
  sky_background = new Background();
  lower_border = height - sky_background.stats_bar_height;
  
  // Kirby:
  kirby = new Kirby(100,200,15);  
  kirby_x = kirby.pixel_x;
  kirby_y = kirby.pixel_y;
  
  kirby_star = new KirbyStar(kirby_x, kirby_y, SHOOTING_STAR_SPEED);
  
  // Energy Ball:
  energy_ball = new EnergyBall (600,200,10);
  
}

void draw()
{
  sky_background.drawing();
  sky_background.bewege();
  
  updateKirby();
  kirby.drawObject();
  //kirby.updateKirby();
  kirby.update();
  kirby.move();  
  kirby.checkBorders(kirby.flying_height);
  
  energy_ball.drawObject();
  energy_ball.move();
  energy_ball.checkBorders(energy_ball.flying_height);
}

void updateKirby()
{
  kirby_x = kirby.pixel_x;
  kirby_y = kirby.pixel_y;
}

void keyPressed() 
{
  key_handler.pressed();
}

void keyReleased() 
{
  key_handler.released();
}
