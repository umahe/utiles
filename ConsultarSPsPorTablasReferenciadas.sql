--VERSION 1

DECLARE @Tablas TABLE (Esquema NVARCHAR(128), NombreTabla NVARCHAR(128));
INSERT INTO @Tablas (Esquema, NombreTabla)
VALUES 
    ('IT', 'usuarios'), 
    ('Sales', 'clientes'), 
    ('Inventory', 'productos'); -- Añade aquí los esquemas y nombres de las tablas

SELECT 
    o.name AS ProcedureName,
    m.definition AS ProcedureDefinition
FROM 
    sys.sql_modules AS m
INNER JOIN 
    sys.objects AS o ON m.object_id = o.object_id
WHERE 
    o.type = 'P'
    AND EXISTS (
        SELECT 1
        FROM @Tablas t
        WHERE m.definition LIKE '%' + t.Esquema + '.' + t.NombreTabla + '%'
    );


--VERSION 2

DECLARE @Tablas TABLE (Esquema NVARCHAR(128), NombreTabla NVARCHAR(128));
INSERT INTO @Tablas (Esquema, NombreTabla)
VALUES 
    ('IT', 'usuarios'), 
    ('Sales', 'clientes'), 
    ('Inventory', 'productos'); -- Añade aquí los esquemas y nombres de las tablas

SELECT 
    ROUTINE_NAME, 
    ROUTINE_DEFINITION
FROM 
    INFORMATION_SCHEMA.ROUTINES
WHERE 
    ROUTINE_TYPE = 'PROCEDURE'
    AND EXISTS (
        SELECT 1
        FROM @Tablas t
        WHERE ROUTINE_DEFINITION LIKE '%' + t.Esquema + '.' + t.NombreTabla + '%'
    );