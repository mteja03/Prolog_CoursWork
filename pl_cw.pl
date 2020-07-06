% Arash's coursework template (Thanks Jamie Gabbay)
%

% Krishna Mattapalli, ktm7  <--- so we know who you are
% F28PL Coursework, Prolog    <--- sanity check


% Due: Friday 6th of Dec, 2019, at 3:30pm sharp.
% Submit (this file) via GitLab as usual.
% This coursework constitutes 6% of your final F28PL mark.

% You may assume variables, procedures, and functions defined in earlier questions
% in your answers to later questions, though you should add comments in code explaining
% this if any clarification might help read your code.


/* For All Questions, include testing in comments, so your marker can load this file as a
database then cut-and-paste any testing into the command line.

Testing on GitLab will NOT be provided for prolog. Your own test will in this case be
 marked - note this is unlike the python coursework.

*/

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 1   <--- Yes, so we know what question you think you're answering
%
% The complex numbers are explained here (and elsewhere):
%  http://www.mathsisfun.com/algebra/complex-number-multiply.html
% Represent a complex integer as a two-element list of integers, so [4,5] represents 4+5i.
% Write Prolog predicates
% representing complex integer addition and multiplication. Thus for instance,
%  cadd([X1,X2],[Y1,Y2],[Z1,Z2])
% succeeds if and only if Z1=X1+Y1 and Z2=X2+Y2.
% Note that complex number multiplication is not just like complex number addition.
% Check the link and read the definition.
%
%   <--- always have the question under your nose


% This cadd functions work on the addition of complex integers. After addition the values are stored in Z1 and Z2 I used "is" to store values.
    cadd([X1,X2],[Y1,Y2],[Z1,Z2]):-  Z1 is (X1+Y1), Z2 is (X2+Y2).
% Test
% cadd([1,2],[1,2],[2,4]).
% True
% cadd([1,2],[1,2],[Z1,Z2]).
% Z1=2, Z2=4.
% cadd([1,2],[1,2],[1,1]).
% False

% This cmult functions work on the multiplication of complex integers. Each part of the first complex number gets multiplied by each part of the second complex number and "i * i = -1". 
% After multiplication the values are stored in Z1 and Z2 I used "is" to store values.
    cmult([X1,X2],[Y1,Y2],[Z1,Z2]):- Z1 is ((X1*Y1)-(X2*Y2)), Z2 is ((X2*Y1)+(X1*Y2)).
% Test
% cmult([1,2],[1,2],[-3,4]).
% True
% cmult([1,2],[1,2],[Z1,Z2]).
% Z1 = -3,
% Z2 = 4.
% mult([1,2],[1,2],[-3,5]).
% False

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% END ANSWER TO Question 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 2
%
% An integer sequence is a list of integers. Write a Prolog predicate
% such that seqadd(X,Y,Z) succeeds when X and Y are lists of integers of the same length and
% Z is their sequence sum.


% seqadd function is a function where it does additions for two lists with the same length. so first I created a base case to say what will be output. 
% In the function I used X1|T1, Y1|T2 represents heads and tiles of a list. I did recursively, first, I add both values in head and then called recursively with tiles then it repeats the same process, added values are stored in "z", so the addition will continue until the end.
     seqadd([], [], []).
     seqadd([X1|T1],[Y1|T2],[Z|T3]):- seqadd(T1,T2,T3), Z is X1+Y1.

% Test
% seqadd([1,2,3,4],[4,3,2,1],[5,5,5,5]).
% True
% seqadd([1,2,3,4],[4,3,2,1],[5,5,5,5,5]).
% False
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% END ANSWER TO Question 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 4
%
% 4a. Explain what backtracking has to do with Prolog. You might find this webpage helpful:
% https://www.doc.gold.ac.uk/~mas02gw/prolog_tutorial/prologpages/search.html


% The mechanism for finding multiple solution is called backtracking
% When we reach a point where a goal cannot be matched, we backtrack to the most recent spot where a choice of matching a particular fact or rule was made.
 
% Example 
 % I created a database and asked if jack eats specific things. Now I want "what are all things that jack eats".
 % enter "eats(jack, FoodItem)." in the terminal, the answer will be "apple" this is because it has fount the first clause in the database. 
 % At this point prolog allows us to ask if there are other possible solutions. When we do so we get the following. "banana" if I ask for another solution prolog will give as "pears". 
 % If you ask for further solutions prolog will answer no since there are only three ways to prove jack eats something finding multiple solutions is called backtracking. 
        
    eats(jack, apple).
    eats(jack, banana).
    eats(jack, pears).

% ?- eats(jack, FoodItem). This should be in the terminal.


% 4b. What is Cut in prolog and what does it have to do with backtracking? Explain your answer by giving examples of Cut
% used in at least one prolog rule, and explain how it affects the execution/resolution process.
%

% The cut, in Prolog, is a goal, written as !, which always succeeds, but cannot be backtracked. 
% It is best used to prevent unwanted backtracking, including the finding of extra solutions by Prolog and to avoid unnecessary computations.

% Example
 % i criated a database the following facts:
    teaches(dr_fred, history).
    teaches(dr_fred, english).
    teaches(dr_fred, drama).
    teaches(dr_fiona, physics). 
    studies(alice, english).
    studies(angus, english).
    studies(amelia, drama).
    studies(alex, physics).

 % enter this in terminal querie 
   % ?- teaches(dr_fred, Course), studies(Student, Course).
 % outputs:
   % Course = english
   % Student = alice ;

   % Course = english
   % Student = angus ;

   % Course = drama
   % Student = amelia ;

   % false.

% Backtracking is not inhibited here. The course is initially bound to history, but there are no students of history, so the second goals fail, backtracking occurs, 
% Course is re-bound to english, the second goal is tried and two solutions found (alice and angus), then backtracking occurs again, and Course is bound to drama, 
% and a final Student, amelia, is found.

% enter this in terminal querie
  % ?- teaches(dr_fred, Course), !, studies(Student, Course).
% outputs: false.

% This time Course is initially bound to history, the cut goal is executed, and then studies goal is failing because nobody studies history. 
% Because of the cut, we cannot backtrack to the teaches goal to find another binding for Course, so the whole query fails.

% enter this in terminal querie 
    % ?- teaches(dr_fred, Course), studies(Student, Course), !.
% outputs:
    % Course = english
    % Student = alice ;

    % false.

% Here the teaches goal is tried as usual, and Course is bound to history, again as usual. Next, the studies goal is tried and fails, 
% so we don't get to the cut at the end of the query at this point, and backtracking can occur. Thus the teaches goal is re-tried, and Course is bound to English. 
% Then the studies goal is tried again, and succeeds, with Student = alice. After that, the cut goal is tried and of course, succeeds, so no further backtracking is possible and only one solution is thus found.

% enter this in terminal querie
    % ?- !, teaches(dr_fred, Course), studies(Student, Course).
% outputs:
    % Course = english
    % Student = alice ;

    % Course = english
    % Student = angus ;

    % Course = drama
    % Student = amelia ;

    % false.
% In this final example, the same solutions are found as if no cut was present, because it is never necessary to backtrack past the cut to find the next solution, so backtracking is never inhibited.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% END ANSWER TO Question 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 5
%
% Write a database for a predicate cycleoflife/1 such that the query
%  cycleoflife(X)
% returns the instantiations
%  X = eat
%  X = sleep
%  X = code
%  X = eat
%  X = sleep
%  X = code
%  ...
% in an endless cycle.
% (This question has a beautiful and simple answer. If you find yourself writing lines and lines of
% complex code, there’s probably something amiss.)



% This cycleoflife  returns continuously eat, sleep, code because the variable x is taking values and returning the value it is using backtracking to find multiple solution. 
    cycleoflife(eat).
    cycleoflife(sleep).
    cycleoflife(code).
    cycleoflife(X):- cycleoflife(X).
   
% test:
% cycleoflife(X)
% output:
% X = eat ;
% X = sleep ;
% X = code ;
% X = eat ;
% X = sleep ;
% X = code ;
% X = eat ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% END ANSWER TO Question 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
