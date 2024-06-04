INSERT INTO type (type) VALUES 
	('motorcycle'), ('car'), ('scooter'), ('trailer');

INSERT INTO brand (name, country, description) VALUES
	('Honda', 'Japan', 'nice reliable car and bikes manufacturer'),
	('ВАЗ', 'Russia', 'отечественный производитель нестареющей классики и других автомобилей'),
	('Hyundai', 'South Korea', 'korean car manufacturer'),
	('Kawasaki', 'Japan', 'japanese street- and sportbikes manufacturer'),
	('Dodge', 'US', 'american car manufacturer'),
	('Toyota', 'Japan', 'japanese reliable car manufacturer');

INSERT INTO service (address) VALUES
	('Москва'),
	('Санкт-Петербург'),
	('Севастополь');

INSERT INTO dealer (address) VALUES 
	('Москва'),
	('Санкт-Петербург'),
	('Краснодар');

INSERT INTO operation (name, base_price) VALUES
	('Замена масла в двигателе', 2000),
	('Замена резины на одном колесе', 1500),
	('Регулировка зазоров клапанов', 2500),
	('Раскоксовка двигателя', 3500),
	('Замена колёс', 5000);

INSERT INTO status (status) VALUES
	('in stock'),
	('sold'), 
	('unknown');

INSERT INTO client (name, phone_number) VALUES
	('Константин', '89113030888'),
	('Александр', '89111234567'),
	('Станислав', '89247654321');

INSERT INTO mechanic (name, service_fkey, salary, phone_number) VALUES
	('Василий', 2, 50000, '89119876543'),
	('Андрей', 2, 80000, '89113456789'),
	('Даниил', 1, 75000, '89771234567'),
	('Егор', 3, 50000, '88692345678');

INSERT INTO type_skills (mechanic_fkey, type_fkey) VALUES	
	(1, 1),
	(1, 2),
	(1, 3),
	(2, 1),
	(2, 3),
	(3, 1),
	(3, 2),
	(4, 1),
	(4, 3);

INSERT INTO brand_skills (mechanic_fkey, brand_fkey) VALUES
	(1, 1),
	(1, 2),
	(2, 1),
	(2, 2),
	(2, 3),
	(3, 1),
	(3, 2),
	(3, 3),
	(3, 4),
	(3, 5),
	(3, 6),
	(4, 1),
	(4, 4);	

INSERT INTO service_list (service_fkey, operation_fkey) VALUES
	(1, 1),
	(1, 2),
	(1, 3),
	(1, 4),
	(1, 5),
	(2, 1),
	(2, 2),
	(2, 3),
	(3, 1),
	(3, 2);
	

INSERT INTO model (name, displacement, power, brand_fkey, type_fkey, service_quotient) VALUES
	('Honda CB400SF', 400, 53, 1, 1, 0.5),
	('ВАЗ 2101', 1200, 64, 2, 2, 1),
	('Dodge Ram', 5700, 400, 5, 2, 4),
	('Hyundai Solaris', 1600, 122, 3, 2, 1.2),
	('Toyota Mark 2', 3500, 280, 6, 2, 1.5),
	('Лада Веста', 1600, 123, 2, 2, 1);

INSERT INTO vehicle (name, model_fkey, year, price, condition, color, dealer_fkey, status_fkey) VALUES
	('Honda CB400SF Hyper VTEC Spec 2', 1, 2002, 340000, 7, 'black', 2, 2),
	('ВАЗ 2101 Жигули', 2, 1977, 400000, 6, 'blue', 2, 2),
	('Dodge Ram 1500 hemi', 3, 2024, 5000000, 7, 'black', 1, 2),
	('Hyundai Solaris', 4, 2020, 1500000, 8, 'white', NULL, 3),
	('Toyota Mark 2', 5, 1995, 600000, 6, 'white', 3, 1),
	('Hyundai Solaris', 4, 2015, 550000, 6, 'red', 2, 1),
	('Лада Веста', 6, 2019, 700000, 8, 'blue', 1, 1);

INSERT INTO deal (vehicle_fkey, client_fkey, date) VALUES
	(1, 1, '2024-03-04'),
	(2, 2, '2023-06-21'),
	(3, 3, '2023-09-01');

INSERT INTO repair (vehicle_fkey, client_fkey, mechanic_fkey, operation_fkey, date) VALUES
	(1, 1, 1, 1, '2024-03-08'),
	(2, 2, 1, 3, '2023-12-26'),
	(1, 1, 2, 3, '2024-05-11'),
	(3, 3, 3, 5, '2023-12-01');
