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
  
  stack do
    para "What would you like to do", align: "center"
    background purple
    
    stack do
      button "Create a new quiz"
    end
  
    stack do
      button "Play an existing quiz"
    end
    
    stack do
      button "Change settings"
    end
  
    stack do
      button "Exit" 
    end
  end
		
end
