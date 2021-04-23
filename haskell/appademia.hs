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

opcao '1' academia = do
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
    

opcao '2' academia = do
    putStr "Qual o seu id?: "
    id <-getLine 
    putStr ""

opcao '3' academia = do
    putStr "Qual o seu id?: "
    id <-getLine 
    putStr ""

opcao '4' academia = do
    putStr "Qual o seu id?: "
    id <-getLine 
    putStr ""

opcao '5' acadmeia = do
    putStr "Qual o seu id?: "
    id <-getLine 
    putStr "Peso atual: "
    pesoAtual <-getLine
    putStr ""

opcao '6' academia = do
    putStr "Qual o seu id?: "
    id <-getLine 
    putStr ""

opcao _ academia = do
    menu academia


menu academia = do
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
    putStrLn ""
    opcao op academia

start = do
    menu[]
