/* Скрипты добавления основных сущностей */
CREATE OR REPLACE PROCEDURE add_client(name text, phone_number text)
LANGUAGE SQL AS
$$
INSERT INTO client (name, phone_number) VALUES (add_client.name, add_client.phone_number)
$$;


CREATE OR REPLACE PROCEDURE 
add_vehicle(name text, model int, year int, price int, condition int, color text, dealer int, status int)
LANGUAGE SQL AS
$$
INSERT INTO vehicle (name, model_fkey, year, price, condition, color, dealer_fkey, status_fkey) VALUES
(add_vehicle.name, model, add_vehicle.year, add_vehicle.price, 
add_vehicle.condition, add_vehicle.color, dealer, status)
$$;

CREATE OR REPLACE PROCEDURE add_model(name text, displacement int, power int, brand int, type int, quotient double)
LANGUAGE SQL AS
$$
INSERT INTO model (name, displacement, power, brand, type, quotient) VALUES
(add_model.name, add_model.displacement, add_model.power, brand, type, quotient) 
$$;

CREATE OR REPLACE PROCEDURE add_deal(vehicle int, client int, date date)
LANGUAGE SQL AS
$$
INSERT INTO deal (vehicle_fkey, client_fkey, date) VALUES
(vehicle, client, add_deal.date)
$$;

CREATE OR REPLACE PROCEDURE add_repair(vehicle int, client int, mechanic int, operation int, date date)
LANGUAGE SQL AS
$$
INSERT INTO repair (vehicle_fkey, client_fkey, mechanic_fkey, operation_fkey, date) VALUES
(vehicle, client, mechanic, operation, date)
$$;

