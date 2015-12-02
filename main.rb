require 'green_shoes'
Shoes.app :title => 'parent', :width => 800, :height => 600 do
  
  background aliceblue
  para "What would you like to do", align: "center"
  button("Create a new quiz"){@w = create_new_quiz}  
  button("Play an existing quiz"){@w = play_quiz}  
  button("Change settings"){@w = settings}
  button("Load Quiz"){@w = load_quiz}
  button("Exit"){@w = exit} 
  def load_quiz
    window  :title => 'Load Quiz', :width => 800, :height => 600 do
      button('parent'){owner.hello green}
      button('child'){owner.hello green, self}
    end
  end
  
  def play_quiz
    window :title => 'Play Quiz', :width => 800, :height => 600 do
      background aliceblue
      para link("Load A Quiz") { window "/load_quiz" }
      file = YAML::load_file("./{file_name.text}")
    end
  end
  
  def create_new_quiz
    window :title => 'Create A New Quiz', :width => 800, :height => 600 do
      background aliceblue
    stack do
      para 'What is your quiz name?'
      file_name = edit_line
      
      button('ok'){
        unless File.exists?("./#{file_name.text}.yml")
          File.new("./#{file_name.text}.yml", "w+")
          alert "#{file_name.text} has been created!"
          @w = play_quiz
        else
          alert "You've already got a quiz with that name!"
          @w = owner
        end
        }      
      end
    end
end

def delete_quiz
  
  
end
  
def settings
    window :title => 'Settings', :width => 800, :height => 600 do
      
    end
  end
  
  def exit
    Kernel.exit
  end
    
  

end