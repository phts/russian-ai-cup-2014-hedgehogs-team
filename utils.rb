module Utils

  TOP_ANGLES = (-Math::PI..0)
  BOTTOM_ANGLES = (0..Math::PI)
  LEFT_ANGLES = [(-Math::PI/2)..(Math::PI/2)]
  RIGHT_ANGLES = [(Math::PI/2)..(Math::PI), (-Math::PI)..(-Math::PI/2)]
  TOP_LEFT_CORNER_ANGLES = [(-Math::PI)..(-Math::PI/4), (3*Math::PI/4)..Math::PI]
  TOP_RIGHT_CORNER_ANGLES = [(-3*Math::PI/4)..(Math::PI/4)]
  BOTTOM_LEFT_CORNER_ANGLES = [(-Math::PI)..(-3*Math::PI/4), (Math::PI/4)..Math::PI]
  BOTTOM_RIGHT_CORNER_ANGLES = [(-Math::PI/4)..(3*Math::PI/4)]

  def opponent_on_the_left?
    return @opponent_on_the_left unless @opponent_on_the_left.nil?
    @opponent_on_the_left = world.get_opponent_player.net_left < rink_width/2
  end

  def opponent_net_center_x
    return @opponent_net_center_x if @opponent_net_center_x
    opponent = world.get_opponent_player
    @opponent_net_center_x = 0.5 * (opponent.net_left + opponent.net_right)
  end

  def opponent_net_center_y
    return @opponent_net_center_y if @opponent_net_center_y
    opponent = world.get_opponent_player
    @opponent_net_center_y = 0.5 * (opponent.net_top + opponent.net_bottom)
  end

  def rink_width
    @rink_width ||= game.rink_right-game.rink_left
  end

  def rink_height
    @rink_height ||= game.rink_bottom-game.rink_top
  end

  def left_section_xx
    @left_section_xx ||= game.rink_left..(game.rink_left + rink_width/2)
  end

  def right_section_xx
    @right_section_xx ||= (game.rink_left + rink_width/2)..game.rink_right
  end

  def far_section_xx
    @far_section_xx ||= opponent_on_the_left? ? left_section_xx : right_section_xx
  end

  def near_section_xx
    @near_section_xx ||= opponent_on_the_left? ? right_section_xx : left_section_xx
  end

  def top_section_yy
    @top_section_yy ||= game.rink_top..(game.rink_top + rink_height/2)
  end

  def bottom_section_yy
    @bottom_section_yy ||= (game.rink_top + rink_height/2)..game.rink_bottom
  end

  alias_method :top_far_section_xx, :far_section_xx
  alias_method :top_far_section_yy, :top_section_yy
  alias_method :bottom_far_section_xx, :far_section_xx
  alias_method :bottom_far_section_yy, :bottom_section_yy
  alias_method :top_near_section_xx, :near_section_xx
  alias_method :top_near_section_yy, :top_section_yy
  alias_method :bottom_near_section_xx, :near_section_xx
  alias_method :bottom_near_section_yy, :bottom_section_yy

  def me_in_top_far_section?
    top_far_section_xx.include?(me.x) && top_far_section_yy.include?(me.y)
  end

  def me_in_top_near_section?
    top_near_section_xx.include?(me.x) && top_near_section_yy.include?(me.y)
  end

  def me_in_bottom_far_section?
    bottom_far_section_xx.include?(me.x) && bottom_far_section_yy.include?(me.y)
  end

  def me_in_bottom_near_section?
    bottom_near_section_xx.include?(me.x) && bottom_near_section_yy.include?(me.y)
  end

  def back_angles
    @back_angles ||= opponent_on_the_left? ? LEFT_ANGLES : RIGHT_ANGLES
  end

  def include_angle?(angles, value)
    angles.count{ |a| a.include?(value) } != 0
  end

  def me_look_up?
    TOP_ANGLES.include?(me.angle)
  end

  def me_look_down?
    BOTTOM_ANGLES.include?(me.angle)
  end

  def me_look_back?
    include_angle?(back_angles, me.angle)
  end

  def top_far_corner_angles
    @top_far_corner_angles ||= opponent_on_the_left? ? TOP_LEFT_CORNER_ANGLES : TOP_RIGHT_CORNER_ANGLES
  end

  def top_near_corner_angles
    @top_near_corner_angles ||= opponent_on_the_left? ? TOP_RIGHT_CORNER_ANGLES : TOP_LEFT_CORNER_ANGLES
  end

  def bottom_far_corner_angles
    @bottom_far_corner_angles ||= opponent_on_the_left? ? BOTTOM_LEFT_CORNER_ANGLES : BOTTOM_RIGHT_CORNER_ANGLES
  end

  def bottom_near_corner_angles
    @bottom_near_corner_angles ||= opponent_on_the_left? ? BOTTOM_RIGHT_CORNER_ANGLES : BOTTOM_LEFT_CORNER_ANGLES
  end

  def me_look_at_top_far_corner?
    include_angle?(top_far_corner_angles, me.angle)
  end

  def me_look_at_top_near_corner?
    include_angle?(top_near_corner_angles, me.angle)
  end

  def me_look_at_bottom_far_corner?
    include_angle?(bottom_far_corner_angles, me.angle)
  end

  def me_look_at_bottom_near_corner?
    include_angle?(bottom_near_corner_angles, me.angle)
  end

  def debug(message = nil)
    puts "#{message}"
    puts "   x:#{me.x}; y:#{me.y}; a:#{me.angle}"
    puts "   top_far_section?:#{me_in_top_far_section?}; top_near_section?:#{me_in_top_near_section?}; bottom_far_section?:#{me_in_bottom_far_section?}; bottom_near_section?:#{me_in_bottom_near_section?}"
    puts "   me_look_up?:#{me_look_up?}; me_look_down?:#{me_look_down?}; me_look_back?:#{me_look_back?}"
    puts "   me_look_at_top_far_corner?:#{me_look_at_top_far_corner?}; me_look_at_top_near_corner?:#{me_look_at_top_near_corner?}"
    puts "   me_look_at_bottom_far_corner?:#{me_look_at_bottom_far_corner?}; me_look_at_bottom_near_corner?:#{me_look_at_bottom_near_corner?}"
  end

end
