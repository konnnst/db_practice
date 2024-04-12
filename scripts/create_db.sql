/* text vs varchar */
/* добавить поле с пробегом в машину */
CREATE TABLE IF NOT EXISTS dealer (
	id bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	address text NOT NULL UNIQUE,
	/* стоит добавить название филиала */
	PRIMARY KEY (id)
);

/* Нот нул убрал */
CREATE TABLE IF NOT EXISTS vehicle (
	id bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	name text NOT NULL,
	model_fkey bigint NOT NULL,
	year bigint NOT NULL,
	price bigint NOT NULL,
	condition bigint NOT NULL,
	color text NOT NULL,
	dealer_fkey bigint,
	status_fkey bigint NOT NULL, /* исправить бул на инт на диаграмме*/
	PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS model (
	id bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	name text NOT NULL,
	displacement bigint NOT NULL,
	power bigint NOT NULL,
	brand_fkey bigint NOT NULL,
	type_fkey bigint NOT NULL,
	service_quotient double precision NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS service (
	id bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	address text NOT NULL UNIQUE,
	/* добавить поле name */
	PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS mechanic (
	id bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	name text NOT NULL,
	service_fkey bigint NOT NULL,
	salary bigint NOT NULL,
	phone_number text NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS operation (
	id bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	name text NOT NULL UNIQUE,
	base_price bigint NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS serviceList (
	service_fkey bigint NOT NULL,
	operation_fkey bigint NOT NULL
);

CREATE TABLE IF NOT EXISTS client (
	id bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	name text NOT NULL,
	phone_number text NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS repair (
	id bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	vehicle_fkey bigint NOT NULL,
	client_fkey bigint NOT NULL,
	mechanic_fkey bigint NOT NULL,
	operation_fkey bigint NOT NULL,
	date date NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS deal (
	id bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	vehicle_fkey bigint NOT NULL,
	client_fkey bigint NOT NULL,
	date date NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS status (
	id bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	status text NOT NULL UNIQUE,
	PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS type (
	id bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	type text NOT NULL UNIQUE,
	PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS brand (
	id bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	name text NOT NULL,
	country text NOT NULL,
	description text,
	PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS type_skills (
	mechanic_fkey bigint NOT NULL,
	type_fkey bigint NOT NULL
);

CREATE TABLE IF NOT EXISTS brand_skills (
	mechanic_fkey bigint NOT NULL,
	brand_fkey bigint NOT NULL
);


ALTER TABLE type_skills ADD CONSTRAINT fkey_mechanictypeskills_mechanic FOREIGN KEY (mechanic_fkey) REFERENCES mechanic(id);
ALTER TABLE type_skills ADD CONSTRAINT fkey_mechanictypeskills_type FOREIGN KEY (type_fkey) REFERENCES type(id);

ALTER TABLE brand_skills ADD CONSTRAINT fkey_mechanicbrandskills_mechanic FOREIGN KEY (mechanic_fkey) REFERENCES mechanic(id);
ALTER TABLE brand_skills ADD CONSTRAINT fkey_mechanicbrandskills_brand FOREIGN KEY (brand_fkey) REFERENCES brand(id);

ALTER TABLE vehicle ADD CONSTRAINT fkey_vehicle_model FOREIGN KEY (model_fkey) REFERENCES model(id);
ALTER TABLE vehicle ADD CONSTRAINT fkey_vehicle_dealer FOREIGN KEY (dealer_fkey) REFERENCES dealer(id);
ALTER TABLE vehicle ADD CONSTRAINT fkey_vehicle_status FOREIGN KEY (status_fkey) REFERENCES status(id);

ALTER TABLE model ADD CONSTRAINT fkey_model_brand FOREIGN KEY (brand_fkey) REFERENCES brand(id);
ALTER TABLE model ADD CONSTRAINT fkey_model_type FOREIGN KEY (type_fkey) REFERENCES type(id);

ALTER TABLE mechanic ADD CONSTRAINT fkey_mechanic_service FOREIGN KEY (service_fkey) REFERENCES service(id);

ALTER TABLE serviceList ADD CONSTRAINT fkey_servicelist_service FOREIGN KEY (service_fkey) REFERENCES Service(id);
ALTER TABLE serviceList ADD CONSTRAINT fkey_servicelist_operation FOREIGN KEY (operation_fkey) REFERENCES operation(id);

ALTER TABLE repair ADD CONSTRAINT fkey_repair_vehicle FOREIGN KEY (vehicle_fkey) REFERENCES vehicle(id);
ALTER TABLE repair ADD CONSTRAINT fkey_repair_mechanic FOREIGN KEY (mechanic_fkey) REFERENCES mechanic(id);
ALTER TABLE repair ADD CONSTRAINT fkey_repair_client FOREIGN KEY (client_fkey) REFERENCES client(id);
ALTER TABLE repair ADD CONSTRAINT fkey_repair_operation FOREIGN KEY (operation_fkey) REFERENCES operation(id);

ALTER TABLE deal ADD CONSTRAINT fkey_deal_vehicle FOREIGN KEY (vehicle_fkey) REFERENCES vehicle(id);
ALTER TABLE deal ADD CONSTRAINT fkey_deal_client FOREIGN KEY (client_fkey) REFERENCES client(id);
