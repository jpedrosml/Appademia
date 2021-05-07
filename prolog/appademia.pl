usersData([]).

addUsersInfo(Info, Data, [Info|Data]).

input(X,Y):-
   write(X),
   write(' '),
   read(Y).


cadastrarUsuario(Data) :-
   input('Crie um ID numerico. Ele servira para quaisquer operacao no aplicativo: ', Id ),
   input('Nome completo: ', Nome),
   input('Idade: ', Idade),
   input('Peso', Peso),
   input('Altura', Altura),
   input('Plano de Pagamento[mensal/trimestral/anual]: ', Plano),
   input('Primeira vez em uma academia?[sim/nao]:', Resposta),
   addUsersInfo([Id, Nome, Idade, Peso, Altura, Plano, Resposta], Data, Output),
   begin(Output).


opcoes(Opcao, Data) :-
   Opcao =:= 1 -> cadastrarUsuario(Data);
   Opcao =:= 7 -> halt(0).

begin(Data) :-
   menu(),
   input('   Opcao escolhida -> ', Opcao),
   opcoes(Opcao, Data).

menu :-
   nl, writeln('-------------------------------- Bem vindo ao Appademia! --------------------------------
   Escolha uma opção: 
   1. Novo usuario;
   2. Atualizar treino;
   3. Atualizar peso;
   4. Exibir usuario;
   5. Recomendacao de Dietas;
   6. Ajuda 
   7. Sair'), nl.

main :-
   usersData(Data),
   begin(Data).     