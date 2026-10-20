class Character extends GameObject
{
  float speed;
  float character_height;
  float size;

  Character(GameTypes type, float pixel_x, float pixel_y, float speed, float size)
  {
    super(type, pixel_x, pixel_y, size);
    this.speed = speed;
    this.size = size;
  }

  void move()
  {
  }

  CollisionResult checkCollision()
  {

    for (int i = 0; i < game_objects.size(); i++)
    {
      GameObject collision_object = game_objects.get(i);
      float collision_size_object = collision_object.size;

      if (!collision_object.getType().equals(getType()))
      {
        float object_pixel_x = collision_object.getPixelX();
        float object_pixel_y = collision_object.getPixelY();

        if (object_pixel_x < pixel_x + size &&
          object_pixel_x + collision_size_object > pixel_x &&
          object_pixel_y + collision_size_object > pixel_y &&
          object_pixel_y < pixel_y + size)
        {
          CollisionResult result = new CollisionResult();
          result.object = collision_object;
          result.type = collision_object.getType();
          result.id = i;
        }
      }
    }

    CollisionResult result = new CollisionResult();
    return result;
  }

  void checkBorders(float image_height)
  {
    if (pixel_y <= 0 + character_height)
    {
      pixel_y = 0 + character_height;
    } else if (pixel_y >= lower_border - image_height * SCALE)
    {
      pixel_y = lower_border - image_height * SCALE;
    }
  }

  void update()
  {
  }
}
