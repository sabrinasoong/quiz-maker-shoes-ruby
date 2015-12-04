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
      button("Play Quiz", width: 1.0, height: 1.0){@w = question_loader}
    end
    
  #  stack :width => 250, :height => 120 do
    #  button("Play Loaded Quiz", width: 1.0, height: 1.0){@w = play_loaded_quiz}
   # end
    stack :width => 250, :height => 120 do
      button("Change settings", width: 1.0, height: 1.0){@w = settings} 
    end
    
    stack :width => 250, :height => 120 do
      button("Exit", width: 1.0, height: 1.0){@w = exit} 
    end
    
  end 
  
  def load_quiz    
    @quiz_file = Nokogiri::XML(File.open("sample.xml"))
    # write the xml string generated above to the file
    quiz = @quiz_file.xpath("//quiz").text
    @quiz_file.remove_namespaces!
   # puts ron
    window :title => 'Quiz Game', :width => 800, :height => 600 do
      background springgreen
      puts quiz
        para 'What is your quiz name?'
        file_name = edit_line
        button'ok' do
          unless File.exists?("./#{file_name.text}.xml")
            alert "There's no quiz with that name!"
            @w = owner
            #play_quiz
          else
            alert quiz
        end
        end
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
    window :title => 'Play Quiz', :width => 800, :height => 600 do
      background springgreen
      
      alert "#{file_name.text} quiz can be played now!"
      @w = owner
    end
  end

  def score
    if correct_answer == true
    @score += 1
    else 
      
    end
    
  end
  
  def init_game
    @score = 0
    @question = 1
    
    
    
  end
  def puts str
    @q.push proc{
     @slot.append{para str}
      @slot.scroll_top = @slot.scroll_max
    }
    end

  def question_loader
    window :title => 'Quiz Game', :width => 800, :height => 600 do
    background springgreen
    #blk = proc do |question|
      
      @quiz_file = Nokogiri::XML(File.open("sample.xml"))
      # write the xml string generated above to the file
      @i = rand(1..3)
      full_quiz = @quiz_file.xpath("//quiz").text
      question = @quiz_file.xpath("//question#{@i}/question").text
      wrong_answers = @quiz_file.xpath("//questions#{@i}/question/wrong_answer").text
      correct_answer = @quiz_file.xpath("//questions#{@i}/correct_answer").text
      @quiz_file.remove_namespaces!
      
      
     # stack do
     #   background aliceblue, height: 25
     #   caption "Quiz Game", align: "center"
      #end
  
      @slot = stack :height => "50%" do 
        para "Question"
        para question
                 
       # para quizzing
      end
    end
  end
    
    def helper_init
    @q = []

    e = animate do |i|
      if @q.empty?
        e.stop
      else
        case q = @q.shift
        when :nothing
        when :stop
          if @key
            @input.text = @key
            @answer, @key = @key, nil
          else
            @q.unshift :stop
          end
        when :prompt
          @slot.append{flow{para '> '; @input = para '', stroke: red}}
	  @slot.scroll_top = @slot.scroll_max
          @q.unshift :stop
        else
          q.is_a?(Array) ? q.first[@answer] : q.call
        end
      end
    end

    keypress{|k| @key = k}
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
