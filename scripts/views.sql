/* Представление, выводящее подробную информацию о всех мотоциклах */
CREATE OR REPLACE VIEW motorcycle_v AS
SELECT vehicle.id, vehicle.name, model_fkey, year, price, condition, dealer_fkey, status_fkey
FROM vehicle
JOIN model on vehicle.model_fkey = model.id
JOIN type ON model.type_fkey = type.id
WHERE type.type = 'motorcycle';

/* Представление, выводящее подробную информацию о всех мотоциклах */
CREATE OR REPLACE VIEW car_v AS
SELECT vehicle.id, vehicle.name, model_fkey, year, price, condition, dealer_fkey, status_fkey
FROM vehicle
JOIN model on vehicle.model_fkey = model.id
JOIN type ON model.type_fkey = type.id
WHERE type.type = 'car';

/* Представление, выводящее подробную информацию о всех мотоциклах */
CREATE OR REPLACE VIEW scooter_v AS
SELECT vehicle.id, vehicle.name, model_fkey, year, price, condition, dealer_fkey, status_fkey
FROM vehicle
JOIN model on vehicle.model_fkey = model.id
JOIN type ON model.type_fkey = type.id
WHERE type.type = 'scooter';

/* Представление, выводящее информацию о ремонте, включая информацию о конкретной услуге */
CREATE OR REPLACE VIEW repair_operation_v AS
SELECT repair.id, vehicle_fkey, client_fkey, date, name, base_price FROM repair
JOIN operation ON operation.id = repair.operation_fkey; 

