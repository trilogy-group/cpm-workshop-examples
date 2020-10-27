package com.devfactory.mastermind;

public class MastermindHelper {

    // (R)ed, (G)reen, (B)lue, (Y)ellow
    public static String [] VALID_COLORS = { "R", "G", "B", "Y" };

    public static String generateCode() {
        // TODO randomly generate a code        
        final String solution = 
               VALID_COLORS[0] + VALID_COLORS[1]
             + VALID_COLORS[2] + VALID_COLORS[3];

        System.out.println("");
        System.out.println(
            "USING DEFAULT IMPLEMENTATION MastermindHelper.generateCode() => "
             + solution);

             return solution;
    }

    public static void evaluateGuess(final GuessInfo guessInfo) {
        System.out.println("USING DEFAULT IMPLEMENTATION MastermindHelper.evaluateGuess()");
        System.out.println("Only checking for complete match, i.e. winning answer.");

        // TODO set the hits and psuedo hits properties accordingly
        for (int i = 0; i < guessInfo.getGuess().length(); i++) {
            if (guessInfo.getGuess().charAt(i) == guessInfo.getSolution().charAt(i)) {
                guessInfo.setHits(guessInfo.getHits() + 1);
            }
        }
    }
}