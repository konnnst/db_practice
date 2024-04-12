INSERT INTO "VehicleType" (type) VALUES 
	("motorcycle"), ("car"), ("scooter"), ("trailer");

INSERT INTO "Brand" (name, country, description) VALUES
	("Honda", "Japan", "nice reliable car and bikes manufacturer"),
	("ВАЗ", "Russia", "отечественный производитель нестареющей классики и других автомобилей"),
	("Hyundai", "South Korea"),
	("Kawasaki", "Japan", "japanese street- and sportbikes manufacturer");

INSERT INTO "Service" (address) VALUES
	("Москва"),
	("Санкт-Петербург"),
	("Севастополь");

INSERT INTO "Dealer" (address) VALUES 
	("Москва"),
	("Санкт-Петербург"),
	("Краснодар");

INSERT INTO "Operation" (name, base_price) VALUES
	("Замена масла в двигателе", 2000),
	("Замена резины на одном колесе", 1500),
	("Регулировка зазоров клапанов", 2500),
	("Раскоксовка двигателя", 3500);

INSERT INTO "Status" (status) VALUES
	("in stock"),
	("sold"), 
	("unknown");

INSERT INTO "Client" (name, phone_number) VALUES
	("Константин", "89113030888"),
	("Александр", "89111234567"),
	("Станислав", "89247654321");

INSERT INTO "Mechanic" (name, service_key, salary, phone_number) VALUES
	("Василий", 2, 50000, "89119876543"),
	("Андрей", 2, 80000, "89113456789"),
	("Даниил", 1, 75000, "89771234567"),
	("Егор", 3, 50000, "88692345678");

INSERT INTO "MechanicTypeSkills" (mechanic_fkey, type_fkey) VALUES	
	(1, 1),
	(1, 2),
	(1, 3),
	(2, 1),
	(3, 1),
	(3, 2),
	(4, 1),
	(4, 3);

INSERT INTO "MechanicBrandSkills" (mechanic_fkey, brand_fkey) VALUES
	(1, 1),
	(1, 2),
	(2, 1),
	(2, 2),
	(2, 3),
	(3, 1),
	(3, 2),
	(3, 3),
	(3, 4),
	(4, 1),
	(4, 4);	

INSERT INTO "Model" (name, year, displacement, hp, brand_fkey, type_fkey, service_quotient) VALUES
	("Honda CB400SF", 400, 53, 1, 1, 0.5),
	("ВАЗ 2101", 1200, 64, 2, 2, 1),
	("Hyundai Solaris", 1600, 122, 3, 2, 1.2);

INSERT INTO "Vehicle" (name, model_fkey, year, price, condition, color, dealer_fkey, status_fkey) VALUES
	("Honda CB400SF Hyper VTEC Spec 2", 1, 2002, 340000, 7, "black", 2, 2),
	("ВАЗ 2101 Жигули", 2, 1977, 400000, 6, "blue", 2, 1);
	("Hyundai Solaris", 3, 2020, 1500000, 8, "white", NULL, 3),
	("");
