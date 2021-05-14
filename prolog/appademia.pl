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

%showUser(Data):-
 %  write('Qual o seu id?: '), nl,
  % readNumber(Id),
   %begin(Data)
   %.

dietInput(Data):-
   readNumber(Option),
   Option =:= 1 -> toStringBulking();
   Option =:= 2 -> toStringCutting();
   Option =:= 3 -> toStringWeightLoss();

   begin(Data).



help :-
   writeln('--- Como o Appademia pode te ajudar? ---'),
   writeln('1 - Termos do mundo da musculação.'),
   writeln('2 - Planos de pagamento.'),
   writeln('3 - Dicas para novatos.'),
   writeln('4 - Cancelamento de matricula.'),
   writeln('5 - Tabela IMC.'),
   writeln('Opcao escolhida -> ').

printAll(Data):-
   writeln(Data),
   begin(Data).

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


toStringBulking:-
    nl,
    writeln(
      '  ---TREINO PARA BULKING:---  
  
        --- Cafe da manha ---  
  
      - Aveia (3 colheres de sopa); 
  
      - Ovo inteiro (2 unidades); 
  
      - Ameixas (10g)
  
           --- Lanche --- 
  
      - Batata doce (100g); 
  
      - Peito de frango (90g); 
  
      - Pao integral (2 fatias) 

          --- Lanche (2) --- 
  
      - Banana (1 unidade); 
  
      - Pasta de amendoim; 
  
      - Queijo (2 fatias) 
  
          --- Almoco --- 
      
      - Beterrabas (2 unidades de 70g); 

      - Suco de uva (100ml); 

      - Macarrao integral (40g); 

      - Clara de ovo (4 unidades); 

      - Creatina (5g opcional) 
  
         --- Lanche pos treino --- 

      - Whey (25g); 
  
      - Glutamina (5g) 
  
           --- Jantar --- 
  
      - Arroz integral (4 colheres de sopa); 
  
      - Peixe (120g) 
  
       --- Lanche pos jantar --- 
  
      - Batata doce (60g); 
  
      - Brocolis, alface; 
  
      - Omega 3 (600mg) 
  
       ---- AS REFEICOES SAO FEITAS A CADA 3H ---- '),
       begin(Data).

toStringCutting:-  
  nl,
  writeln('  ---TREINO PARA CUTTING:---  

        --- Cafe da manha ---  

      - Tapica com ovos (2 unidades);

      - Mamao (1 fatia grande);

      - Omega 3 (1000mg)

          --- Almoco --- 

      - Abobora, chuchu, couve flor, brocolis, alface (100g)

      - Peito de frango (120g)

      - Azeite de oliva (1 colher de sopa)

          --- Lanche  --- 

      - Aveia (3 colheres de sopa);

      - Iogurte natural desnatado (200ml);

      -  Laranja (1 unidade);

          --- Jantar --- 

      - Abobrinha, espinafre, cenoura (3 porcoes de hortalicas);

      - Arroz integral (2 colheres de sopa);

      - Ovos (3 unidades) '),

      begin(Data).

toStringWeightLoss:-
   nl,
   writeln('   ---TREINO PARA PERDA DE PESO:---  

        --- Cafe da manha ---  
  
      - Leite desnatado (240ml);
  
      - Omelete (1 ovo);

      - Tomate (1 unidade)
  
          --- Almoco --- 
  
      - File de peixe(150g);
  
      - Grao de bico (2 colheres de sopa);
  
      - Salada cozida;
  
      - Abacaxi (2 fatias)
  
         --- Lanche  --- 
  
      - Iogurte desnatado (1 unidade);
  
      - Linhaca (2 colheres de sopa);
  
         --- Jantar --- 
  
      - Peito de frango (150g);
  
      - Feijao (2 colheres de sopa);
  
      - Salada crua;
  
      - Laranja (1 unidade)'),

       begin(Data).

options(Opcao, Data) :-
   Opcao =:= 1 -> signUpUser(Data); %done
   Opcao =:= 2 -> updateTraining(Data);
   Opcao =:= 3 -> updateWeight(Data);
   Opcao =:= 4 -> showUser(Data);
   Opcao =:= 5 -> dietInput(Data);
   Opcao =:= 6 -> help; %done
   Opcao =:= 7 -> halt(0);
   Opcao =:= 8 -> printAll(Data). %teste

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