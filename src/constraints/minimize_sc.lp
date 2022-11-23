%*
Count each occurence of a "weak" predicate, grouped by weight
 Eg: weak(-4,1,Id1).
     weak(-4,1,Id2).
 ------------------------
     count(-4,1,2)
*%

count(W,P,S) :- S = #count{ C : weak(W,P,C)}, weak(W,P,_).

% Multiply each weight by its own quantity of occurences

w(Wnew,P) :- count(W,P,S), Wnew = W*S.

#minimize { W@P : w(W,P) }.

%*
run with flags --opt-mode=optN --quiet=1

To compute all optimal answer sets, we can change clasp’s optimization mode using
option ‘--opt-mode=optN’. In this mode, clasp first prints the tenta- tive answer
sets where optimality is not yet proven and afterwards prints the optimal answer sets.
Note that the first optimal answer set is printed twice in this mode.
To omit tentative answer sets in the output and only print optimal answer sets,
we can add option ‘--quiet=1’

Basically, if you run without the flag optN above clingo won't guarantee to return all
possible sat models, and if you don't use quiet=1, you may receive duplicate answers.
*%
