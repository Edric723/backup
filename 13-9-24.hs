-- 1 - PIZZAS

data Pizza = Prepizza | Capa Ingrediente Pizza
        deriving Show

data Ingrediente = Salsa | Queso | Jamon | Aceitunas Int
        deriving Show

pizza0  = (Capa (Aceitunas 12)(Capa Jamon(Capa Queso(Capa Salsa Prepizza))))
pizza1 = (Capa Queso(Capa Salsa(Prepizza)))



-- a) Dada una pizza devuelve la cantidad de ingredientes.
cantidadDeCapas :: Pizza -> Int
cantidadDeCapas Prepizza                  = 0
cantidadDeCapas (Capa _ p)                = 1 + cantidadDeCapas p

-- b) Dada una lista de ingredientes construye una pizza.
armarPizza :: [Ingrediente] -> Pizza
armarPizza []                       = Prepizza
armarPizza (ing : ings)             = Capa ing (armarPizza ings)

-- c) Le saca los ingredientes que sean jamón a la pizza.
sacarJamon :: Pizza -> Pizza
sacarJamon Prepizza                 = Prepizza
sacarJamon (Capa Jamon p)           = sacarJamon p
sacarJamon (Capa ing p)             = Capa ing (sacarJamon p)


tieneSoloSalsaYQueso :: Pizza -> Bool
tieneSoloSalsaYQueso Prepizza     = True
tieneSoloSalsaYQueso (Capa ing p) = esIngQuesoOSalsa ing && tieneSoloSalsaYQueso p

esIngQuesoOSalsa :: Ingrediente -> Bool
esIngQuesoOSalsa Queso = True
esIngQuesoOSalsa Salsa = True
esIngQuesoOSalsa _     = False



-- e) Recorre cada ingrediente y si es aceitunas duplica su cantidad.
duplicarAceitunas :: Pizza -> Pizza
duplicarAceitunas Prepizza          = Prepizza
duplicarAceitunas (Capa ing p)      = -- si la capa es aceitunas duplica su cantidad - recursión.


-- -- f) Dada una lista de pizzas devuelve un par donde la primera componente es la cantidad de
-- -- ingredientes de la pizza, y la respeciva pizza como segunda componente.
-- cantCapasPorPizza :: [Pizza] -> [(Int, Pizza)]


-- 2 - MAPA DE TESOROS (con bifurcaciones)

data Dir = Izq | Der
    deriving Show

data Objeto = Tesoro | Chatarra
    deriving Show

data Cofre = Cofre [Objeto]
    deriving Show

data Mapa = Fin Cofre | Bifurcacion Cofre Mapa Mapa  -- EmptyT | NodeT a (t1) (t2)
    deriving Show


-- a) Indica si hay un tesoro en alguna parte del mapa.
hayTesoro :: Mapa -> Bool
hayTesoro Fin Cofre = 

-- b) Indica si al final del camino hay un tesoro. Nota: el final de un camino se representa
-- con una lista vacía de direcciones.
hayTesoroEn :: [Dir] -> Mapa -> Bool



-- c) Indica el camino al tesoro. Precondición: Existe un tesoro y es único.
caminoAlTesoro :: Mapa -> [Dir]



-- d) Indica el camino de la rama más larga.
caminoDeLaRamaMasLarga :: Mapa -> [Dir]

-- e) Devuelve los tesoros separados por nivel en el árbol.
tesorosPorNivel :: Mapa -> [[Objeto]]


-- f) Devuelve todos los caminos en el mapa.
todosLosCaminos :: Mapa -> [[Dir]]




-- 3 - NAVE ESPACIAL

data Componente = LanzaTorpedos | Motor Int | Almacen [Barril]
        deriving Show

data Barril = Comida | Oxigeno | Torpedo | Combustible
        deriving Show

data Sector = S SectorId [Componente] [Tripulante]
        deriving Show

type SectorId = String
type Tripulante = String

data Tree a = EmptyT | NodeT a (Tree a) (Tree a)
        deriving Show

data Nave = N (Tree Sector)
        deriving Show

-- a)
-- b)
-- c)
-- d)
-- e)
-- f)
-- g)

-- 4 - LOBOS

type Presa      = String -- nombre de la presa
type Territorio = String -- nombre del territorio
type Nombre     = String -- nombre de Lobo

data Lobo   = Cazador Nombre [Presa] Lobo Lobo Lobo
            | Explorador Nombre [Territorio] Lobo Lobo
            | Cria Nombre
        deriving Show

data Manada = M Lobo
        deriving Show

        
-- a)
-- b)
-- c)
-- d)
-- e)
-- f)

