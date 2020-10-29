class GuessesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @guess = Guess.new
    @guess.guess_count = 1
    # TODO We hardcode the answer for now
    @guess.solution = "RGBY"
  end

  def guess
    @guess = Guess.new(guess_params)
    @guess.display
    hits = @guess.check_guess
    puts "Controller hits: #{hits}"
    @guess.feedback = "The number of hits was #{hits}"

    if hits == 4
        redirect_to "/guesses/winner"
    end
  end

  def guess_params
    params.require(:guess).permit(:slotone, :slottwo, :slotthree, :slotfour, :guess_count, :solution)
  end
end
