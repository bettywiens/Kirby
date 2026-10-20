import java.nio.file.Files;
import java.nio.file.Path;

// GLOBALE VARIABLEN
// --------------------
int SCALE = 2;
float STAR_ANIMATION_SPEED = 0.8;
float ENERGY_BALL_ANIMATION_SPEED = 1;

// Geschwindigkeiten
int SPEED = 4;
int KIRBY_SPEED = 2;
int SHOOTING_STAR_SPEED = 50;
int ENERGY_BALL_SPEED = 5;

float kirby_x;
float kirby_y;

float kirby_size;
float energy_ball_size;
float star_size;

float lower_border;

boolean energy_ball_collided_with_star = false;

ArrayList<GameObject> game_objects;

NormalImage energy_ball_image;
NormalImage kirby_image;
NormalImage star_image;

KeyHandler key_handler;
Background sky_background;
Kirby kirby;
EnergyBall energy_ball;
KirbyStar kirby_star;
Timer timer;
EnemyHealth enemy_health;
KirbyHealth kirby_health;

void setup()
{
  energy_ball_image = new NormalImage("enemy/flying_1.png");
  kirby_image = new NormalImage("kirby/flying.png");
  star_image = new NormalImage("star/kirby/star_1.png");
  
  size(800, 600);
  key_handler = new KeyHandler();

  sky_background = new Background();
  lower_border = height - sky_background.stats_bar_height;

  // Game Objects:
  game_objects = new ArrayList<GameObject>();

  // Timer:
  timer = new Timer(10); // Neuer Timer für 2s oder 2000ms
  timer.start();

  // Kirby:
  kirby = new Kirby(100, 200, 15);
  kirby.size = kirby_image.image_height * 2;
  game_objects.add(kirby);
  kirby_x = kirby.pixel_x;
  kirby_y = kirby.pixel_y;

  kirby_star = new KirbyStar(kirby_x, kirby_y, SHOOTING_STAR_SPEED);
  kirby_star.size = star_image.image_height * 2;
  game_objects.add(kirby_star);
  kirby_health = new KirbyHealth(200, 495, 300);

  // Energy Ball:
  energy_ball = new EnergyBall (600, 200, ENERGY_BALL_SPEED);
  energy_ball.size = energy_ball_image.image_height * 2;
  game_objects.add(energy_ball);
  enemy_health = new EnemyHealth(200, 537, 300);
  
  
  // Star:
  star_size = star_image.image_height * 2;
}

void draw()
{   
  //println("Kirby: " + kirby.size);
  //println("Star : " + kirby_star.size);
  //println("Energy Ball: " + energy_ball.size);
  sky_background.drawing();
  sky_background.bewege();

  updateKirby();
  kirby.drawObject();  
  kirby.update();
  kirby.move();
  kirby.checkBorders(kirby.flying_height);

  energy_ball.drawObject();
  energy_ball.move();
  energy_ball.checkBorders(energy_ball.flying_height);
  
  enemy_health.drawObject();
  kirby_health.drawObject();
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
