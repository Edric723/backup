-- 1) Tipos recursivos simples
-- 1.1 Celdas con bolitas
data Color = Azul | Rojo
    deriving Show

data Celda = Bolita Color Celda | CeldaVacia
    deriving Show

nroBolitas :: Color -> Celda -> Int
nroBolitas cx CeldaVacia     = 0
nroBolitas cx (Bolita cb cd) = delta (sonMismoColor cx cb) + nroBolitas cx cd 

delta :: Bool -> Int
delta True  = 1
delta False = 0

sonMismoColor :: Color -> Color -> Bool
sonMismoColor Azul Azul = True
sonMismoColor Rojo Rojo = True
sonMismoColor _    _    = False
---------------------------------------------------------------
poner :: Color -> Celda -> Celda
poner cp CeldaVacia = Bolita cp CeldaVacia
poner cp cd         = Bolita cp cd

--------------------------------------------------
sacar :: Color -> Celda -> Celda
sacar cs CeldaVacia     = CeldaVacia
sacar cs (Bolita cb cd) = 
    if (sonMismoColor cs cb)
        then cd
        else Bolita cb (sacar cs cd)

celdaPrueba = Bolita Azul (Bolita Rojo (Bolita Azul CeldaVacia))
----------------------------------------------------------------
ponerN :: Int -> Color -> Celda -> Celda
ponerN 0 cp cd = cd
ponerN n cp cd = Bolita cp (ponerN (n-1) cp cd)
------------------------------------------------
-- 1.2) Camino hacia el tesoro

data Objeto = Cacharro | Tesoro                        
    deriving Show
data Camino = Fin | Cofre [Objeto] Camino | Nada Camino
    deriving Show

hayTesoro :: Camino -> Bool
hayTesoro Fin           = False
hayTesoro (Nada c)      = hayTesoro c
hayTesoro (Cofre obs c) = tienenTesoros obs || hayTesoro c

tienenTesoros :: [ Objeto ] -> Bool
tienenTesoros []     = False
tienenTesoros (o:os) = esTesoro o || tienenTesoros os

esTesoro :: Objeto -> Bool
esTesoro Tesoro = True
esTesoro _      = False

caminoPrueba = Nada (Cofre [Tesoro] (Nada (Cofre [Cacharro, Tesoro] (Nada Fin))))
-------------------------------------------------------------------
pasosHastaTesoro :: Camino -> Int
pasosHastaTesoro Fin            = error "No hay tesoro"
pasosHastaTesoro (Nada c)       = 1 + pasosHastaTesoro c
pasosHastaTesoro (Cofre obs c)  = 
    if (tienenTesoros obs) 
        then 0
        else 1 + pasosHastaTesoro c

------------------------------------------------------------------
hayTesoroEn :: Int -> Camino -> Bool
hayTesoroEn _ Fin           = False
hayTesoroEn n (Nada c)      = hayTesoroEn (n-1) c
hayTesoroEn 0 (Cofre obs c) = tienenTesoros obs
hayTesoroEn n (Cofre obs c) = hayTesoroEn (n-1) c
------------------------------------------------------------------
alMenosNTesoros :: Int -> Camino -> Bool
alMenosNTesoros n Fin           = False
alMenosNTesoros n (Nada c)      = alMenosNTesoros (n) c
alMenosNTesoros n (Cofre obs c) = cantTesorosEn obs >= n || alMenosNTesoros (n) c
----------------------------------------------------
cantTesorosEn :: [Objeto] -> Int
cantTesorosEn []     = 0
cantTesorosEn (o:os) = delta (esTesoro o) + cantTesorosEn os

------------------------------------------------------------
-- 2) Tipos arbóreos
-- 2.1 - Árboles binarios
data Tree a = EmptyT | NodeT a (Tree a) (Tree a)

-- 2.1.1
sumarT :: Tree Int -> Int
sumarT EmptyT          = 0
sumarT (NodeT n tl tr) = n + sumarT tl + sumarT tr

-- 2.1.2
sizeT :: Tree a -> Int
sizeT EmptyT          = 0
sizeT (NodeT x tl tr) = 1 + sizeT tl + sizeT tr

-- 2.1.3
mapDobleT :: Tree Int -> Tree Int
mapDobleT EmptyT          = EmptyT
mapDobleT (NodeT n tl tr) = NodeT (n*2) (mapDobleT tl) (mapDobleT tr)

-- 2.1.4
perteneceT :: Eq a => a -> Tree a -> Bool
perteneceT e EmptyT          = False
perteneceT e (NodeT x tl tr) = e == x || perteneceT e tl || perteneceT e tr

-- 2.1.5
aparicionesT :: Eq a => a -> Tree a -> Int
aparicionesT e EmptyT          = 0
aparicionesT e (NodeT x tl tr) = delta (e == x) + aparicionesT e tl + aparicionesT e tr

-- 2.1.6
leaves :: Tree a -> [a]
leaves EmptyT                  = []
leaves (NodeT x EmptyT EmptyT) = x : []
leaves (NodeT x tl tr)         = leaves tl ++ leaves tr

-- 2.1.7
heightT :: Tree a -> Int
heightT EmptyT          = 0
heightT (NodeT _ tl tr) = 1 + max (heightT tl) (heightT tr)

treePrueba = NodeT 1 (NodeT 2 EmptyT EmptyT)
                     (NodeT 3 (NodeT 4 EmptyT EmptyT) (NodeT 5 (NodeT 19 EmptyT EmptyT) EmptyT))

-- 2.1.8
mirrorT :: Tree a -> Tree a
mirrorT EmptyT          = EmptyT
mirrorT (NodeT x tl tr) = NodeT x (mirrorT tr) (mirrorT tl)

-- 2.1.9
toList :: Tree a -> [a]
toList EmptyT          = []
toList (NodeT x tl tr) = x : (toList tl ++ toList tr)

-- 2.1.10
levelN :: Int -> Tree a -> [a]
levelN n EmptyT          = []
levelN 0 (NodeT x _ _)   = x : []
levelN n (NodeT x tl tr) = levelN (n-1) tl ++ levelN (n-1) tr

-- 2.1.11
listPerLevel :: Tree a -> [ [a] ]
listPerLevel EmptyT          = []
listPerLevel (NodeT x tl tr) = [x] : juntarNiveles (listPerLevel tl) (listPerLevel tr)

juntarNiveles :: [ [a] ] -> [ [a] ] -> [ [a] ]
juntarNiveles []       nrs      = nrs
juntarNiveles nls      []       = nls
juntarNiveles (nl:nls) (nr:nrs) = (nl ++ nr) : juntarNiveles nls nrs

-- 2.1.12
ramaMasLarga :: Tree a -> [a] 
ramaMasLarga EmptyT          = []
ramaMasLarga (NodeT x tl tr) =
    if length (ramaMasLarga tl) > length (ramaMasLarga tr)
        then x : ramaMasLarga tl
        else x : ramaMasLarga tr

-- 2.1.13
todosLosCaminos :: Tree a -> [ [a] ]
todosLosCaminos EmptyT          = []
todosLosCaminos (NodeT x tl tr) = agregar_ATodos_ x (todosLosCaminos tl ++ todosLosCaminos tr)

agregar_ATodos_ :: a -> [ [a] ] -> [ [a] ]
agregar_ATodos_ x []     = [[x]] -- Me quedé sin "caminos" al que agregar la raíz x, entonces agrego directamente el primer "camino/paso" que corresponde a [x]
agregar_ATodos_ x (y:ys) = (x : y) : agregar_ATodos_ x ys

-- 2.2 Expresiones aritméticas
 
data ExpA = Valor Int
          | Sum ExpA ExpA
          | Prod ExpA ExpA
          | Neg ExpA
          deriving Show

-- 2.2.1 
eval :: ExpA -> Int
eval (Valor n)        = n
eval (Neg exp)        = (eval exp) * (-1)
eval (Sum exp1 exp2)  = (eval exp1) + (eval exp2)
eval (Prod exp1 exp2) = (eval exp1) * (eval exp2)

simplificar :: ExpA -> ExpA
simplificar (Neg exp)        = simplificarNeg exp
simplificar (Sum exp1 exp2)  = simplificarSum (simplificar exp1) (simplificar exp2)
simplificar (Prod exp1 exp2) = simplificarProd (simplificar exp1) (simplificar exp2)
simplificar exp              = exp

simplificarNeg :: ExpA -> ExpA
simplificarNeg (Neg exp) = exp
simplificarNeg exp       = exp

simplificarSum :: ExpA -> ExpA -> ExpA
simplificarSum (Valor 0)     exp = exp
simplificarSum exp (Valor 0) exp = exp
simplificarSum exp1 exp2         = Sum exp1 exp2

simplificarProd :: ExpA -> ExpA -> ExpA
simplificarProd exp1 exp2 = undefined


