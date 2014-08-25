require 'rubygems'
require 'bundler/setup'
Bundler.require

class Window < Gosu::Window
  def initialize
    super 800, 600, false
    @ground          = Gosu::Image.new(self, 'ground_color.png')
    @pyramide        = Gosu::Image.new(self, 'pyramide_1.png')
    @pyramide_blurry = Gosu::Image.new(self, 'pyramide_3.png')
    @do_nothing_shader = Ashton::Shader.new(fragment: 'do_nothing.frag')
    @font = Gosu::Font.new(self, "Arial", 16)
  end
  
  def button_down id
    @use_shader = !@use_shader if id == Gosu::KbSpace
  end
  
  def draw
    @ground.draw 0 ,$window.height-@ground.height, 0
    
    if @use_shader
      post_process @do_nothing_shader do
        draw_pyramide
        draw_blurry_pyramide
      end      
    else
      draw_pyramide
      draw_blurry_pyramide
    end
    
    @font.draw "Press space to toggle shader (turned #{@use_shader ? 'on' : 'off'})", 0,0,0
  end
  
  def draw_pyramide
    
    # any scaling other than 1 or any non-whole position makes the edges dark
    # for both draw and draw_rot
    x = 10.1
    y = 200
    z = 0
    angle = 0
    center_x = 0.5
    center_y = 0.0
    factor_x = 1.5
    factor_y = 1.5
    @pyramide.draw_rot x, y, z, angle, center_x, center_y, factor_x, factor_y
    #@pyramide.draw x, y, z#, factor_x, factor_y
  end
  
  def draw_blurry_pyramide
    # you don't notice any dark edges with a blurry picture
    x = 500
    y = 350
    z = 0
    angle = 0
    center_x = 0.5
    center_y = 0.0
    factor_x = 1.5
    factor_y = 1.5
    #@pyramide_blurry.draw_rot x, y, z, angle, center_x, center_y, factor_x, factor_y
    @pyramide_blurry.draw x, y, z#, angle, center_x, center_y, factor_x, factor_y
  end
end

Window.new.show