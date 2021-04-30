module Imc where
-- informacoes sobre o imc --
indice :: String
indice = unlines [
    "---- IMC ----",
    
    "\nIMC eh a sigla para indice de massa corporal, um calculo que indica se a pessoa esta dentro do peso em relacao a sua altura. O calculo eh feito da seguinte forma: ",

    "\nPeso / (Altura x Altura)",

    "\nA tabela a seguir indica os possiveis resultados do calculo:",

    "\n    IMC              Classificacao",

    "\n< 18.5         PESO ABAIXO DA NORMALIDADE",

    "\n18.5 - 24.9    PESO NORMAL",

    "\n25.0 - 29.9    SOBREPESO",

    "\n30.0 - 34.9    OBESIDADE (GRAU 1)",

    "\n35.0 - 39.9    OBESIDADE SEVERA (GRAU 2)",

    "\n>= 40.0        OBESIDADE MORBIDA (GRAU 3)",

    "\nPressione Enter para voltar ao menu principal."
 ]


    



