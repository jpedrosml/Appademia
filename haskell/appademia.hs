import TreinoIniciante
import TreinoMedio
import TreinoAvancado
import Dicas
import Planos
import Termos
import Imc
import Data.Time.Clock ( getCurrentTime )
import Data.Time.Calendar
import Data.Functor
import Data.List
import Data.Char
import System.IO (hSetBuffering, stdin, BufferMode(NoBuffering))
import qualified System.Process as SP


{-# LANGUAGE BlockArguments #-}
data Usuario = Usuario {id:: Int,   
                        nome::String, 
                        idade:: Int ,
                        peso:: Float,
                        altura:: Float,
                        plano:: String,
                        resposta:: String,
                        dataEntrada :: String,
                        treino :: String
                        }

userId :: Usuario -> Int
userId (Usuario id _ _ _ _ _ _ _ _) = id

userPeso :: Usuario -> Float
userPeso (Usuario _ _ _ peso _ _ _ _ _ ) = peso


cadastrarUsuario :: [Usuario] -> Usuario -> [Usuario]
cadastrarUsuario usuarios usuario
    |usuarioCheck usuarios (userId usuario) = usuarios
    |otherwise = usuarios ++ [usuario]

exibirUsuario :: [Usuario] -> Int -> String
exibirUsuario []_ = "Nao cadastrado\n"
exibirUsuario usuarios id
    | userId (head usuarios) == id = toString(head usuarios)  
    | otherwise = exibirUsuario(tail usuarios) id

usuarioCheck :: [Usuario] -> Int -> Bool
usuarioCheck[]_ = False
usuarioCheck  usuarios id
    |userId(head usuarios) == id = True 
    |otherwise = usuarioCheck(tail usuarios) id

atualizarPesoUsuario :: [Usuario] -> Int -> Float -> [Usuario]
atualizarPesoUsuario [usuario] id peso
    | userId usuario == id = [mudaPeso usuario peso]
    | otherwise = [usuario]

atualizarTreinoUsuario :: [Usuario] -> Int -> String -> [Usuario]
atualizarTreinoUsuario [usuario] id treino
    | userId usuario == id = [mudaTreino usuario treino]
    | otherwise = [usuario]

removeItem :: Int -> [Usuario] -> [Usuario]
removeItem _ []     = []
removeItem id usuarios
    |userId(head usuarios) == id = removeItem id (tail usuarios)
    |otherwise = removeItem id (tail usuarios)

toString(Usuario id nome idade peso altura plano resposta dataEntrada treino) = "--- Dados Usuario --- " ++ 
                                                            "\nNome: " ++ show nome ++ 
                                                            "\nIdade: " ++ show idade ++ 
                                                            "\nPeso: " ++ show peso ++ 
                                                            "\nAltura: " ++ show altura ++ 
                                                            "\nPlano: " ++ show plano ++
                                                            "\nLevel: " ++ resposta ++ 
                                                            "\nMembro desde: " ++ dataEntrada ++ 
                                                            "\nTreino: " ++ treino -- treino exibindo aqui apenas para teste

mudaPeso (Usuario id nome idade peso altura plano resposta dataEntrada treino) novoPeso = Usuario id nome idade novoPeso altura plano resposta dataEntrada treino

mudaTreino (Usuario id nome idade peso altura plano resposta dataEntrada treino) novoTreino = Usuario id nome idade peso altura plano resposta dataEntrada novoTreino


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
    if resposta ==  "sim"
        then menu (cadastrarUsuario usuarios ( Usuario (read id :: Int)  nome idade peso altura plano resposta dataEntrada TreinoIniciante.treinoIni))
    else if resposta == "nao"
        then menu (cadastrarUsuario usuarios ( Usuario (read id :: Int)  nome idade peso altura plano resposta dataEntrada TreinoMedio.treinoMed))
    else putStrLn "opcao invalida"
   
    putStrLn ""
    
    
opcao '2' usuarios = do
    putStrLn "\nQual o seu id?: "
    id <-getLine 
    putStrLn "\nQual treino você gostaria de cadastrar? [Iniciante/Medio/Avancado]"
    treino <- getLine
    putStrLn ""
    limparTela
    if treino == "iniciante"
        then menu (atualizarTreinoUsuario usuarios (read id :: Int ) TreinoIniciante.treinoIni)
    else if treino == "medio"
        then menu (atualizarTreinoUsuario usuarios (read id :: Int ) TreinoMedio.treinoMed)
    else if treino == "avancado"
        then menu (atualizarTreinoUsuario usuarios (read id :: Int ) TreinoAvancado.treinoAva)
    else putStrLn "opcao invalida"
    
    main

opcao '3' usuarios = do
    putStrLn "\nQual o seu id?: "
    id <-getLine
    main
    

opcao '4' usuarios = do
    putStrLn "\nQual o seu id?: "
    id <- getLine 
    putStrLn "Peso atual: "
    pesoAtual <- readLn
    putStrLn ""
    menu (atualizarPesoUsuario usuarios (read id :: Int) pesoAtual)

opcao '5' usuarios = do
    putStrLn "\nQual o seu id?: "
    id <-getLine 
    putStrLn ""
    limparTela
    putStr(exibirUsuario usuarios (read id :: Int))
    putStrLn "\nPressione Enter para voltar ao menu principal."
    getLine
    limparTela
    menu usuarios

opcao '6' usuarios = do
    limparTela
    putStrLn "--- Como o Appademia pode te ajudar? ---"
    putStrLn "1 - Termos do mundo da musculação."
    putStrLn "2 - Planos de pagamento."
    putStrLn "3 - Dicas para novatos."
    putStrLn "4 - Cancelamento de matricula."
    putStrLn "5 - Tabela IMC."
    putStrLn ""
    putStrLn "Opcao escolhida -> "
    guess <- getLine
    if guess == "1" 
        then termos
    else if guess == "2"
        then planos
    else if guess == "3"
        then dicas
    else if guess == "4"
        then cancel
    else if guess == "5"
        then imc
    else main

opcao _  usuarios = do
    menu usuarios


termos :: IO()
termos = do
    limparTela
    putStrLn Termos.topicos 
    getLine
    main


planos :: IO()
planos = do
    limparTela
    putStrLn Planos.plano 
    getLine
    main

    
dicas :: IO()
dicas = do
    limparTela
    putStrLn Dicas.dica   
    getLine
    main


cancel :: IO()
cancel = do
    limparTela
    putStrLn "-- CANCELAMENTO DE MATRICULA :( --"
    putStrLn "Para realizar o cancelamento da matricula entre em contato com (XX)XXXXX-XXXX."
    putStrLn "Ou compareça à administração da academia."
    putStrLn ""
    putStrLn "Pressione Enter para voltar ao menu principal."
    putStrLn ""
    getLine
    
    main

imc :: IO()
imc = do
    limparTela
    putStrLn Imc.indice
    getLine
    main

limparTela :: IO()
limparTela = do
    _ <- SP.system "cls"
    return ()

-- menu academia
menu usuarios = do
    putStrLn "-------------------------------- Bem vindo ao Appademia! --------------------------------"
    putStrLn "Escolha uma opção: "
    putStrLn "1. Novo usuario;"
    putStrLn "2. Atualizar treino;"
    putStrLn "3. Exibir treino;"
    putStrLn "4. Atualizar peso;"
    putStrLn "5. Exibir usuario;"
    putStrLn "6. Ajuda;"
    putStrLn ""
    putStrLn "Opcao escolhida -> "
    op <- getChar   
    getChar
    opcao op usuarios

main :: IO()
main = do
    limparTela
    menu []