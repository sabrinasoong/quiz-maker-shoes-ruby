require 'green_shoes'
require 'yaml'
require './main'
require './load_quiz'
require './settings'
@blk = class Create < Shoes
  @@win = 0

  def index 
    case @@win
      when 0
      para link("Load A Quiz") { window "/load_quiz" }
      when 1
      para link("Settings") { window "/settings" }
     # when 2
    
    else
    end
  end

  def settings
    @@win = 1
    Shoes.app :title => 'Settings', :width => 800, :height => 600, &@blk
    visit "/"
  end

  def load_quiz
    @@win = 0
    Shoes.app :title => 'Load Quiz', :width => 800, :height => 600, &@blk
    visit "/"
  end
end

class CreateQuiz
  attr_accessor :file_name
  
  def initialize
    @quiz = []
    new_quiz_save
  end
  
  def new_quiz_save
    Shoes.app :title => 'Create A New Quiz', :width => 800, :height => 600, &@blk
    stack do
    para 'What is your quiz name?'
      file_name = (edit_line width: 400).text
      unless File.exists?("#{file_name}.yml")
      File.new("#{file_name}.yml", "w+")
      else 
        puts "You've already got a quiz with that name! Name it something else"
        new_quiz_save
      end
    end
    
  end
  
  #def 
  #end
  
end
