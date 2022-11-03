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