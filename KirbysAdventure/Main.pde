import java.nio.file.Files;
import java.nio.file.Path;

// GLOBALE VARIABLEN
// --------------------
int SCALE = 2;
float STAR_ANIMATION_SPEED = 0.8;
float ENERGY_BALL_ANIMATION_SPEED = 1;

// Geschwindigkeiten
int SPEED = 4;
int KIRBY_SPEED = 15;
int SHOOTING_STAR_SPEED = 50;
int SHOOTING_ENEMY_SPEED = 20;
int ENERGY_BALL_SPEED = 5;

float kirby_x;
float kirby_y;
float kirby_start_x = 100;
float kirby_start_y = 200;

float kirby_health_x = 200;
float kirby_health_y = 495;

float energy_ball_x;
float energy_ball_y;

float kirby_size;
float energy_ball_size;
float star_size;

float lower_border;

boolean energy_ball_collided_with_star = false;
boolean kirby_collided_with_star = false;

ArrayList<GameObject> game_objects;

NormalImage energy_ball_image;
NormalImage kirby_image;
NormalImage star_image;

KeyHandler key_handler;
Background sky_background;
Kirby kirby;
EnergyBall energy_ball;
KirbyStar kirby_star;
EnergyBallStar star_1;
EnergyBallStar star_2;
EnergyBallStar star_3;
Timer timer;
EnemyHealth enemy_health;
KirbyHealth kirby_health;

void setup()
{
  size(800, 600);
  
  // Images:
  energy_ball_image = new NormalImage("enemy/flying_1.png");
  kirby_image = new NormalImage("kirby/flying.png");
  star_image = new NormalImage("star/kirby/star_1.png");
  
  key_handler = new KeyHandler();
  sky_background = new Background();
  
  // Untere Grenze vom Spielfeld
  lower_border = height - sky_background.stats_bar_height;

  // Game Objects:
  game_objects = new ArrayList<GameObject>();

  // Timer:
  timer = new Timer(10); // Neuer Timer für 2s oder 2000ms
  timer.start();

  // Kirby:
  kirby = new Kirby(kirby_start_x, kirby_start_y, KIRBY_SPEED);
  kirby.size = kirby_image.image_height * 2;
  kirby_size = kirby.size;
  game_objects.add(kirby);
  kirby_x = kirby.pixel_x;
  kirby_y = kirby.pixel_y;
  
  // Kirbys Stern:
  kirby_star = new KirbyStar(kirby_x, kirby_y, SHOOTING_STAR_SPEED);
  kirby_star.size = star_image.image_height * 2;
  game_objects.add(kirby_star);
  kirby_health = new KirbyHealth(kirby_health_x, kirby_health_y, 10); //! size wird hier nicht gebraucht vielleicht auf Klassen beschränken wo es gebraucht wird

  // Energy Ball:
  energy_ball = new EnergyBall (600, 200, ENERGY_BALL_SPEED);
  energy_ball.size = energy_ball_image.image_height * 2;
  game_objects.add(energy_ball);
  enemy_health = new EnemyHealth(200, 537, 300);
  energy_ball_x = energy_ball.pixel_x;
  energy_ball_y = energy_ball.pixel_y;
  
  // Energy Ball Stern:
  star_1 = new EnergyBallStar(energy_ball_x, energy_ball_y, SHOOTING_ENEMY_SPEED, "LEFT");
  star_1.size = star_size;
  game_objects.add(star_1);
  star_2 = new EnergyBallStar(energy_ball_x, energy_ball_y, SHOOTING_ENEMY_SPEED, "LEFT_UP");
  star_2.size = star_size;
  game_objects.add(star_2);
  star_3 = new EnergyBallStar(energy_ball_x, energy_ball_y, SHOOTING_ENEMY_SPEED, "LEFT_DOWN");
  star_3.size = star_size;
  game_objects.add(star_3);
  
   
  // Star:
  star_size = star_image.image_height * 2;
}

void draw()
{     
  sky_background.drawing();
  sky_background.bewege();
  sky_background.drawStats();

  updateKirby();
  kirby.update();
  kirby.drawObject();  
  kirby.move();
  //rect(star_1.pixel_x, star_1.pixel_y, star_size, star_size);
  //println(kirby_size);
  kirby.checkBorders(kirby.flying_height);

  updateEnergyBall();
  energy_ball.drawObject();
  energy_ball.update(); 
  sky_background.drawStats();
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

void updateEnergyBall()
{
  energy_ball_x = energy_ball.pixel_x;
  energy_ball_y = energy_ball.pixel_y;
}

void keyPressed()
{
  key_handler.pressed();
}

void keyReleased()
{
  key_handler.released();
}
