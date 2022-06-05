require "./world"

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
      tick_start = Time.monotonic
      world._tick
      tick_finish = Time.monotonic
      tick_time = (tick_finish - tick_start).total_nanoseconds
      total_tick += tick_time
      avg_tick = (total_tick / world.tick)

      render_start = Time.monotonic
      rendered = world.render
      render_finish = Time.monotonic
      render_time = (render_finish - render_start).total_nanoseconds
      total_render += render_time
      avg_render = (total_render / world.tick)

      output = "##{world.tick}"
      output += " - World tick took #{_f(tick_time)} (#{_f(avg_tick)})"
      output += " - Rendering took #{_f(render_time)} (#{_f(avg_render)})";
      output += "\n#{rendered}"
      puts "\u001b[H\u001b[2J"
      puts output
    end
  end

  private def self._f(value)
    # value is in nanoseconds, convert to milliseconds
    "%.3f" % (value / 1000000)
  end

end

Play.run
