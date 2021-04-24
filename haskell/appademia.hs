import System.IO
import qualified System.Process as SP
---nada funciona ainda---

{-# LANGUAGE BlockArguments #-}
data Usuario = Usuario Int String Int Double Double String String 


cadastrarUsuario :: [Usuario] -> Usuario -> [Usuario]
cadastrarUsuario usuarios usuario
    |usuarioCheck usuarios (userId usuario) = usuarios
    |otherwise = usuarios ++ [usuario]


userId :: Usuario -> Int
userId (Usuario id _ _ _ _ _ _ ) = id

usuarioCheck :: [Usuario] -> Int -> Bool
usuarioCheck  usuarios id
    |userId(head usuarios) == id = True 
    |otherwise = usuarioCheck(tail usuarios) id

opcao :: Char -> IO()
opcao '1' = do
    putStr "Nome completo: "
    nome <- getLine
    putStr "Idade: "
    idade <- getLine
    putStr "Peso: "
    peso <- getLine
    putStr "Altura: "
    altura <- getLine
    putStr "Plano de Pagamento: "
    plano <- getLine
    putStr "Primeira vez em uma academia?[sim/nao]: "
    resposta <- getLine
    putStrLn ""
    limparTela
    menu
    
opcao '2' = do
    putStr "Qual o seu id?: "
    id <-getLine 
    putStr ""
    limparTela
    menu

opcao '3' = do
    putStr "Qual o seu id?: "
    id <-getLine 
    putStr ""
    limparTela
    menu

opcao '4' = do
    putStr "Qual o seu id?: "
    id <-getLine 
    putStr ""
    limparTela
    menu

opcao '5' = do
    putStr "Qual o seu id?: "
    id <-getLine 
    putStr "Peso atual: "
    pesoAtual <-getLine
    putStr ""
    limparTela
    menu

opcao '6' = do
    putStr "Qual o seu id?: "
    id <-getLine 
    putStr ""
    limparTela
    menu

opcao _  = do
    putStr ""
    menu


limparTela :: IO()
limparTela = do
    _ <- SP.system "cls"
    return ()

-- menu academia
menu :: IO()
menu = do
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
    putStrLn ""
    opcao op

start :: IO()
start = do
    limparTela
    menu