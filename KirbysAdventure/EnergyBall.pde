class EnergyBall extends Enemy
{
  AnimationImage flying;
  float flying_height;

  EnergyBall(float pixel_x, float pixel_y)
  {
    super(pixel_x, pixel_y, global.ENERGY_BALL_SPEED, global.energy_ball_size, 28);

    flying = new AnimationImage(images.enemy_flying_path, 4, global.ENERGY_BALL_ANIMATION_SPEED);

    this.flying_height = images.enemy_flying_image.image_height;
  }

  @Override
    void move()
  {
    readFile(images.directions_path);
    checkCollisionWithStar();


    // Wenn Timer vorbei ist bewegt sich EnergyBall abhängig von der direction nach oben oder unten
    if (enemy_timer.isFinished())
    {
      // Wenn der counter die Länge der Datei überschreitet wird er zurückgesetzt
      if (direction_counter >= directions_array.length)
      {
        direction_counter = 0;
      } else
      {
        if (directions_array[direction_counter] == '0')
        {
          goUp();
        } else if (directions_array[direction_counter] == '1')
        {
          goDown();
        } else if (directions_array[direction_counter] == '2')
        {
          goRight(1);
        } else if (directions_array[direction_counter] == '3')
        {
          goLeft(1);
        } else if (directions_array[direction_counter] == 's')
        {
          global.game_objects.add(new EnergyBallStar(pixel_x, pixel_y, global.SHOOTING_ENEMY_SPEED, "LEFT_UP"));
          global.game_objects.add(new EnergyBallStar(pixel_x, pixel_y, global.SHOOTING_ENEMY_SPEED, "LEFT"));
          global.game_objects.add(new EnergyBallStar(pixel_x, pixel_y, global.SHOOTING_ENEMY_SPEED, "LEFT_DOWN"));
          shooting_star = true;
        } else if (directions_array[direction_counter] == 'b')
        {
          global.game_objects.add(new EnergyBallBurst(pixel_x, pixel_y, global.SHOOTING_ENEMY_SPEED, "LEFT"));
          shooting_burst = true;
        }
        enemy_timer.start();
        direction_counter++;
      }
    }
  }

  @Override
    void update()
  {
    super.update(images.enemy_damage, flying_height, flying);
  }
}
