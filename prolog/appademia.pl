:-include('GuiaAjuda.pl').
:-include('GuiaDieta.pl').
:-include('Treino.pl').
:-style_check(-singleton).
/*
 * Guarda os dados de um usuario que acabara de se cadastrar no Appademia. Sao salvas
 * informacoes: Id (o que identifica um usuario no aplicativo), Nome, Idade, Peso, Altura, Plano (mensal - trimestral - anual),
 * e uma resposta se o usuario ja esteve em uma academia antes ou nao.

 */
usersData([]).
:-dynamic usersData/1.

today(Today) :-
   get_time(Stamp),
   stamp_date_time(Stamp, DateTime, local),
   date_time_value(date, DateTime, Today).

%Le string
readString(S) :-
read_line_to_codes(user_input, I), atom_string(I, S).

%Le numero   
readNumber(N) :-
read_line_to_codes(user_input, I), number_codes(N, I). 

%Constroi um usuario
buildUser(Id, Nome, Idade, Peso, Altura, Plano, Resposta, DataEntrada, Treino, User):-
   User = user(Id, Nome, Idade, Peso, Altura, Plano, Resposta, DataEntrada, Treino).

%Insere um usuario no sistema
save(User):-
   retract(usersData(List)),
   insertTail(List, User, NewList),
   assert(usersData(NewList)).

insertTail([], Y, [Y]).         
insertTail([I|R], Y, [I|R1]) :-
   insertTail(R, Y, R1).

%Pega o id do usuario
getId(user(Option, Nome, Idade, Peso, Altura, Plano, Resposta, DataEntrada, Treino), Option).

%Exibe um usuario recebendo seu ID na entrada.
showUser([], Option) :-
   write(' ') ,nl.
showUser([H|_], Option):- 
   getId(H, Option),
   toStringUser(H).
showUser([_|T], Option):- 
   showUser(T, Option).
%---------------------------------------------------------------- Opcoes do menu ----------------------------------------------------------------

/*Cadastra um usuario no sistema. Para o cadastro, eh necessario o Id, Nome, Idade, Peso, Altura, Plano escolhido e uma Resposta (sim/nao) se o 
*usuario ja esteve numa academia.
*/
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
   write('Primeira vez em uma academia?[1 - sim / 2 - nao]:'), nl, %alteracao para numero temporariamente
   readNumber(Resposta), %alteracao para numero temporariamente
   today(DataEntrada),
   predefinedTrainingOption(Resposta,Treino),
   buildUser(Id, Nome, Idade, Peso, Altura, Plano, Resposta, DataEntrada, Treino, User),
   save(User),
   nl,nl,
   write('Cadastro com sucesso!'),
   nl,nl,
   write('Pressione Enter para voltar ao menu principal'),
   nl,nl,
   readString(_),
   shell(clear),
   begin(Data).

%Atualiza o treino de um usuario - ainda nao feito
updateTraining(Data):-
   write('Qual o seu id?: '), nl,
   readNumber(Id), nl,
   write('Qual treino você gostaria de cadastrar? [iniciante/medio/avancado]'), nl,
   readString(String).

%Atualiza o peso de um usuario, dado o seu id como entrada.
updateWeight(Data):-
   write('Qual o seu id?: '), nl,
   readNumber(Id),nl,
   write('Peso atual: '), nl.
   
%Exibe os dados de um usuario dado o seu ID como entrada.
showInfoUser(Data):-
   write('Qual o seu id?: '), nl,
   readNumber(Id),
   usersData(List),
   showUser(List, Id),
   nl,nl,
   write('Pressione Enter para voltar ao menu principal'),
   nl,nl,
   readString(_),
   shell(clear),
   begin(Data).

%Da dicas de dieta de acordo com a escolha do usuario (bulking, cutting ou perda de peso).
dietInput(Data):-
   writeln( 'Qual o seu objetivo? Bulking (1) -- Cutting (2) -- Perda de peso (3)?'),
   readNumber(Option),
   dietOption(Option),
   readString(_),
   shell(clear),
   begin(Data).

%Menu de opcoes de dieta.
dietOption(Option):-
   Option =:= 1 -> toStringBulking();
   Option =:= 2 -> toStringCutting();
   Option =:= 3 -> toStringWeightLoss().

%Menu de opcoes de treinos para cadastros recentes
predefinedTrainingOption(Resposta, Treino):-
   Resposta =:= 1 -> toStringTreinoIni(Treino);
   Resposta =:= 2 -> toStringTreinoMed(Treino).

%Abre uma guia de ajudas com diversas funcoes que podem vir a ser uteis para quaisquer usuario, seja ele experiente ou nao.
help(Data) :-
   writeln('--- Como o Appademia pode te ajudar? ---'),
   writeln('1 - Termos do mundo da musculacao.'),
   writeln('2 - Planos de pagamento.'),
   writeln('3 - Dicas para novatos.'),
   writeln('4 - Cancelamento de matricula.'),
   writeln('5 - Tabela IMC.'),
   writeln('Opcao escolhida -> '),
   readNumber(Option),
   helpOption(Option),
   readString(_),
   shell(clear),
   begin(Data).

%Menu de opcoes de dieta.
helpOption(Option):-
   Option =:= 1 -> toStringTermos();
   Option =:= 2 -> toStringPlanos();
   Option =:= 3 -> toStringDicas();
   Option =:= 4 -> toStringCancel();
   Option =:= 5 -> toStringIMC().

%Opcoes do menu principal, com as guias de cadastro, atualizacao de treino e peso, exibicao de usuario, recomendacao de dietas e ajuda.
options(Opcao, Data) :-
   Opcao =:= 1 -> signUpUser(Data); %done
   Opcao =:= 2 -> updateTraining(Data);
   Opcao =:= 3 -> updateWeight(Data);
   Opcao =:= 4 -> showInfoUser(Data); %done
   Opcao =:= 5 -> dietInput(Data); %done
   Opcao =:= 6 -> help(Data); %done
   Opcao =:= 7 -> halt(0). %done
  
begin(Data) :-
   menu(),
   write('   Opcao escolhida -> '), nl,
   readNumber(Opcao),
   options(Opcao, Data).

%---------------------------------------------------------------- TEXTUAIS ----------------------------------------------------------------

%toString do usuario. Porem, nao funcionando
toStringUser(user(Id, Nome, Idade, Peso, Altura, Plano, Resposta, DataEntrada, Treino)):-
   nl,nl,
   write('-------------------------------- DADOS DO USUARIO --------------------------------'),
   nl,nl,
   write('Id: '), write(Id),nl,
   write('Nome: '), write(Nome),nl,
   write('Idade: '), write(Idade),nl,
   write('Peso: '), write(Peso),nl,
   write('Altura: '), write(Altura),nl,
   write('Plano: '), write(Plano),nl,
   write('Iniciante: '), write(Resposta),nl,
   write('Membro desde: '), write(DataEntrada),nl,
   write('Treino: '),nl,nl, write(Treino),nl.

%---------------------------------------------------------------- MENU TEXTUAL ----------------------------------------------------------------
menu :-
   nl,
   write('-------------------------------- Bem vindo ao Appademia! --------------------------------'),
   nl,
   write('Escolha uma opcao:'),
   nl, 
   write('1. Novo usuario;'),
   nl,
   write('2. Atualizar treino;'),
   nl,
   write('3. Atualizar peso;'),
   nl,
   write('4. Exibir usuario;'),
   nl,
   write('5. Recomendacao de Dietas;'),
   nl,
   write('6. Ajuda;'),
   nl,
   write('7. Sair'), 
   nl.

:- initialization(main).
main :-
   begin(Data).     