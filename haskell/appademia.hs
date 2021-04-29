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

existeUsuario :: Bool -> String 
existeUsuario existe
    | existe  = "\nUsuario ja cadastrado.\n"
    | otherwise = "\nCadastro com sucesso\n\n"

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
                                                            "\nIniciante: " ++ resposta ++ 
                                                            "\nMembro desde: " ++ dataEntrada ++ 
                                                            "\nTreino: " ++ treino
                                                            

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
    putStr (existeUsuario(usuarioCheck usuarios(read id :: Int)))
    if resposta ==  "sim"
        then menu (cadastrarUsuario usuarios ( Usuario (read id :: Int)  nome idade peso altura plano resposta dataEntrada Treino.treinoIni))
    else if resposta == "nao"
        then menu (cadastrarUsuario usuarios ( Usuario (read id :: Int)  nome idade peso altura plano resposta dataEntrada Treino.treinoMed))
    else putStrLn "opcao invalida"
    putStrLn ""
    
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

opcao '3' usuarios = do
    putStrLn "\nQual o seu id?: "
    id <- getLine 
    putStrLn "\nPeso atual: "
    pesoAtual <- readLn
    putStrLn ""
    limparTela
    menu (atualizarPesoUsuario usuarios (read id :: Int) pesoAtual)

opcao '4' usuarios = do
    putStrLn "\nQual o seu id?: "
    id <-getLine 
    putStrLn ""
    limparTela
    putStr(exibirUsuario usuarios (read id :: Int))
    putStrLn "\nPressione Enter para voltar ao menu principal."
    getLine
    limparTela
    menu usuarios

opcao '5' usuarios = do
    limparTela
    putStrLn "Qual o seu objetivo? Bulking (b) -- Cutting (c) -- Perda de peso (p)?"
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

opcao _  usuarios = do
    menu usuarios

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
    putStrLn "3. Atualizar peso;"
    putStrLn "4. Exibir usuario;"
    putStrLn "5. Recomendacao de Dietas;"
    putStrLn "6. Ajuda" 
    putStrLn ""
    putStrLn "Opcao escolhida -> "
    op <- getChar   
    getChar
    opcao op usuarios

main :: IO()
main = do
    limparTela
    menu []