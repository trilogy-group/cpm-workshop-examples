require_relative '../helpers/application_helper'
require 'set'

class QuizController < ApplicationController

  include ApplicationHelper

  @@taker_set = Set.new

  def load_data
    @quiz = Quiz.find(1)
    @questions = Question.where(quiz_id: @quiz.id).to_a
  end

  def index
    if session[:attempt].nil?
        puts "There is no session attempt, calling start"
        #start
    else
        puts "Index found a session attempt"
        @attempt = Attempt.new(session[:attempt])
    end
    load_data
  end

  def games
    if session[:start].nil?
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
    load_data
    session[:question_number] = 0
    session[:answers] = []
    puts "Got the quiz #{@quiz.name}"
    count = 1

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
        session[:start] = "true"
    end
    @number_of_players = @@taker_set.size
    render :template => "quiz/index"
  end

  def attempt_params
    params.require(:attempt).permit(:taker, :quiz_id, :answer)
  end

  def restart
    puts "In controller restart"
    load_data
    session[:start] = nil
    session[:quiz] = nil
    session[:attempt] = nil
    session[:tookthequiz] = nil
    session[:playedthegame] = nil
    render :template => "quiz/menu"
  end

  def answer
    puts "In controller answer"
    load_data
    @attempt = Attempt.new(attempt_params)
    session[:answers] << @attempt.answer
    session_attempt = Attempt.new(session[:attempt])
    @attempt.number_correct = session_attempt.number_correct
    @attempt.number_incorrect = session_attempt.number_incorrect
    current_question_number = session[:question_number]
    current_question = @questions[current_question_number]

    t = Time.now.utc
    str_time = t.strftime("%Y%m%d%H%M%S.%N")
    message_text = "{\"quiz_id\"=>\"#{current_question['quiz_id']}\", \"question\"=>#{current_question_number + 1}, \"taker\"=>\"#{@attempt.taker}\", \"answer\"=>\"#{@attempt.answer}\", \"submittedat\"=>\"#{str_time}\", \"history\"=>\"#{session[:answers].join(',')}\"}"
    publish_message(message_text)
    session[:message] = "On question #{current_question_number + 1}, you answerered #{@attempt.answer}."

    if @attempt.answer == current_question["correct_answer"]
        puts "Got that one right with the answer of #{@attempt.answer}"
        @attempt.number_correct = @attempt.number_correct + 1
    else
        puts "Sorry, #{@attempt.answer} was the wrong answer. It was #{current_question["correct_answer"]}"
        @attempt.number_incorrect = @attempt.number_incorrect + 1
    end
    session[:attempt] = @attempt

    session[:question_number] = current_question_number + 1
    @number_of_players = @@taker_set.size
    render :template => "quiz/index"
  end
end
