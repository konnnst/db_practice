CREATE OR REPLACE FUNCTION repair_price(repair_id int)
RETURNS INT 
AS
$$
DECLARE price INT;
BEGIN
SELECT floor(operation.base_price * service_quotient)::INT INTO price FROM (SELECT * FROM repair WHERE id = repair_id) AS repair JOIN vehicle ON vehicle.id = repair.vehicle_fkey JOIN model ON model.id = vehicle.model_fkey JOIN operation ON operation.id = repair.operation_fkey;
RETURN price;
END
$$ LANGUAGE plpgsql;
