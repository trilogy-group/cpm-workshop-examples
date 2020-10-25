package com.devfactory.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

import com.devfactory.mastermind.GuessInfo;
import com.devfactory.mastermind.MastermindHelper;


@WebServlet(
    name = "MastermindServlet", 
    urlPatterns = {"/mastermind"}
)

public class MastermindServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String SOLUTION_KEY = "solution";
    private static final String GUESS_KEY = "guess";
    private static final String GUESS_COUNT_KEY = "guess_count";
    private static final String HITS_KEY = "hits";
    private static final String PSUEDO_HITS_KEY = "psuedo_hits";

    protected void doGet(final HttpServletRequest request, final HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(final HttpServletRequest request, final HttpServletResponse response)
            throws ServletException, IOException {

        String strGuessCount = (String) request.getParameter(GUESS_COUNT_KEY);
        if (strGuessCount == null) {
            strGuessCount = "0";
        }
        Integer guessCount = Integer.valueOf(strGuessCount);

        String solution = (String) request.getParameter(SOLUTION_KEY);
        if (solution == null) {
            solution = MastermindHelper.generateCode();
        }

        String guess;
        String slot1 = (String) request.getParameter("slot_one");
        String slot2 = (String) request.getParameter("slot_two");
        String slot3 = (String) request.getParameter("slot_three");
        String slot4 = (String) request.getParameter("slot_four");
        if (slot1 == null) {
            guess = "";
        } else {
            guess = slot1 + slot2 + slot3 + slot4;
        }

        final GuessInfo guessInfo = new GuessInfo(solution, guess);
        MastermindHelper.evaluateGuess(guessInfo);

        final RequestDispatcher requestDispatcher
            = request.getRequestDispatcher("mastermind.jsp");
        request.setAttribute(SOLUTION_KEY, solution);
        request.setAttribute(GUESS_COUNT_KEY, guessCount + 1);
        request.setAttribute(GUESS_KEY, guess);
        request.setAttribute(HITS_KEY, guessInfo.getHits());
        request.setAttribute(PSUEDO_HITS_KEY, guessInfo.getPsuedoHits());
        requestDispatcher.forward(request, response);
    }
}
