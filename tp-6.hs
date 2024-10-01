-- -- 2 - MAPA DE TESOROS (con bifurcaciones).

data Dir = Izq | Der
  deriving (Show)

data Objeto = Tesoro | Chatarra
  deriving (Show)

data Cofre = Cofre [Objeto]
  deriving (Show)

data Mapa = Fin Cofre | Bifurcacion Cofre Mapa Mapa -- EmptyT | NodeT a (t1) (t2)
  deriving (Show)

-- Un mapa simple con un cofre que contiene un tesoro
mapa1 :: Mapa
mapa1 = Fin (Cofre [Tesoro, Chatarra])

-- Un mapa bifurcado donde uno de los cofres tiene un tesoro y el otro no
mapa2 :: Mapa
mapa2 =
  Bifurcacion
    (Cofre [Chatarra])
    (Fin (Cofre [Chatarra]))
    (Fin (Cofre [Tesoro, Chatarra]))

-- Un mapa bifurcado sin tesoros en los cofres
mapa3 :: Mapa
mapa3 =
  Bifurcacion
    (Cofre [Chatarra])
    (Fin (Cofre [Chatarra]))
    (Fin (Cofre [Chatarra]))


mapaComplejo :: Mapa
mapaComplejo =
  Bifurcacion
    (Cofre [Chatarra])
    ( Bifurcacion
        (Cofre [Chatarra])
        ( Bifurcacion
            (Cofre [Chatarra])
            (Fin (Cofre [Chatarra]))
            (Fin (Cofre [Tesoro, Chatarra]))
        )
        ( Bifurcacion
            (Cofre [Chatarra])
            (Fin (Cofre [Chatarra]))
            (Fin (Cofre [Chatarra]))
        )
    )
    ( Bifurcacion
        (Cofre [Chatarra])
        ( Bifurcacion
            (Cofre [Chatarra])
            (Fin (Cofre [Chatarra]))
            (Fin (Cofre [Chatarra]))
        )
        (Fin (Cofre [Tesoro]))
    )


-- Función Auxiliar práctica 3
hayTesoroEnCofre' :: [Objeto] -> Bool
hayTesoroEnCofre' [] = False
hayTesoroEnCofre' (Tesoro : _) = True
hayTesoroEnCofre' (_ : obs) = hayTesoroEnCofre' obs

-- a) Indica si hay un tesoro en alguna parte del mapa.
hayTesoro :: Mapa -> Bool
hayTesoro (Fin (Cofre objetos)) = hayTesoroEnCofre' objetos
hayTesoro (Bifurcacion (Cofre objetos) m1 m2) = hayTesoroEnCofre' objetos || hayTesoro m1 || hayTesoro m2

-- b) Indica si al final del camino hay un tesoro. Nota: el final de un camino se representa
-- con una lista vacía de direcciones.
hayTesoroEn :: [Dir] -> Mapa -> Bool
hayTesoroEn [] (Fin (Cofre objetos)) = hayTesoroEnCofre' objetos
hayTesoroEn [] _ = False
hayTesoroEn (Izq : dirs) (Bifurcacion _ izq der) = hayTesoroEn dirs izq
hayTesoroEn (Der : dirs) (Bifurcacion _ izq der) = hayTesoroEn dirs der
hayTesoroEn _ _ = False



-- c) Indica el camino al tesoro.
-- Precondición: Existe un tesoro y es único.
caminoAlTesoro :: Mapa -> [Dir]
caminoAlTesoro (Fin (Cofre objetos)) = []
caminoAlTesoro (Bifurcacion (Cofre objetos) izq der) =
  -- Esto es posible por la precondición si no es izq es der.
  if hayTesoro izq
    then Izq : caminoAlTesoro izq
    else Der : caminoAlTesoro der





