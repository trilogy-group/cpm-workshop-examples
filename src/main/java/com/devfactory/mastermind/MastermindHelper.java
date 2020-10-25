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
        if (guessInfo.getGuess().equalsIgnoreCase(guessInfo.getSolution())) {
            guessInfo.setHits(4);
        }
    }
}