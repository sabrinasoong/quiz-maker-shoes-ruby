require 'green_shoes'
require 'yaml'
require 'nokogiri'
Shoes.app :title => 'parent', :width => 800, :height => 600 do
  background springgreen

  flow :width => "33%" do
  end
  flow :width => "33%" do
    para "What would you like to do", align: "center"

    stack :width => "37%" do
      #empty
    end
    
    stack :width => 250, :height => 120 do
      border lightpink
      button("Create a new quiz", width: 1.0, height: 1.0){@w = create_new_quiz}      
    end
    
    stack :width => 250, :height => 120 do
      button("Play Quiz", width: 1.0, height: 1.0){@w = load_quiz}
    end
    
    stack :width => 250, :height => 120 do
      button("Play Loaded Quiz", width: 1.0, height: 1.0){@w = play_loaded_quiz}
    end
    stack :width => 250, :height => 120 do
      button("Change settings", width: 1.0, height: 1.0){@w = settings} 
    end
    
    stack :width => 250, :height => 120 do
      button("Exit", width: 1.0, height: 1.0){@w = exit} 
    end
    
  end 
  
  def load_quiz
    window :title => 'Load A Quiz', :width => 800, :height => 600 do
      background springgreen

      para 'What is your quiz name?'
      file_name = edit_line
      button('ok'){
        unless File.exists?("./#{file_name.text}.xml")
          alert "There's no quiz with that name!"
          @w = owner
          #play_quiz
        else
          alert = "Cool"
          @w.clear = play_loaded_quiz
          para ron
          
        end
        }      
      
    end
  end
  
  def play_quiz
    window :title => 'Play Quiz', :width => 800, :height => 600 do
      background springgreen
      
      alert "#{file_name.text} quiz can be played now!"
      @w = owner
    end
  end
  
  def create_new_quiz
    window :title => 'Create A New Quiz', :width => 800, :height => 600 do
      background springgreen

 #   stack do
      
      para 'What is your quiz name?'
      file_name = edit_line
      
     #para 'How many questions do you have in your quiz?'
     # number_of_questions = edit_line
     # edit_line.text.to_i.times do
        
      para 'Question'
      question = edit_box
      para 'Answers'
      
      flow do
        para 'Answer 1'
        answer_a = edit_line
      end
     flow do
        para 'Answer 2'
        answer_b = edit_line
      end
      flow do
        para 'Answer 3'
        answer_c = edit_line
      end
      flow do
        para 'Answer 4'
        answer_d = edit_line
      end
      flow do
        para 'Answer 5 (put your correct answer here)'
        answer_e = edit_line
      end
   
      button('ok'){
        unless File.exists?("./#{file_name.text}.xml")
          File.new("./#{file_name.text}.xml", "w+")
          #if answer_a.empty? == true || answer_b.empty? == true || answer_c.empty? == true || answer_d.empty == true || answer_e.empty? == true || question.empty?
            #alert 'You need to fill in a question, 4 wrong answers and 1 correct answer!!'
           # @w = owner
          #else 
            
            #
          quiz = File.open("./#{file_name.text}.xml")

            #quiz = Nokogiri::XML(File.open("#{file_name}.xml"))
           # builder = Nokogiri::XML::Builder.new do |xml|
            #  xml.send(:"quiz"){
           #   xml.question "#{question}"
            #  xml.wrong_answer "#{answer_a}"
           #   xml.wrong_answer "#{answer_b}"
            #  xml.wrong_answer "#{answer_c}"
           #   xml.wrong_answer "#{answer_d}"
           #   xml.correct_answer "#{answer_e}"
           #   }
           #   puts builder.to_xml
          #end
          alert "#{file_name.text} has been created!"
          @w = owner
        else
          alert "You've already got a quiz with that name!"
          @w = owner
        end
        }      
    #  end
    end
end

def delete_quiz
  background springgreen
  para'What is the name of your quiz?'
  delete_quiz = edit_line
  if File.exists?("./#{delete_quiz.text}.xml")
    
  else
    alert "There is no quiz named #{delete_quiz}. Please try again!"
  end
end
  
def settings
    window :title => 'Settings', :width => 800, :height => 600 do
      
    end
  end
  
  def exit
    Kernel.exit
  end
    
  #def my_yml_loader(file_name)
  #  YAML.load_file("./#{file_name.text}.yml")
 # end
  
  def play_loaded_quiz
    @lol = Nokogiri::XML(File.open("sample.xml"))
    # write the xml string generated above to the file
    ron = @lol.xpath("//quiz").text
    @lol.remove_namespaces!
   # puts ron
    window :title => 'Quiz Game', :width => 800, :height => 600 do
      background springgreen
      puts ron
        para 'What is your quiz name?'
        file_name = edit_line
        button'ok' do
          if ron == nil 
            alert "its nil"
          else 
            alert "#{ron} How devious"
          end
        end
    end
  end

  def score
    if correct_answer == true
    @score += 1
    else 
      
    end
    
  end
  
  

end

#possible solution to creating a new file
#  flow do
#      @open_button = button "Open"
#      @save_button = button "Save"
#    end
 #   @t = edit_box
 #   
 #   @open_button.click do 
 #     @t.text = File.read(ask_open_file)
 #   end
#    @save_button.click do
 #     File.new(ask_save_file, 'w') do |f|
 #       f.puts @t.text
 #     end
 #   end
