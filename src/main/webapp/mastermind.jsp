<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Mastermind Game</title>
<link rel="stylesheet" href="https://unpkg.com/mvp.css">
</head>
<body>
<div align="center" style="margin-top: 10px;">
<span style="color: #00264d; font-size: 150%;">Mastermind Game</span><br/>
<%
  String solution = (String) request.getAttribute("solution");
  String guess = (String) request.getAttribute("guess");
  Integer guessCount = (Integer) request.getAttribute("guess_count");
  Integer hits = (Integer) request.getAttribute("hits");
  Integer psuedoHits = (Integer) request.getAttribute("psuedo_hits");

  if (hits == 4) {
%>
Congratulations! You guessed it!<br/>
The solution was ${solution}<br/>
<a href="/mastermind">Start a new game.</a>
<%
  } else {
      if (guess.length() > 0) {
%>
Here is the feedback on your guess: ${guess}<br/>
Hits: ${hits}<br/>
Psuedo Hits: ${ psuedo_hits }<br/><br/>
<%
      }
%>
Make your guess:
<form action="/mastermind" method="post">
  <table><tr><td>
    <label for="slot_one">Slot 1:</label>
  </td><td>
    <select name="slot_one" id="slot_one">
      <option value="R">Red</option>
      <option value="G">Green</option>
      <option value="B">Blue</option>
      <option value="Y">Yellow</option>
    </select>
  </td></tr><tr><td>
    <label for="slot_two">Slot 2:</label>
  </td><td>
    <select name="slot_two" id="slot_two">
      <option value="R">Red</option>
      <option value="G">Green</option>
      <option value="B">Blue</option>
      <option value="Y">Yellow</option>
    </select>
  </td></tr><tr><td>
    <label for="slot_three">Slot 3:</label>
   </td><td>
   <select name="slot_three" id="slot_three">
      <option value="R">Red</option>
      <option value="G">Green</option>
      <option value="B">Blue</option>
      <option value="Y">Yellow</option>
    </select>
  </td><td><tr><td>
    <label for="slot_four">Slot 4:</label>
  </td><td>
    <select name="slot_four" id="slot_four">
      <option value="R">Red</option>
      <option value="G">Green</option>
      <option value="B">Blue</option>
      <option value="Y">Yellow</option>
    </select>
  </td></tr></table>
    <input type="hidden" name="solution" value="<%= solution %>" />
    <input type="hidden" name="guess_count" value="<%= guessCount %>" />
    <input type="submit" value="submit" />
</form>
<%
  }
%>
</div>

</body>
</html>
