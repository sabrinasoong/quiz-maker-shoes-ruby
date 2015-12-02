def load_quiz
    para 'What is your quiz name?'
    file_name = gets.chomp
    unless File.exists?("#{file_name}.yml")
      puts "You haven't got a quiz with this name! Would you like to create one?"
      answer = gets.chomp
    #  if answer
        
     # end
    else 
      
    end
    
  end