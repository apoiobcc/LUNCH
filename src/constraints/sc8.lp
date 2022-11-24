%*
Soft #8
-------------------------------------
High demand post grad courses should not conflict
*%

%*
High demand post grad courses(course id):
*%
high_demand(mac4722). % Linguagens, Autômatos e Computabilidade
high_demand(mac5711). % Análise de Algoritmos
high_demand(mac5716). % Laboratório de Programação Extrema
high_demand(mac5717). % Laboratório Avançado de Métodos Ágeis de Desenvolvimento de Software
high_demand(mac5739). % Inteligência Artificial
high_demand(mac5742). % Introdução à Computação Paralela e Distribuída
high_demand(mac5760). % Introdução aos Sistemas de Bancos de Dados
high_demand(mac5832). % Aprendizagem de Máquina: Modelos, Algoritmos e Aplicações 

weak(25, 1, Id) :- class(C1, _, _, P), class(C2, _, _, P),
              high_demand(C1), high_demand(C2),
              Id = @concat("sc8", C1, C2).
