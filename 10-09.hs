data Pizza = Prepizza | Capa Ingrediente Pizza deriving (Show)

data Ingrediente = Salsa | Queso | Jamon | Aceitunas Int deriving (Show)

p  = (Capa (Aceitunas 12)(Capa Jamon(Capa Queso(Capa Salsa Prepizza))))
p1 = (Capa Queso(Capa Salsa(Prepizza)))

cantidadDeCapas :: Pizza -> Int
cantidadDeCapas Prepizza   = 0
cantidadDeCapas (Capa _ p) = 1 + cantidadDeCapas p

armarPizza :: [Ingrediente] -> Pizza
armarPizza []        = Prepizza
armarPizza (i:ings)  = Capa i (armarPizza ings)

sacarJamon :: Pizza -> Pizza
sacarJamon Prepizza     = Prepizza
sacarJamon (Capa ing p) = if esJamon ing 
                          then sacarJamon p
                          else Capa ing (sacarJamon p)

esJamon :: Ingrediente -> Bool
esJamon Jamon = True
esJamon _     = False

tieneSoloSalsaYQueso :: Pizza -> Bool
tieneSoloSalsaYQueso Prepizza     = True
tieneSoloSalsaYQueso (Capa ing p) = esQuesoOSalsa ing && tieneSoloSalsaYQueso p

esQuesoOSalsa :: Ingrediente -> Bool
esQuesoOSalsa Queso = True
esQuesoOSalsa Salsa = True
esQuesoOSalsa _     = False

duplicarAceitunas :: Pizza -> Pizza
duplicarAceitunas Prepizza     = Prepizza
duplicarAceitunas (Capa ing p) = duplicarSiEsAceituna ing (duplicarAceitunas p)

duplicarSiEsAceituna :: Ingrediente -> Pizza -> Pizza
duplicarSiEsAceituna (Aceitunas a) p = Capa (Aceitunas (a * 2)) p
duplicarSiEsAceituna ing           p = Capa ing p

cantCapasPorPizza :: [Pizza] -> [(Int, Pizza)]
cantCapasPorPizza []     = []
cantCapasPorPizza (p:ps) = (cantidadDeCapas p, p) : cantCapasPorPizza ps

data Dir = Izq | Der deriving (Show)
data Objeto = Tesoro | Chatarra
data Cofre = Cofre [Objeto]
data Mapa = Fin Cofre | Bifurcacion Cofre Mapa Mapa

m = Bifurcacion (Cofre [Chatarra]) (Bifurcacion (Cofre [Chatarra]) (Fin (Cofre [Chatarra])) (Fin (Cofre [Chatarra])))
                                   (Bifurcacion (Cofre [Chatarra]) (Fin (Cofre [Chatarra])) (Fin (Cofre [Tesoro])))

hayTesoro :: Mapa -> Bool
hayTesoro (Fin co)               = hayTesoroEnCofre co
hayTesoro (Bifurcacion co mi md) = hayTesoroEnCofre co || hayTesoro mi || hayTesoro md

hayTesoroEnCofre :: Cofre -> Bool
hayTesoroEnCofre (Cofre obs) = hayTesoroEnLista obs

hayTesoroEnLista :: [Objeto] -> Bool
hayTesoroEnLista []     = False
hayTesoroEnLista (o:os) = esTesoro o || hayTesoroEnLista os

esTesoro :: Objeto -> Bool
esTesoro Tesoro = True
esTesoro _      = False

hayTesoroEn :: [Dir] -> Mapa -> Bool
hayTesoroEn [] map = hayTesoro map
hayTesoroEn (p:ps) (Fin co) = False
hayTesoroEn (p:ps) (Bifurcacion co mi md) = if esIzquierda p
                                            then hayTesoroEn ps mi
                                            else hayTesoroEn ps md
{-
hayTesoroEn [] _            = .
hayTesoroEn (p:ps) (Fin co) = False
hayTesoroEn (p:ps) (Bifurcacion co mi md) = if esIzquierda p
                                            then hayTesoroEn ps mi
                                            else hayTesoroEn ps md
-}
caminoAlTesoro :: Mapa -> [Dir]
caminoAlTesoro (Fin co) = []
caminoAlTesoro (Bifurcacion co mi md) = if hayTesoroEnCofre co
                                        then []
                                        else if hayTesoro mi
                                             then Izq : caminoAlTesoro mi
                                             else Der : caminoAlTesoro md

esIzquierda :: Dir -> Bool
esIzquierda Izq = True
esIzquierda _   = False

{-
puede mover dir table ->
mover dire table -> table
poner untable -> untable

precondicion: hay *n* celda al este
pintarRojoAEsteEn :: Int -> Tablero -> Tablero
pintarRojoAEsteEn 0 ta  = poner Rojo ta
pintarRojoAEsteEn n ta  = poner Rojo (mover Este (pintarRojoAEsteEn (n-1) ta))
                          pintarRojoAEste (n-1) (mover(poner Rojo ta))
-}