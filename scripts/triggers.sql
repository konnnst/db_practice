/* Триггеры базы данных */


/* Изменение статуса автомобиля при совершении на него сделки (операция добавления в deal), если в наличии, иначе -- отмена операции */
CREATE OR REPLACE FUNCTION change_status() RETURNS trigger
AS $$
DECLARE status TEXT;
BEGIN
SELECT status.status INTO status FROM (SELECT * FROM vehicle WHERE vehicle.id = NEW.vehicle_fkey) as now_vehicle JOIN status ON status.id = now_vehicle.status_fkey;
IF status <> 'in stock' THEN
	RAISE EXCEPTION 'Vehicle is not in stock';
END IF;
UPDATE vehicle SET status_fkey = 2 WHERE id = NEW.vehicle_fkey;
RETURN NEW;
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER change_status_tr BEFORE INSERT ON deal
FOR EACH ROW EXECUTE PROCEDURE change_status();

/* Проверка корректности даты относительно сегодняшней */
CREATE OR REPLACE FUNCTION check_date() RETURNS trigger
AS $$
DECLARE status TEXT;
BEGIN
IF NEW.date > NOW() THEN
	RAISE EXCEPTION 'Incorrect date';
END IF;
RETURN NEW;
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER check_date_deal_tr BEFORE INSERT ON deal
FOR EACH ROW EXECUTE PROCEDURE check_date();

CREATE OR REPLACE TRIGGER check_date_repair_tr BEFORE INSERT ON repair 
FOR EACH ROW EXECUTE PROCEDURE check_date();
