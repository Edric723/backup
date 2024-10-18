-- TAD Busqueda
    -- # prod = P
    -- # Filtros = F
    -- # maxAtributos = A

-- TAD Filtro


-- 1

siguientesN :: Busqueda -> 


-- 2 INVARIANTES

data Busqueda = B ( Map String (Map String Int))
[Filtro]

-- todos los productos de mapProd tienen todos sus atributos cumpliendo todos los filtros.
-- 



-- 3

registrar :: String -> Int -> Map String Int -> Busqueda -> Busqueda

 1 - Ver si el producto existe en la busqueda, si existe no hago nada. Devuelvo la misma busqueda.
 2 - Si no existe, debo verificar que cumpla todos los filtros si cumple devuelvo la misma busqueda, sino lo agrego.

Yo quiero registrar un producto con un precio y con atributos en una busqueda = if existeProd prod busq then busq else agregarSi prod precio atr busq

existeProd :: String -> Busqueda -> Bool
existeProd prod (B mapProd _ ) = case lookupM prod mapProd of 
                                    nothing False
                                    Just True
O lop p porque lookupM es logaritmica

agregarSi :: String -> Int - Map String Int -> Busqueda -> Busqueda -- F * Log a + log p
agregarSi prod precio atr (B mapProd Fs)  = If cumpleTodos then "agrega" (assocM prod atrComp mapProd) Fs else B mapProd Fs

let atribCompl = assocM "precio"  precio atr in

O Log A

cumpleTodos :: Map -> String Int ->  Fs -> Bool  -- F * Log A
cumpleTodos _ [] True
cumpleTodos m [F : FS] = aplica F m && cumpletodos m Fs

O Log A * F

filtrar :: Filtro -> Busqueda -> Busqueda
filtrar F (B mapProd Fs) = B (aplicarFiltro F mapProd) keys mapprod (F:FS)


aplicarFiltro :: Filtro -> Map String (Map String Int) -> [String] -> Map String (Map String Int)  -- O P * (log A + Log P) 
aplicarFiltro F _ [] = emptyM 
aplicarFiltro F m (p:ps) = let atr = fromJust (lookupM p m) in  
                            if aplicaF atr -- O Log A
                            then assocM p atr (aplicarFiltro F m ps) -- O Log p
                            else aplicarFiltro F m ps