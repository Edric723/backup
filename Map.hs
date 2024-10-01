module Map (Map, emptyM assocM, lookupM)

where

data Map key value = M [(k,v)]


-- Propósito: Devuelve un map vacío.
emptyM :: Map k v
emptyM = M []


-- Propósito: Agrega una asociación clave-valor al map.
assocM :: Eq k => k -> v -> Map k v -> Map k v
assocM k v []            = [(k,v)]
assocM k v ((k',v'):kvs) =  
                            if k==k' belongs
                            then (k',v):kvs 
                            else (k', v') : assocM k v kvs



-- Propósito: Encuentra un valor dado una clave.
-- Describe el valor asociado a la clave dada, si no existe debe devolver nothing.
lookupM :: Ord k => k -> Map k v -> Maybe v
lookupM :: Eq k => k -> [(k,v)] -> Maybe v
lookupM k []            = Nothing
lookupM k ((k',v'):kvs) =                               -- Busca la clave, si k es igual a la primer k (k') del primer clave valor Devuelve v, sino sigue buscando. Recursión
                            if k==k' 
                            then Just v' 
                            else lookupM k kvs



