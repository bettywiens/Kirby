class Character extends GameObject
{
  float speed;
  float character_height;
  float size;
  int health;

  Character(GameTypes type, float pixel_x, float pixel_y, float speed, float size, int health)
  {
    super(type, pixel_x, pixel_y, size);
    this.speed = speed;
    this.size = size;
    this.health = health;
  }

  void move()
  {
  }

  CollisionResult checkCollision(float pixel_x, float pixel_y, String type)
  { 
    // es wird durch alle game_objects iteriert
    for (int i = 0; i < game_objects.size(); i++)
    {
      GameObject collision_object = game_objects.get(i);      

      float collision_size = collision_object.size;

      if (!collision_object.getType().equals(getType()))
      {
        float object_pixel_x1 = collision_object.getPixelX();
        float object_pixel_y1 = collision_object.getPixelY();

        float object_pixel_x2 = object_pixel_x1 + collision_size;
        float object_pixel_y2 = object_pixel_y1 + collision_size;

        if ( type == "enemy" &&
          // An der linken Ecke vorbei:
          (object_pixel_x2 > pixel_x)   &&
          ((object_pixel_y1 > pixel_y && object_pixel_y1 < pixel_y + size) || (object_pixel_y2 > pixel_y && object_pixel_y2 < pixel_y + size))
          )
        {
          CollisionResult result = new CollisionResult();
          result.object = collision_object;
          result.type = collision_object.getType();
          result.id = i;
          return result;
        } else if ( type == "kirby" && (
          // !!! Kollision wird nicht immer wahrgenommen
          ((object_pixel_x1 < (pixel_x + kirby_size) && (object_pixel_x1 > pixel_x)) || 
          (object_pixel_x2 < (pixel_x + kirby_size)) && (object_pixel_x2 > pixel_x)) // Überlappung in der x-Ebene 
          &&
          (
          (object_pixel_y1 < pixel_y + kirby_size && object_pixel_y1 > pixel_y) || // Überlappung in der y-Ebene
          (object_pixel_y2 > pixel_y && object_pixel_y2 < pixel_y + kirby_size) || 
          (object_pixel_y1 > pixel_y && object_pixel_y2 < pixel_y + kirby_size )
          )
          
          )
          )
        {
          CollisionResult result = new CollisionResult();
          result.object = collision_object;
          result.type = collision_object.getType();          
          result.id = i;
          return result;
        }
      }
    }
    return null;
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
