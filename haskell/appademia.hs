import Treino
import Dicas
import Planos
import Dieta
import Termos
import Imc
import Cancelamento
import Data.Time.Clock ( getCurrentTime )
import Data.Time.Calendar
import Data.Functor
import Data.List
import Data.Char
import Text.Printf
import System.IO (hSetBuffering, stdin, BufferMode(NoBuffering))
import qualified System.Process as SP

{-# LANGUAGE BlockArguments #-}

--Usuario da academia, que possui um id numerico escolhido pelo mesmo, nome, idade, peso, altura, plano de pagamento escolhido, data de entrada e treino--
data Usuario = Usuario {id:: Int,   
                        nome::String, 
                        idade:: Int ,
                        peso:: Float,
                        altura:: Float,
                        plano:: String,
                        resposta:: String,
                        dataEntrada :: String,
                        treino :: String
                        } deriving Eq

-- seleciona o id do usuario, que exerce funcoes como atualizacao de peso e exibicao--
userId :: Usuario -> Int
userId (Usuario id _ _ _ _ _ _ _ _) = id

-- seleciona o peso antigo do usuario para comparar com o atual --
pesoAntigo :: [Usuario] -> Int -> Float
pesoAntigo usuarios id
    |userId (head usuarios) == id = peso(usuarios !! 0)
    |otherwise = peso (usuarios !! 1)

-- cadastra um usuario no appademia-
cadastrarUsuario :: [Usuario] -> Usuario -> [Usuario]
cadastrarUsuario usuarios usuario
    |usuarioCheck usuarios (userId usuario) = usuarios
    |otherwise = usuarios ++ [usuario]

-- exibe os dados de um usuario --
exibirUsuario :: [Usuario] -> Int -> String
exibirUsuario []_ = "Nao cadastrado\n"
exibirUsuario usuarios id
    | userId (head usuarios) == id = toString(head usuarios)  
    | otherwise = exibirUsuario(tail usuarios) id

-- checa se existe um usuario --
usuarioCheck :: [Usuario] -> Int -> Bool
usuarioCheck[]_ = False
usuarioCheck  usuarios id
    |userId(head usuarios) == id = True 
    |otherwise = usuarioCheck(tail usuarios) id

-- atualiza o peso do usuario --
atualizarPesoUsuario :: [Usuario] -> Int -> Float -> [Usuario]
atualizarPesoUsuario [usuario] id peso
    | userId usuario == id = [mudaPeso usuario peso]
    | otherwise = [usuario]

-- muda o treino do usuario --
atualizarTreinoUsuario :: [Usuario] -> Int -> String -> [Usuario]
atualizarTreinoUsuario [usuario] id treino
    | userId usuario == id = [mudaTreino usuario treino]
    | otherwise = [usuario]

-- verifica se ja existe um usuari ocadastrado --
existeUsuario :: Bool -> String 
existeUsuario existe
    | existe  = "\nUsuario ja cadastrado.\n"
    | otherwise = "\nCadastro com sucesso!\n"

-- toString de exibicao dos dados do usuario --
toString(Usuario id nome idade peso altura plano resposta dataEntrada treino) = "--- Dados Usuario --- " ++ 
                                                            "\nNome: " ++ show nome ++ 
                                                            "\nIdade: " ++ show idade ++ 
                                                            "\nPeso: " ++ show peso ++ 
                                                            "\nAltura: " ++ show altura ++ 
                                                            "\nPlano: " ++ show plano ++
                                                            "\nIniciante: " ++ resposta ++ 
                                                            "\nMembro desde: " ++ dataEntrada ++ 
                                                            "\nTreino: " ++ treino
                                                            
-- mudanca de peso --
mudaPeso (Usuario id nome idade peso altura plano resposta dataEntrada treino) novoPeso = Usuario id nome idade novoPeso altura plano resposta dataEntrada treino

-- mudanca de treino --
mudaTreino (Usuario id nome idade peso altura plano resposta dataEntrada treino) novoTreino = Usuario id nome idade peso altura plano resposta dataEntrada novoTreino


-- operacoes do programa: cadastro --
opcao '1' usuarios = do
    limparTela
    dataEntrada <- fmap show getCurrentTime 
    putStrLn "Crie um ID numerico. Ele servira para quaisquer operacao no aplicativo: "
    id <- getLine
    putStrLn "\nNome completo: "
    nome <- getLine
    putStrLn "\nIdade: "
    idade <- readLn
    putStrLn "\nPeso: "
    peso <- readLn
    putStrLn "\nAltura: "
    altura <- readLn
    putStrLn "\nPlano de Pagamento[mensal/trimestral/anual]: "
    plano <- getLine
    putStrLn "\nPrimeira vez em uma academia?[sim/nao]: "
    resposta <- getLine
    limparTela
    putStr (existeUsuario(usuarioCheck usuarios(read id :: Int)))
    if resposta ==  "sim"
        then menu (cadastrarUsuario usuarios ( Usuario (read id :: Int)  nome idade peso altura plano resposta dataEntrada Treino.treinoIni))
    else if resposta == "nao"
        then menu (cadastrarUsuario usuarios ( Usuario (read id :: Int)  nome idade peso altura plano resposta dataEntrada Treino.treinoMed))
    else putStrLn "opcao invalida"
    getLine
    limparTela
    main

-- operacoes do programa: cadastro de treinos --    
opcao '2' usuarios = do
    putStrLn "\nQual o seu id?: "
    id <-getLine 
    putStrLn "\nQual treino você gostaria de cadastrar? [iniciante/medio/avancado]"
    treino <- getLine
    putStrLn ""
    limparTela
    if treino == "iniciante"
        then menu (atualizarTreinoUsuario usuarios (read id :: Int ) Treino.treinoIni)
    else if treino == "medio"
        then menu (atualizarTreinoUsuario usuarios (read id :: Int ) Treino.treinoMed)
    else if treino == "avancado"
        then menu (atualizarTreinoUsuario usuarios (read id :: Int ) Treino.treinoAva)
    else putStrLn "opcao invalida"
    main

-- operacoes do programa: atualizacao de peso --
opcao '3' usuarios = do
    putStrLn "\nQual o seu id?: "
    id <- getLine 
    putStrLn "\nPeso atual: "
    pesoAtual <- readLn
    let pesoAnt = pesoAntigo usuarios (read id :: Int)
    let pesoEmagreceu = pesoAnt - pesoAtual --189 - 45 - 
    let pesoEngordou = pesoAtual - pesoAnt

    if usuarioCheck usuarios (read id :: Int)
        then printf "\nPeso atualizado com sucesso! Seu peso atual eh: %f kg\n"  pesoAtual 
    else putStrLn "\nUsuario nao cadastrado" 
    
    if pesoAnt > pesoAtual then
        printf "\nSe era este seu objetivo, parabens! Vc perdeu %f kg\n"  pesoEmagreceu 
    else  printf "\nSe era este seu objetivo, parabens! Vc ganhou %f kg\n"  pesoEngordou 

    putStrLn "\nPressione Enter para voltar ao menu principal."
    getLine
    limparTela

    menu (atualizarPesoUsuario usuarios (read id :: Int) pesoAtual)

--operacoes do programa: exibicao usuario--
opcao '4' usuarios = do
    putStrLn "\nQual o seu id?: "
    id <-getLine 
    putStrLn ""
    limparTela
    putStr(exibirUsuario usuarios (read id :: Int))
    putStrLn "\nPressione Enter para voltar ao menu principal."
    getLine
    limparTela
    main

-- operacoes do programa: sugestoes de dieta--
opcao '5' usuarios = do
    limparTela
    putStrLn "\nQual o seu objetivo? Bulking (b) -- Cutting (c) -- Perda de peso (p)?"
    guess <- getLine 
    limparTela
    if guess == "b"
        then putStrLn Dieta.bulking 
    else if guess == "c"
        then putStrLn Dieta.cutting 
    else if guess == "p"
        then putStrLn Dieta.perda 
    else main
    getLine 
    main
        
-- operacoes do programa: guia ajuda --
opcao '6' usuarios = do
    limparTela
    putStrLn "\n--- Como o Appademia pode te ajudar? ---"
    putStrLn "1 - Termos do mundo da musculação."
    putStrLn "2 - Planos de pagamento."
    putStrLn "3 - Dicas para novatos."
    putStrLn "4 - Cancelamento de matricula."
    putStrLn "5 - Tabela IMC."
    putStrLn ""
    putStrLn "Opcao escolhida -> "
    guess <- getLine
    limparTela
    if guess == "1"
        then putStrLn Termos.topicos
    else if guess == "2"
        then putStrLn Planos.plano 
    else if guess == "3"
        then putStrLn Dicas.dica 
    else if guess == "4"
        then putStrLn Cancelamento.cancel
    else if guess == "5"
        then putStrLn Imc.indice 
    else main
    getLine 
    main

-- operacoes do programa: saida--
opcao '7' usuarios = do
    return ()

opcao _  usuarios = do
    menu usuarios

limparTela :: IO()
limparTela = do
    _ <- SP.system "cls"
    return ()

-- menu academia --
menu usuarios = do
    putStrLn "\n-------------------------------- Bem vindo ao Appademia! --------------------------------"
    putStrLn "Escolha uma opção: "
    putStrLn "1. Novo usuario;"
    putStrLn "2. Atualizar treino;"
    putStrLn "3. Atualizar peso;"
    putStrLn "4. Exibir usuario;"
    putStrLn "5. Recomendacao de Dietas;"
    putStrLn "6. Ajuda" 
    putStrLn "7. Sair"
    putStrLn ""
    putStrLn "Opcao escolhida -> "
    op <- getChar   
    getChar
    opcao op usuarios

main :: IO()
main = do
    limparTela
    menu []