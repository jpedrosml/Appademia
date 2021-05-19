usersData([]).

readString(S) :-
read_line_to_codes(user_input, I), atom_string(I, S).

readNumber(N) :-
read_line_to_codes(user_input, I), number_codes(N, I). 

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
   nl,nl,
   write('Cadastro com sucesso!'),
   nl,nl,
   begin(Output).

showUser(Data):-
   write('Qual o seu id?: '), nl,
   readNumber(Id),
   begin(Data).

dietInput(Data):-
   writeln( 'Qual o seu objetivo? Bulking (1) -- Cutting (2) -- Perda de peso (3)?'),
   readNumber(Option),
   dietOption(Option),
   begin(Data).

dietOption(Option):-
   Option =:= 1 -> toStringBulking();
   Option =:= 2 -> toStringCutting();
   Option =:= 3 -> toStringWeightLoss().

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
   
   begin(Data).

helpOption(Option):-
   Option =:= 1 -> toStringTermos();
   Option =:= 2 -> toStringPlanos();
   Option =:= 3 -> toStringDicas();
   Option =:= 4 -> toStringCancel();
   Option =:= 5 -> toStringIMC().

printAll(Data):-
   writeln(Data),
   begin(Data).


options(Opcao, Data) :-
   Opcao =:= 1 -> signUpUser(Data); %done
   Opcao =:= 2 -> updateTraining(Data);
   Opcao =:= 3 -> updateWeight(Data);
   Opcao =:= 4 -> showUser(Data);
   Opcao =:= 5 -> dietInput(Data); %done
   Opcao =:= 6 -> help(Data); %done
   Opcao =:= 7 -> halt(0); %done
   Opcao =:= 8 -> printAll(Data). %teste

begin(Data) :-
   menu(),
   write('   Opcao escolhida -> '), nl,
   readNumber(Opcao),
   options(Opcao, Data).


%TEXTUAIS

%toString de ajuda, opcao de termos
toStringTermos:-
   nl,
   writeln('                        -------------------------------- TERMOS DO MUNDO DA MUSCULACAO xD --------------------------------    '),
   nl,nl,
   write('ABS: Abreviacao para os musculos do abdomen. Sempre que escutar ou ler alguem dizendo que ira treinar o abs, eh do abdomen que ela esta falando!'),
   write('Exemplos de treinos de abdomen: Plank(max), Lateral Plank (max), Leg Raises(3x10)'),
   nl,nl,
   write('Acido Latico: Resultado natural do metabolismo. Quando um individuo sente o musculo queimando durante um exercicio, eh o resultado do acumulo de acido latico devido a falta de oxigenio no sangue.'),
   nl,nl,
   write('Aerobico: Exercicios feitos com o objetivo de aumentar a frequencia cardiaca. Durante um exercicio aerobico, a respiracao eh mais acelerada, fazendo com que a quantidade de oxigenio seja maximizada.'),
   write('Exemplos: Jogging, Jumping rope, Swimming'),
   nl,nl,
   write('Anabolismo: Parte do metabolismo que se refere a sintese de substancias. Por exemplo, a partir de aminoacidos (blocos que formam proteinas que ingeirmos) ha a sintese de proteina no musculo'),
   nl,nl,
   write('Catabolismo: Quebra de substancias complexas no organismo. Um exemplo eh quando alguem esta sem energia, a unica fonte rapida sera a destruicao de tecido muscular para transformar em glicose e usar como reserva. Isso ocorre quando nao se ha uma dieta adequada.'),
   nl,nl,
   write('Bulking: Periodo onde o individuo foca na alimentacao para o ganho de massa muscular. Consiste numa dieta com mais calorias do que o corpo pode gostar.'),
   nl,nl,
   write('Cutting: Fase de definicao do corpo, onde ha uma dieta restritiva para forcar o corpo a usar gordura como fonte de energia.'),
   nl,nl,
   write('Bodybuilding: Equivale a fisiculturismo, em portugues. Desta forma, um bodybuilder eh um fisiculturista.Alguns icones do fisiculturismo: Frank Zane, Dorian Yates, Arnold Schwarzenegger'),
   nl,nl.

%toString de ajuda, opcao de planos
toStringPlanos:-
   nl,
   write('                        -------------------------------- PLANOS E PREÇOS :O --------------------------------'),
   nl,nl,
   write('Plano Anual:         12 x R$76,90'),
   nl,nl,
   write('Plano Semestral:      6 x R$82,90'),
   nl,nl,
   write('Plano Trimestral:     3 x R$87,90'),
   nl,nl,
   write('Plano Mensal:             R$98,00'),
   nl,nl.

%toString de ajuda, opcao de dicas
toStringDicas:-
   nl,
   write('                        -------------------------------- DICAS IMPORTANTES :) --------------------------------'),
   nl,nl,
   write('Dica 1: Antes de todo e qualquer exercicio eh primordial o aquecimento para evitar lesoes. Alem deste cuidado, o aquecimento ajuda no metabolismo e diminui a rigidez muscular.'),
   nl,nl,
   write('Dica 2: Durante o treino, mantenha-se hidratado. Leve sempre consigo uma garrafa de agua, pois alem de hidratar, a agua ajuda a desintoxicar o organism oe facilitar o transporte de nutrientes!'),
   nl,nl,
   write('Dica 3: Tenha paciencia. Se voce eh novato, nunca se esforce mais do que pode. Nao aumente as cargas sem um preparo devido e nao pule a ordem dos exercicios.'),
   nl,nl,
   write('Dica 4: Evite comecar exercicios sem uma alimentacao previa. Lembre-se tambem de alimentar-se com proteinas e carboidratos pos treino. Mas cuidado! Nao faca nenhuma alimentacao extravagante e va diretamente ao treino, o resultado nao sera nada bom!'),
   nl,nl,
   write('Dica 5: E a dica mais importante... descanse! O descanso faz parte da construcao dos musculos em seu corpo. Alem disso, separe um dia da semana para a sua folga, pois eh importante evitar a fadiga!'),
   nl,nl.

%toString de ajuda, opcao de cancelamento
toStringCancel:-
   nl,
   write('                        -------------------------------- CANCELAMENTO DE MATRICULA :( --------------------------------'),
   nl,nl,
   write('Para realizar o cancelamento da matricula entre em contato com (XX)XXXXX-XXXX.'),
   nl,nl,
   write('Ou compareça à administração da academia.'),
   nl,nl.

%toString de ajuda, opcao de IMC
toStringIMC:-
   nl,
   write('                        -------------------------------- IMC --------------------------------'),
   nl,nl,
   write('IMC eh a sigla para indice de massa corporal, um calculo que indica se a pessoa esta dentro do peso em relacao a sua altura. O calculo eh feito da seguinte forma: '),
   nl,nl,
   write('Peso / (Altura x Altura)'),
   nl,nl,
   write('A tabela a seguir indica os possiveis resultados do calculo:'),
   nl,nl,
   write('    IMC              Classificacao'),
   nl,nl,
   write('< 18.5         PESO ABAIXO DA NORMALIDADE'),
   nl,nl,
   write('18.5 - 24.9    PESO NORMAL'),
   nl,nl,
   write('25.0 - 29.9    SOBREPESO'),
   nl,nl,
   write('30.0 - 34.9    OBESIDADE (GRAU 1)'),
   nl,nl,
   write('35.0 - 39.9    OBESIDADE SEVERA (GRAU 2)'),
   nl,nl,
   write('>= 40.0        OBESIDADE MORBIDA (GRAU 3)'),
   nl,nl.

%toString do usuario. Porem, nao funcionando
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

%toString dieta bulking
toStringBulking:-
   nl,nl,
   write('            ---TREINO PARA BULKING:---  '),
   nl,nl,
   write('      --- Cafe da manha ---  '),  
   nl,nl,
   write('- Aveia (3 colheres de sopa);'), 
   nl,nl,
   write('- Ovo inteiro (2 unidades);'), 
   nl,nl,
   write('- Ameixas (10g)'),
   nl,nl,
   write('      --- Lanche ---   '), 
   nl,nl,
   write('- Batata doce (100g);'),
   nl,nl,
   write('- Peito de frango (90g);'),
   nl,nl,
   write('- Pao integral (2 fatias);'), 
   nl,nl,
   write('      --- Lanche (2) ---'),  
   nl,nl,
   write('- Banana (1 unidade);'),  
   nl,nl,
   write('- Pasta de amendoim;'),  
   nl,nl,
   write('- Queijo (2 fatias)'),  
   nl,nl,
   write('      --- Almoco ---'),  
   nl,nl,  
   write('- Beterrabas (2 unidades de 70g);'),  
   nl,nl,
   write('- Suco de uva (100ml);'),  
   nl,nl,
   write('- Macarrao integral (40g);'),  
   nl,nl,
   write('- Clara de ovo (4 unidades);'),  
   nl,nl,
   write('- Creatina (5g opcional)'), 
   nl,nl,
   write('      --- Lanche pos treino ---'),  
   nl,nl,
   write('- Whey (25g);'),  
   nl,nl,
   write('- Glutamina (5g)'),  
   nl,nl,
   write('      --- Jantar ---'),  
   nl,nl,
   write('- Arroz integral (4 colheres de sopa);'),  
   nl,nl,
   write('- Peixe (120g)'),  
   nl,nl,
   write('      --- Lanche pos jantar ---'),  
   nl,nl,
   write('- Batata doce (60g);'),  
   nl,nl,
   write('- Brocolis, alface;'),  
   nl,nl,
   write('- Omega 3 (600mg)'),  
   nl,nl,
   write('      ---- AS REFEICOES SAO FEITAS A CADA 3H ---- '),
   nl,nl.

%toString dieta cutting
toStringCutting:-  
   nl,nl,
   write('            ---TREINO PARA CUTTING:---  '),
   nl,nl,
   write('      --- Cafe da manha --- ') ,
   nl,nl,
   write('- Tapica com ovos (2 unidades);'),
   nl,nl,
   write('- Mamao (1 fatia grande);'),
   nl,nl,
   write('- Omega 3 (1000mg)'),
   nl,nl,
   write('      --- Almoco --- '),
   nl,nl,
   write('- Abobora, chuchu, couve flor, brocolis, alface (100g)'),
   nl,nl,
   write('- Peito de frango (120g)'),
   nl,nl,
   write('- Azeite de oliva (1 colher de sopa)'),
   nl,nl,
   write('      --- Lanche  --- '),
   nl,nl,
   write('- Aveia (3 colheres de sopa);'),
   nl,nl,
   write('- Iogurte natural desnatado (200ml);'),
   nl,nl,
   write('- Laranja (1 unidade);'),
   nl,nl,
   write('      --- Jantar --- '),
   nl,nl,
   write('- Abobrinha, espinafre, cenoura (3 porcoes de hortalicas);'),
   nl,nl,
   write('- Arroz integral (2 colheres de sopa);'),
   nl,nl,
   write('- Ovos (3 unidades)'),
   nl,nl.

%toString dieta perda de peso
toStringWeightLoss:-
   nl,nl,
   write('            ---TREINO PARA PERDA DE PESO:---'), 
   nl,nl,
   write('      --- Cafe da manha ---'),  
   nl,nl,
   write('- Leite desnatado (240ml);'),
   nl,nl,
   write('- Omelete (1 ovo);'),
   nl,nl,
   write('- Tomate (1 unidade)'),
   nl,nl,
   write('      --- Almoco ---'), 
   nl,nl,
   write('- File de peixe(150g);'),
   nl,nl,
   write('- Grao de bico (2 colheres de sopa);'),
   nl,nl,
   write('- Salada cozida;'),
   nl,nl,
   write('- Abacaxi (2 fatias)'),
   nl,nl,
   write('      --- Lanche  ---'), 
   nl,nl,
   write('- Iogurte desnatado (1 unidade);'),
   nl,nl,
   write('- Linhaca (2 colheres de sopa);'),
   nl,nl,
   write('      --- Jantar ---'), 
   nl,nl,
   write('- Peito de frango (150g);'),
   nl,nl,
   write('- Feijao (2 colheres de sopa);'),
   nl,nl,
   write('- Salada crua;'),
   nl,nl,
   write('- Laranja (1 unidade)'),
   nl,nl.

%MENU
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
   usersData(Data),
   begin(Data).     