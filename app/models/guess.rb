class Guess < ApplicationRecord

    attr_accessor :feedback

    def display
        puts Guess.inspect
        puts "Full guess: #{user_guess}"
    end

    def user_guess
        "#{self.slotone}#{self.slottwo}#{self.slotthree}#{self.slotfour}"
    end

    def check_guess
        hits = 0
        ug = user_guess

        # TODO this currently only looks for hits, not psuedo-hits
        (0..3).each do |i|
            if self.solution[i] == ug[i]
                hits = hits + 1
            end
        end
        hits
    end
end
