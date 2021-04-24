import Data.List
import System.IO (hSetBuffering, stdin, BufferMode(NoBuffering))
import qualified System.Process as SP
---nada funciona ainda---

{-# LANGUAGE BlockArguments #-}
data Usuario = Usuario {id:: Int,   
                        nome::String, 
                        idade:: String ,
                        peso:: String,
                        altura:: String,
                        plano:: String,
                        resposta:: String 
                        }


userId :: Usuario -> Int
userId (Usuario id _ _ _ _ _ _ ) = id

cadastrarUsuario :: [Usuario] -> Usuario -> [Usuario]
cadastrarUsuario usuarios usuario
    |usuarioCheck usuarios (userId usuario) = usuarios
    |otherwise = usuarios ++ [usuario]

exibirUsuario :: [Usuario] -> Int -> String
exibirUsuario []_ = "Nao cadastrado"
exibirUsuario usuarios id
    | userId (head usuarios) == id = toString(head usuarios)  
    | otherwise = "Nao cadastrado"

usuarioCheck :: [Usuario] -> Int -> Bool
usuarioCheck[]_ = False
usuarioCheck  usuarios id
    |userId(head usuarios) == id = True 
    |otherwise = usuarioCheck(tail usuarios) id

toString(Usuario id nome idade peso altura plano resposta) = "--- Dados Usuario --- " ++ "Nome: " ++ show nome ++ "\nIdade: " ++ show idade ++ 
                                                             "\nPeso: " ++ show peso ++ "\nAltura: " ++ show altura ++ "\nPlano: " ++ show plano ++
                                                             "\nLevel: " ++ resposta

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
    putStrLn ""
    menu (cadastrarUsuario usuarios ( Usuario (read id :: Int)  nome idade peso altura plano resposta))
    
opcao '2' usuarios = do
    putStrLn "Qual o seu id?: "
    id <-getLine 
    putStr ""
    limparTela
    --menu

opcao '3' usuarios = do
    putStrLn "\nQual o seu id?: "
    id <-getLine 
    putStrLn ""
    limparTela
     --menu

opcao '4' usuarios = do
    putStrLn "Qual o seu id?: "
    id <-getLine 
    putStrLn ""
    limparTela
     --menu

opcao '5' usuarios = do
    putStrLn "Qual o seu id?: "
    id <-getLine 
    putStrLn "Peso atual: "
    pesoAtual <-getLine
    putStrLn ""
    limparTela
   --menu

opcao '6' usuarios = do
    putStrLn "Qual o seu id?: "
    id <-getLine 
    putStrLn ""
    putStr(exibirUsuario usuarios (read id :: Int))
    putStrLn ""
    menu usuarios

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
    menu []