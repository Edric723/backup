data Dir = Este | Sur | Oeste | Norte
        deriving Show

data Color = Azul | Negro | Rojo | Verde
        deriving Show


puedeMover :: Dir -> Tablero -> Bool


mover :: Dir -> Tablero -> Tablero

poner :: Color -> Tablero -> Tablero


pintarRojoAEsteEn :: Int -> Tablero -> Tablero
pintarRojoAEsteEn 0 tablero = poner Rojo tablero -- Si no puede mover debería pintar de rojo en el lugar en el que está.
pintarRojoAEsteEn n tablero =  pintarRojoAEsteEn (n-1) (mover Este t)-- Decrece n en 1 y mueve al este en el tablero dado.



pintarColumna :: Color -> Tablero -> Tablero   -- El cabezal esta en el borde Norte.
pintarColumna color tablero = poner
            if puedeMover Sur tablero
            then (mover Sur tablero) poner Rojo tablero
            else poner Rojo tablero