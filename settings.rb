require 'green_shoes'
#setting the window size 
Shoes.app :title => "The Ultimate Quiz", :width => 1000, :height => 700 do
    
	previous_pos_x = nil
	previous_pos_y = nil
	
	stroke "#474BC4"
	animate 30 do
		button, x,y = self.mouse
		
		if button == 1
			line(previous_pos_x, previous_pos_y, x,y)
		end
		
		previous_pos_x = x
		previous_pos_y = y
	end
  
  def load_quiz
    window  :title => 'Load Quiz', :width => 800, :height => 600 do
      button('parent'){owner.hello green}
      button('child'){owner.hello green, self}
    end
  end
  
  def create_new_quiz
    window  :title => 'Create New Quiz', :width => 800, :height => 600 do
    
    end
  end
  
  def play_quiz
    window :title => 'Play Quiz', :width => 800, :height => 600 do
    end
  end
  
  def settings
    window :title => 'Settings', :width => 800, :height => 600 do
    end
  end
  
  def exit
    exit
  end

  def hello color, win = nil
    win ||= self
    @n ||= 0
    @n += 1
    win.para strong("#{win}--#{@n}\n"), :stroke => color
  end
    
  background purple
  para "What would you like to do", align: "center"
  button("Create a new quiz"){@w = create_new_quiz}  
  button("Play an existing quiz"){@w = play_quiz}  
  button("Change settings"){@w = settings}
  button("Load Quiz"){@w = load_quiz}
  button "Exit" 

  end

