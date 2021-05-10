usersData([]).

readString(S) :-
read_line_to_codes(user_input, I), atom_string(I, S).

readNumber(N) :-
   read_line_to_codes(user_input, I), number_codes(N, I)
. 

addUsersInfo(Info, Data, [Info|Data]):-!.

signUpUser(Data) :-
   write('Crie um ID numerico. Ele servira para quaisquer operacao no aplicativo: '), nl,
   readNumber(Id),
   write('Nome completo: '), nl,
   readString(Nome),
   write('Idade: '), nl,
   readNumber(Idade),
   write('Peso'), nl,
   readNumber(Peso),
   write('Altura'), nl,
   readNumber(Altura),
   write('Plano de Pagamento[mensal/trimestral/anual]: '), nl,
   readString(Plano),
   write('Primeira vez em uma academia?[sim/nao]:'), nl,
   readString(Resposta),
   addUsersInfo([Id, Nome, Idade, Peso, Altura, Plano, Resposta], Data, Output),
   write('Cadastro com sucesso!'),
   begin(Output).


help :-
   writeln('--- Como o Appademia pode te ajudar? ---'),
   writeln('1 - Termos do mundo da musculação.'),
   writeln('2 - Planos de pagamento.'),
   writeln('3 - Dicas para novatos.'),
   writeln('4 - Cancelamento de matricula.'),
   writeln('5 - Tabela IMC.'),
   writeln('Opcao escolhida -> ').


toStringUser(usuario(Nome, Idade, Peso, Altura, Plano, Resposta, Membership, Treino)):-
   nl,
   write('Nome: '),write(Nome),nl,
   write('Idade: '),write(Idade),nl,
   write('Peso: '),write(Peso),nl,
   write('Altura: '),write(Altura),nl,
   write('Plano: '),write(Plano),nl,
   write('Iniciante: '),write(Resposta),nl,
   write('Membro desde: '),write(Membership),nl,
   write('Treino: '),write(Treino),nl.

options(Opcao, Data) :-
   Opcao =:= 1 -> signUpUser(Data);
   Opcao =:= 2 -> updateTraining(Data);
   Opcao =:= 3 -> updateWeight(Data);
   Opcao =:= 4 -> showUser(Data);
   Opcao =:= 5 -> dietInput(Data);
   Opcao =:= 6 -> help;
   Opcao =:= 7 -> halt(0).

begin(Data) :-
   menu(),
   write('   Opcao escolhida -> '), nl,
   readNumber(Opcao),
   options(Opcao, Data).

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

:- initialization(main).
main :-
   usersData(Data),
   begin(Data).     