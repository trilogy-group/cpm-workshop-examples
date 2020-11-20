class QuizController < ApplicationController
  def index
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
    session[:attempt] = @attempt

    render :template => "quiz/index"
  end

  def attempt_params
    params.require(:attempt).permit(:taker, :quiz_id, :answer)
  end

  def restart
    puts "In controller restart"
    session[:quiz] = nil
    session[:attempt] = nil
    render :template => "quiz/index"
  end

  def answer
    puts "In controller answer"
    @attempt = Attempt.new(attempt_params)
    session[:answers] << @attempt.answer
    session_attempt = Attempt.new(session[:attempt])
    @attempt.number_correct = session_attempt.number_correct
    @attempt.number_incorrect = session_attempt.number_incorrect
    current_question_number = session[:question_number]
    questions = session[:questions]
    puts "Processing answer for question #{current_question_number}"
    puts "questions class is #{questions.class.name}"
    current_question = questions[current_question_number]
    puts "current question is #{current_question.class.name}"
    puts current_question.inspect
    if @attempt.answer == current_question["correct_answer"]
        puts "Got that one right with the answer of #{@attempt.answer}"
        @attempt.number_correct = @attempt.number_correct + 1
    else
        puts "Sorry, #{@attempt.answer} wsa the wrong answer. It was #{current_question["correct_answer"]}"
        @attempt.number_incorrect = @attempt.number_incorrect + 1
    end
    session[:attempt] = @attempt

    session[:question_number] = current_question_number + 1
    puts "--- Attempt (session) ---"
    puts session[:attempt].inspect
    puts "--- Answers (session) ---"
    puts session[:answers].inspect
    puts "--- Question number (session) ---"
    puts session[:question_number]
    puts "--------------------------"
    render :template => "quiz/index"
  end
end
