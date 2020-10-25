package com.devfactory.mastermind;

public class GuessInfo {
    private String solution;
    private String guess;
    private int hits = 0;
    private int psuedoHits = 0;

    public GuessInfo(final String solution, final String guess) {
        this.solution = solution;
        this.guess = guess;
    }

    public int getHits() {
        return hits;
    }
    
    public void setHits(final int value) {
        hits = value;
    }

    public int getPsuedoHits() {
        return psuedoHits;
    }

    public void setPsuedoHits(final int value) {
        psuedoHits = value;
    }

    public String getSolution() {
        return solution;
    }

    public String getGuess() {
        return guess;
    }

    public boolean isWinner() {
        return (hits == solution.length());
    }
}