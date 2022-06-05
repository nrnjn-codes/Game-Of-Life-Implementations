$:.push(File.dirname(__FILE__))

require 'world'

class Play

  # @@ makes this a private class variable
  @@World_Width  = 150
  @@World_Height = 40

  def self.run
    world = World.new(
      width: @@World_Width,
      height: @@World_Height,
    )

    puts world.render

    total_tick = 0
    total_render = 0

    while true
      tick_start = Time.now
      world._tick
      tick_finish = Time.now
      tick_time = (tick_finish - tick_start)
      total_tick += tick_time
      avg_tick = (total_tick / world.tick)

      render_start = Time.now
      rendered = world.render
      render_finish = Time.now
      render_time = (render_finish - render_start)
      total_render += render_time
      avg_render = (total_render / world.tick)

      output = "##{world.tick}"
      output += " - World tick took #{_f(tick_time)} (#{_f(avg_tick)})"
      output += " - Rendering took #{_f(render_time)} (#{_f(avg_render)})"
      output += "\n#{rendered}"
      puts "\u001b[H\u001b[2J"
      puts output
    end
  end

  def self._f(value)
    # value is in seconds, convert to milliseconds
    "%.3f" % (value * 1000)
  end
  private_class_method :_f

end

Play.run
