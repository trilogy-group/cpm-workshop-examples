require_relative '../helpers/application_helper'
require 'set'

class QuizController < ApplicationController

  include ApplicationHelper

  @@taker_set = Set.new

  def index
    if session[:attempt].nil?
        puts "There is no session attempt, calling start"
        #start
    else
        puts "Index found a session attempt"
        @attempt = Attempt.new(session[:attempt])
    end
  end

  def games
    if session[:quiz].nil?
        render :template => "quiz/menu"
    end
    if params["commit"]
        t = Time.now.utc
        str_time = t.strftime("%Y-%m-%dT%H:%M:%S.%N")
        session[:button_press] = str_time
        session[:playedthegame] = "true"
        session_attempt = Attempt.new(session[:attempt])
        message_text = "{\"quiz_id\"=>\"0\", \"question\"=>-1, \"taker\"=>\"#{session_attempt.taker}\", \"submittedat\"=>\"#{str_time}\"}"
        publish_message(message_text)

    end
    puts "QuizController games: #{params}"
    @number_of_players = @@taker_set.size
  end

  def menu
  end

  def clear
    @@taker_set = Set.new
  end

  def start
    @attempt = Attempt.new(attempt_params)
    @quiz = Quiz.find(1)
    session[:quiz] = @quiz
    @questions = Question.where(quiz_id: @quiz.id).to_a
    session[:questions] = @questions
    session[:question_number] = 0
    session[:answers] = []
    puts "Got the quiz #{@quiz.name}"
    count = 1
    @questions.each do |q|
      puts "[#{count}]  #{q.question}"
      count = count + 1
    end

    @attempt.quiz_id = @quiz.id
    @attempt.number_correct = 0
    @attempt.number_incorrect = 0
    puts "The quiz taker is #{@attempt.taker}"
    session[:attempt] = @attempt
    if @attempt.taker.nil?
        session[:message] = "You must provide a name."
        session[:quiz] = nil
    elsif @attempt.taker.length == 0
        session[:message] = "You must provide a name."
        session[:quiz] = nil
    elsif @@taker_set.include? @attempt.taker
        session[:message] = "Unforunately, the name #{@attempt.taker} is already taken. Please choose a different name."
        session[:quiz] = nil
    else
        @@taker_set.add @attempt.taker
        t = Time.now.utc
        str_time = t.strftime("%Y%m%d%H%M%S.%N")
        message_text = "{\"quiz_id\"=>\"#{@quiz.id}\", \"question\"=>0, \"taker\"=>\"#{@attempt.taker}\", \"answer\"=>\"none\", \"submittedat\"=>\"#{str_time}\", \"history\"=>\"\"}"
        publish_message(message_text)
    end
    @number_of_players = @@taker_set.size
    render :template => "quiz/index"
  end

  def attempt_params
    params.require(:attempt).permit(:taker, :quiz_id, :answer)
  end

  def restart
    puts "In controller restart"
    session[:quiz] = nil
    session[:attempt] = nil
    session[:tookthequiz] = nil
    session[:playedthegame] = nil
    render :template => "quiz/menu"
  end

  def answer
    puts "In controller answer"
    @quiz = session[:quiz]
    @attempt = Attempt.new(attempt_params)
    session[:answers] << @attempt.answer
    session_attempt = Attempt.new(session[:attempt])
    @attempt.number_correct = session_attempt.number_correct
    @attempt.number_incorrect = session_attempt.number_incorrect
    current_question_number = session[:question_number]
    questions = session[:questions]
    current_question = questions[current_question_number]

    t = Time.now.utc
    str_time = t.strftime("%Y%m%d%H%M%S.%N")
    message_text = "{\"quiz_id\"=>\"#{current_question['quiz_id']}\", \"question\"=>#{current_question_number + 1}, \"taker\"=>\"#{@attempt.taker}\", \"answer\"=>\"#{@attempt.answer}\", \"submittedat\"=>\"#{str_time}\", \"history\"=>\"#{session[:answers].join(',')}\"}"
    publish_message(message_text)

    your_answer_text = ""
    if @attempt.answer == "A"
        your_answer_text = current_question['option_a']
    elsif @attempt.answer == "B"
        your_answer_text = current_question['option_b']
    elsif @attempt.answer == "C"
        your_answer_text = current_question['option_c']
    elsif @attempt.answer == "D"
        your_answer_text = current_question['option_d']
    end
    session[:message] = "On question #{current_question_number + 1}, you answerered #{@attempt.answer}. #{your_answer_text}"
    #puts "Processing answer for question #{current_question_number}"
    #puts "questions class is #{questions.class.name}"
    #puts "current question is #{current_question.class.name}"
    #puts current_question.inspect
    if @attempt.answer == current_question["correct_answer"]
        puts "Got that one right with the answer of #{@attempt.answer}"
        @attempt.number_correct = @attempt.number_correct + 1
    else
        puts "Sorry, #{@attempt.answer} was the wrong answer. It was #{current_question["correct_answer"]}"
        @attempt.number_incorrect = @attempt.number_incorrect + 1
    end
    session[:attempt] = @attempt

    session[:question_number] = current_question_number + 1
    #puts "--- Attempt (session) ---"
    #puts session[:attempt].inspect
    #puts "--- Answers (session) ---"
    #puts session[:answers].inspect
    #puts "--- Question number (session) ---"
    #puts session[:question_number]
    @number_of_players = @@taker_set.size
    render :template => "quiz/index"
  end
end
