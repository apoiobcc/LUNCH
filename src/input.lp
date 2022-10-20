%*
	Input from 1st semester of 2022
	Note: the avaliability from all teachers is artificial,
	only considering periods that effective teached each course.
*%

%%% Teachers %%%

teacher(yoshiharu).
teacher(leliane).
teacher(flavio).
teacher(posdoc). % ?- who is posdoc
teacher(denis).
teacher(coelho).
teacher(nina).
teacher(renata).
teacher(marcilio).
teacher(hirata).
teacher(sinai).
teacher(guilherme).
teacher(carlinhos).
teacher(kelly).
teacher(rafael_will).
teacher(paulo_miranda).
teacher(finger).
teacher(alair).
teacher(leonidas).
teacher(marcondes).
teacher(ernesto).
teacher(fabio).
teacher(junior).
teacher(jef).
teacher(alan).
teacher(walter).
teacher(nina).
teacher(alfredo).
teacher(yoshiko).
teacher(cris).
teacher(routo).
teacher(marcelinho).
teacher(daniel).
teacher(hitoshi).
teacher(marcel_k).
teacher(ronaldo).

%%% Courses %%%

% Introduction courses

course(ccm0128,1,yoshiharu).
num_classes(ccm0128,2).

course(mac0101,45,leliane).
course(mac0101,45,flavio).
num_classes(mac0101,1).
:- not class(mac0101,45,leliane,513).
:- not class(mac0101,45,flavio,513).

course(mac0105,45,posdoc).
num_classes(mac0105,2).

course(mac0110,41,denis).
num_classes(mac0110,2).

course(mac0110,42,coelho).

course(mac0110,45,nina).

course(mac0110,51,renata).

course(mac0110,54,marcilio). % ?- will not appear in the table (night time classes)

course(mac0113,1,flavio).
num_classes(mac0113,2).

course(mac0113,2,flavio).

course(mac0113,21,hirata). % ?- ?- will not appear in the table at all (night time classes)

course(mac0113,22,hirata). % ?- ?- will not appear in the table at all (night time classes)

course(mac0115,15,sinai).
num_classes(mac0115,2).

course(mac2166,1,guilherme). % ?- maybe group (1,POLI) is not equal group 1 and so on to all next groups
num_classes(mac2166,2).
:- not class(mac2166,1,guilherme,212).
:- not class(mac2166,1,guilherme,413).

course(mac2166,2,carlinhos).
:- not class(mac2166,2,carlinhos,211).
:- not class(mac2166,2,carlinhos,411).

course(mac2166,3,yoshiharu).
:- not class(mac2166,3,yoshiharu,212).
:- not class(mac2166,3,yoshiharu,412).

course(mac2166,4,kelly).
:- not class(mac2166,4,kelly,113).
:- not class(mac2166,4,kelly,313).

course(mac2166,5,kelly).
:- not class(mac2166,5,kelly,121).
:- not class(mac2166,5,kelly,321).

course(mac2166,6,rafael_will).
:- not class(mac2166,6,rafael_will,312).
:- not class(mac2166,6,rafael_will,511).

course(mac2166,7,paulo_miranda).
:- not class(mac2166,7,paulo_miranda,411).
:- not class(mac2166,7,paulo_miranda,514).

course(mac2166,8,paulo_miranda).
:- not class(mac2166,8,paulo_miranda,412).
:- not class(mac2166,8,paulo_miranda,513).

course(mac2166,9,finger).
:- not class(mac2166,9,finger,211).
:- not class(mac2166,9,finger,511).

course(mac2166,10,finger).
:- not class(mac2166,10,finger,212).
:- not class(mac2166,10,finger,512).

course(mac2166,11,alair).
:- not class(mac2166,11,alair,321).
:- not class(mac2166,11,alair,512).

course(mac2166,12,alair).
:- not class(mac2166,12,alair,313).
:- not class(mac2166,12,alair,511).

% missing leonidas mac2166 13,POLI dates.

% Graduation and mandatory courses

course(mac0102,45,leliane).
course(mac0102,45,flavio).
num_classes(mac0102,1).

course(mac0209,1,marcondes).
num_classes(mac0209,2).

course(mac0210,45,ernesto).
num_classes(mac0210,2).

course(mac0321,1,fabio).
num_classes(mac0321,2).
:- not class(mac0321,1,fabio,411).
:- not class(mac0321,1,fabio,412).

course(mac0321,2,fabio).
:- not class(mac0321,2,fabio,511).
:- not class(mac0321,2,fabio,512).

course(mac0323,45,carlinhos).
num_classes(mac0323,2).

course(mac0329,45,junior).
num_classes(mac0329,2).

course(mac0350,45,jef).
num_classes(mac0350,2).

course(mac0422,0,alan). % ?- graduation and postgrad course 
% course(mac5753,0,alan).
num_classes(mac0422,2). 
% num_classes(mac5753,2).
% postgrad(mac5753).

course(mac0427,44,walter).
num_classes(mac0427,2).

course(mac0427,54,walter).

course(mac0499,45,nina).
num_classes(mac0499,1).

% Not mandatory graduation courses

course(mac0213,0,leliane).
course(mac0213,0,flavio).
num_classes(mac0213,1).

course(mac0214,0,leliane).
course(mac0214,0,flavio).
num_classes(mac0214,1).

course(mac0215,0,leliane).
course(mac0215,0,flavio).
num_classes(mac0215,1).

course(mac0218,0,alfredo).
num_classes(mac0218,2).

course(mac0219,0,alfredo). % ?- graduation and postgrad course 
num_classes(mac0219,2).
% course(mac5747,0,alfredo).
% num_classes(mac5747,2).
% postgrad(mac5747).

course(mac0320,0,yoshiko).
num_classes(mac0320,2).

course(mac0327,0,coelho).
num_classes(mac0327,2).

course(mac0331,0,cris). % ?- graduation and postgrad course 
num_classes(mac0331,2).
% course(mac5747,0,cris).
% num_classes(mac5747,2).
% postgrad(mac5747).

course(mac0336,0,routo). % ?- graduation and postgrad course
num_classes(mac0336,2).
% course(mac5723,0,routo).
% num_classes(mac5723,2).
% postgrad(mac5723).

course(mac0337,0,marcelinho). % ?- graduation and postgrad course
num_classes(mac0337,2).
% course(mac5900,0,marcelinho).
% num_classes(mac5900,2).
% postgrad(mac5900).

course(mac0352,0,daniel).
num_classes(mac0352,2).

course(mac0417,0,marcondes). % ?- graduation and postgrad course
num_classes(mac0417,2).
% course(mac5768,0,marcondes).
% num_classes(mac5768,2).
% postgrad(mac5768).

course(mac0420,0,hitoshi). % ?- graduation and postgrad course
num_classes(mac0420,2).
% course(mac5744,0,hitoshi).
% num_classes(mac5744,2).
% postgrad(mac5744).

course(mac0425,0,leliane).  % ?- graduation and postgrad course
num_classes(mac0425,2).
% course(mac5739,0,leliane).
% num_classes(mac5739,2).
% postgrad(mac5739).

course(mac0439,0,kelly).
num_classes(mac0439,2).

course(mac0460,0,nina). % ?- graduation and postgrad course
num_classes(mac0460,2).
% course(mac5832,0,nina).
% num_classes(mac5832,2).
% postgrad(mac5832).

course(mac0536,0,sinai). % ?- graduation and postgrad course
num_classes(mac0536,2).
% course(mac6928,0,sinai).
% num_classes(mac6928,2).
% postgrad(mac6928).

%%% Avaliability %%%

% Introduction courses avaliability

available(yoshiharu,221).
available(yoshiharu,322).

available(leliane,513).
available(flavio,513).

available(posdoc,321).
available(posdoc,511).

available(denis,211).
available(denis,412).

available(coelho,212).
available(coelho,513). % ?- should be 13:20 (if considered 521 turns to be UNSAT due to hc5)

available(nina,111).
available(nina,312).

available(renata,211).
available(renata,412).

available(marcilio,324). % ?- should be 21:10
available(marcilio,523). % ?- should be 19:20 (if considered 522 turns to be UNSAT due to hc5)

available(flavio,311). % ?- should be 7:30
available(flavio,512). % ?- should be 9:20

available(flavio,511). % ?- should be 9:20
available(flavio,312). % ?- should be 7:30

available(hirata,223). % ?- should be 19:30
available(hirata,424). % ?- should be 21:20

available(hirata,224). % ?- should be 21:20
available(hirata,423). % ?- should be 19:30

available(sinai,222).
available(sinai,421).

available(guilherme,212). % ?- should be 9:20
available(guilherme,413). % ?- should be 13:10

available(carlinhos,211). % ?- should be 7:30
available(carlinhos,411). % ?- should be 7:30

available(yoshiharu,212). % ?- should be 9:20
available(yoshiharu,412). % ?- should be 9:20

available(kelly,113). % ?- should be 13:10
available(kelly,313). % ?- should be 13:10

available(kelly,121). % ?- should be 15:00
available(kelly,321). % ?- should be 15:00

available(rafael_will,312). % ?- should be 9:20
available(rafael_will,511). % ?- should be 7:30

available(paulo_miranda,411). % ?- should be 7:30
available(paulo_miranda,514). % ?- should be 15:00 (if considered 521 turns to be UNSAT due to hc5)

available(paulo_miranda,412). % ?- should be 9:20
available(paulo_miranda,513). % ?- should be 13:10 (if considered 521 turns to be UNSAT due to hc5)

available(finger,211). % ?- should be 7:30
available(finger,511). % ?- should be 7:30

available(finger,212). % ?- should be 9:20
available(finger,512). % ?- should be 9:20

available(alair,321). % ?- should be 15:00
available(alair,512). % ?- should be 9:20

available(alair,313). % ?- should be 13:10
available(alair,511). % ?- should be 7:30

% Graduation and mandatory avaliability

available(leliane,413). % ?- should be 13:00
available(flavio,413). % ?- should be 13:00

available(marcondes,121).
available(marcondes,122).

available(ernesto,211).
available(ernesto,411).

available(fabio,411). % ?- should be 8:20
available(fabio,412). % ?- should be 10:20

available(fabio,511). % ?- should be 8:20
available(fabio,512). % ?- should be 10:20

available(carlinhos,212).
available(carlinhos,412).

available(junior,211).
available(junior,412).

available(jef,212).
available(jef,511).

available(alan,112).
available(alan,321).

available(walter,122).
available(walter,421).

available(walter,123). % ?- should be 19:20
available(walter,424). % ?- should be 21:20

available(nina,611). % ?- saturday 7:00

% Not mandatory graduation avaliability

available(leliane,611). % ?- saturday 8:00
available(flavio,611). % ?- saturday 8:00

available(leliane,621). % ?- saturday 14:00
available(flavio,621). % ?- saturday 14:00

available(leliane,612). % ?- saturday 10:00
available(flavio,612). % ?- saturday 10:00

available(alfredo,121).
available(alfredo,322).

available(alfredo,122).
available(alfredo,422).

available(yoshiko,121).
available(yoshiko,422).

available(coelho,321).
available(coelho,512).

available(cris,121).
available(cris,322).

available(routo,222).
available(routo,421).

available(marcelinho,212).
available(marcelinho,411).

available(daniel,211).
available(daniel,412).

available(marcondes,221).
available(marcondes,412).

available(hitoshi,312).
available(hitoshi,511).

available(leliane,222).
available(leliane,421).

available(kelly,212).
available(kelly,512).

available(nina,121).
available(nina,322).

available(sinai,321).
available(sinai,513). % ?- should be 14:00 but conflicts with hc5