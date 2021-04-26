import Data.Time.Clock
import Data.Time.Calendar
import Data.Functor
import Data.List
import System.IO (hSetBuffering, stdin, BufferMode(NoBuffering))
import qualified System.Process as SP

{-# LANGUAGE BlockArguments #-}
data Usuario = Usuario {id:: Int,   
                        nome::String, 
                        idade:: String ,
                        peso:: String,
                        altura:: String,
                        plano:: String,
                        resposta:: String,
                        dataEntrada :: String
                        }

userId :: Usuario -> Int
userId (Usuario id _ _ _ _ _ _ _ ) = id

cadastrarUsuario :: [Usuario] -> Usuario -> [Usuario]
cadastrarUsuario usuarios usuario
    |usuarioCheck usuarios (userId usuario) = usuarios
    |otherwise = usuarios ++ [usuario]

exibirUsuario :: [Usuario] -> Int -> String
exibirUsuario []_ = "Nao cadastrado"
exibirUsuario usuarios id
    | userId (head usuarios) == id = toString(head usuarios)  
    | otherwise = exibirUsuario(tail usuarios) id

usuarioCheck :: [Usuario] -> Int -> Bool
usuarioCheck[]_ = False
usuarioCheck  usuarios id
    |userId(head usuarios) == id = True 
    |otherwise = usuarioCheck(tail usuarios) id

atualizarPesoUsuario :: [Usuario] -> Int -> String -> [Usuario]
atualizarPesoUsuario [usuario] id peso
    | userId usuario == id = [mudaPeso usuario peso]
    | otherwise = [usuario]



toString(Usuario id nome idade peso altura plano resposta dataEntrada) = "--- Dados Usuario --- " ++ "Nome: " ++ show nome ++ "\nIdade: " ++ show idade ++ 
                                                             "\nPeso: " ++ show peso ++ "\nAltura: " ++ show altura ++ "\nPlano: " ++ show plano ++
                                                             "\nLevel: " ++ resposta ++ "\nMembro desde: " ++ dataEntrada ++ "\n"
mudaPeso (Usuario id nome idade peso altura plano resposta dataEntrada) novoPeso = Usuario id nome idade novoPeso altura plano resposta dataEntrada

opcao '1' usuarios = do
    putStrLn "\nCrie um ID numerico. Ele servira para quaisquer operacao no aplicativo: "
    id <- getLine
    putStrLn "\nNome completo: "
    nome <- getLine
    putStrLn "\nIdade: "
    idade <- getLine
    putStrLn "\nPeso: "
    peso <- getLine
    putStrLn "\nAltura: "
    altura <- getLine
    putStrLn "\nPlano de Pagamento: "
    plano <- getLine
    putStrLn "\nPrimeira vez em uma academia?[sim/nao]: "
    resposta <- getLine
    dataEntrada <- fmap show getCurrentTime 
    putStrLn ""
    menu (cadastrarUsuario usuarios ( Usuario (read id :: Int)  nome idade peso altura plano resposta dataEntrada))
    
opcao '2' usuarios = do
    putStrLn "Qual o seu id?: "
    id <-getLine 
    putStr ""
    --limparTela
    main

opcao '3' usuarios = do
    putStrLn "\nQual o seu id?: "
    id <-getLine 
    putStrLn ""
    --limparTela
    main

opcao '4' usuarios = do
    putStrLn "Qual o seu id?: "
    id <-getLine 
    putStrLn ""
    --limparTela
    main

opcao '5' usuarios = do
    putStrLn "Qual o seu id?: "
    id <- getLine 
    putStrLn "Peso atual: "
    pesoAtual <- getLine
    putStrLn ""
    menu (atualizarPesoUsuario usuarios (read id :: Int) pesoAtual)

opcao '6' usuarios = do
    putStrLn "Qual o seu id?: "
    id <-getLine 
    putStrLn ""
    putStr(exibirUsuario usuarios (read id :: Int))
    putStrLn ""
    menu usuarios

opcao '7' usuarios = do
    limparTela
    putStrLn "--- Como o Appademia pode te ajudar? ---"
    putStrLn "1 - Termos do mundo da musculação."
    putStrLn "2 - Planos de pagamento."
    putStrLn "3 - Dicas para novatos."
    putStrLn "4 - Cancelamento de matricula."
    putStrLn "5 - voltar."
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
    else main

opcao _  usuarios = do
    menu usuarios


termos :: IO()
termos = do
    limparTela
    putStrLn "-- TERMOS DO MUNDO DA MUSCULAÇÃO xD --"
    putStrLn "ABS: ..."
    putStrLn "Acidolatico: ..."
    putStrLn "Aerobico: ..."
    putStrLn "Cardio: ..."
    putStrLn "Anabolismo: ..."
    putStrLn "Metabolismo: ..."
    putStrLn "Catabolismo: ..."
    putStrLn "Bulking: ..."
    putStrLn "Cutting: ..."
    putStrLn "Bodybuilding: ..."
    putStrLn ""
    putStrLn "Pressione Enter para voltar ao menu principal."
    
    getLine
    
    main


planos :: IO()
planos = do
    limparTela
    putStrLn "-- PLANOS E PREÇOS :O --"
    putStrLn "Plano Anual:         12 x R$76,90"
    putStrLn "Plano Semestral:      6 x R$82,90"
    putStrLn "Plano Trimestral:     3 x R$87,90"
    putStrLn "Plano Mensal:             R$98,00"
    putStrLn ""
    putStrLn "Pressione Enter para voltar ao menu principal."
    
    getLine
    
    main

    
dicas :: IO()
dicas = do
    limparTela
    putStrLn "-- DICAS IMPORTANTES :) --"
    putStrLn "Dica 1: ..."
    putStrLn "Dica 2: ..."
    putStrLn "Dica 3: ..."
    putStrLn "Dica 4: ..."
    putStrLn "Dica 5: ..."
    putStrLn ""
    putStrLn "Pressione Enter para voltar ao menu principal."
    
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
    putStrLn "2. Cadastrar treinos;"
    putStrLn "3. Exibir treino;"
    putStrLn "4. Atualizar treino;"
    putStrLn "5. Atualizar peso;"
    putStrLn "6. Exibir usuario;"
    putStrLn "7. Ajuda;"
    putStrLn ""
    putStrLn "Opcao escolhida -> "
    op <- getChar   
    getChar
    opcao op usuarios

main :: IO()
main = do
    limparTela
    menu []