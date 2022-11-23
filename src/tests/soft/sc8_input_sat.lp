%*
teacher/1(teacher name)
-----------------------
*%
teacher(profAAA).
teacher(profBBB).

%*
course/3(course id, group_id, teacher name, number of weekly courses)
------------------------------------------------------------
*%
course(mac4722, 1, profAAA, 1). % High demand post grad course
course(macNotScience1, 1, profAAA, 1).
course(macNotScience2, 1, profBBB, 1).
course(mac5711, 1, profBBB, 1). % High demand post grad course

%*
available/2(teacher name, period)
---------------------------------
*%
available(profAAA, 111).
available(profAAA, 211).
available(profBBB, 111).
available(profBBB, 211).

%*
highDemand/1(course)
---------------------------------
*%
highDemand(mac4722). % Linguagens, Autômatos e Computabilidade
highDemand(mac5711). % Análise de Algoritmos
highDemand(mac5716). % Laboratório de Programação Extrema
highDemand(mac5717). % Laboratório Avançado de Métodos Ágeis de Desenvolvimento de Software
highDemand(mac5739). % Inteligência Artificial
highDemand(mac5742). % Introdução à Computação Paralela e Distribuída
highDemand(mac5760). % Introdução aos Sistemas de Bancos de Dados
highDemand(mac5832). % Aprendizagem de Máquina: Modelos, Algoritmos e Aplicações 