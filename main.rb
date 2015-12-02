require 'green_shoes'
require 'yaml'
Shoes.app :title => 'parent', :width => 800, :height => 600 do
  
  background aliceblue
  para "What would you like to do", align: "center"
  button("Create a new quiz"){@w = create_new_quiz}  
  button("Load Quiz"){@w = load_quiz}
  button("Change settings"){@w = settings} 
  button("Exit"){@w = exit} 
  def load_quiz
    window :title => 'Load A Quiz', :width => 800, :height => 600 do
      background aliceblue
    
      para 'What is your quiz name?'
      file_name = edit_line
      button('ok'){
        if File.exists?("./#{file_name.text}.yml")
          alert = "Cool"
          play_quiz
        else
          alert "There's no quiz with that name!"
          @w = owner
        end
        }      
      
    end
  end
  
  def play_quiz
    window :title => 'Play Quiz', :width => 800, :height => 600 do
      background aliceblue
      
      alert "#{file_name.text} quiz can be played now!"
      @w = owner
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
          @w = owner
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
    
def my_yml_loader(file_name)
  YAML::load("./#{file_name.text}.yml")
end


end
