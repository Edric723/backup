-- 1 - TIPOS RECURSIVOS SIMPLES

-- 1.1 - Celdas con bolitas
data Color = Azul | Rojo
        deriving Show

data Celda = Bolita Color Celda | CeldaVacia
        deriving Show


nroBolitas :: Color -> Celda -> Int
nroBolitas _ CeldaVacia           = 0 -- Si la celda está vacía no hay bolitas para contar.
nroBolitas c (Bolita color celda) =
    if color == c
    then 1 + nroBolitas color celda
    else nroBolitas color celda

-- Definir las siguientes funciones:

-- Dado un color y una celda, agrega una bolita de dicho color a la celda.
poner :: Color -> Celda -> Celda
poner color celda = Bolita color celda

-- Dado un color y una celda, quita una bolita de dicho color de la celda.
sacar :: Color -> Celda -> Celda


-- Dado un número n , un color c y una celda, agrega n bolitas de color c a la celda.
ponerN :: Int -> Color -> Celda -> Celda


-- 1.2 - Camino hacia el tesoro
data Objeto = Cacharro | tesoro
    deriving Show

data Camino = Fin | Cofre [Objeto] Camino | Nada Camino
    deriving Show

-- Definir las siguientes funciones:

-- Indica si hay un cofre con un tesoro en el camino.
hayTesoro :: Camino -> Bool

-- Indica la cantidad de pasos que hay que recorrer hasta llegar al primer cofre con un tesoro.
-- Si un cofre con un tesoro está al principio del camino, la cantidad de pasos a recorrer es 0.
-- Precondición: Tiene que haber al menos un tesoro.
pasosHastaTesoro :: Camino -> Int

-- Indica si hay un tesoro en una cierta cantidad exacta de pasos. Por ejemplo, si el número de pasos es 5, indica que hay un tesoro en 5 pasos.
hayTesoroEn :: Int -> Camino -> Bool


--


-- 2 - TIPOS ARBOREOS

-- 2.1 - Árboles binarios
-- 2.2 - Expresiones Aritméticas