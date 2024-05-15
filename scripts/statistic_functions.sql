/* Скрипты подсчёта статистических величин */
CREATE OR REPLACE FUNCTION dealer_revenue(dealer_id int, date_part int, mode text) RETURNS int

AS $$
BEGIN
IF mode != 'month' AND mode != 'year' THEN
	RAISE EXCEPTION 'Incorrect date mode!';
END IF;
RETURN (select sum(price) FROM (deal JOIN vehicle ON deal.vehicle_fkey = vehicle.id) WHERE dealer_id = dealer_fkey AND DATE_PART(mode, date::date) = date_part); 
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION yearly_dealer_revenue(dealer_id int, year int) RETURNS int
AS $$
BEGIN
RETURN dealer_revenue(dealer_id, year, 'year');
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION monthly_dealer_revenue(dealer_id int, month int) RETURNS int 
AS $$
BEGIN
RETURN dealer_revenue(dealer_id, month, 'month');
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION service_revenue(service_id int, date_part int, mode text) RETURNS int
AS $$
BEGIN
IF mode != 'month' AND mode != 'year' THEN
	RAISE EXCEPTION 'Incorrect date mode!';
END IF;

/* временная таблица, хранящая сервисные коэффициенты для каждого ТС */
CREATE TEMP TABLE vehicle_quotient AS SELECT vehicle_fkey, service_quotient FROM
((repair JOIN vehicle ON vehicle.id = vehicle_fkey) JOIN model on model.id = model_fkey);

/* таблица для получения сервиса, в котором производилось обслуживание */
CREATE TEMP TABLE vehicle_service AS SELECT mechanic_fkey, service_fkey FROM
(repair JOIN mechanic ON mechanic.id = mechanic_fkey);

RETURN (select sum(operation.base_price * vehicle_quotient.service_quotient) FROM 
(((repair JOIN vehicle_quotient ON repair.vehicle_fkey = vehicle_quotient.vehicle_fkey) JOIN vehicle_service 
ON repair.mechanic_fkey = vehicle_service.mechanic_fkey) JOIN operation ON operation.id = operation_fkey)
WHERE service_fkey = service_id AND DATE_PART(mode, date::date) = date_part);
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION yearly_service_revenue(service_id int, year int) RETURNS int
AS $$
BEGIN
RETURN service_revenue(service_id, year, 'year');
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION monthly_service_revenue(service_id int, month int) RETURNS int
AS $$
BEGIN
RETURN service_revenue(service_id, month, 'month');
END
$$ LANGUAGE plpgsql;
