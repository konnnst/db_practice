/* text vs varchar */
/* power -> hp, deleted year column in Model*/
CREATE TABLE IF NOT EXISTS "Dealer" (
	"id" bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	"address" text NOT NULL UNIQUE,
	/* стоит добавить название филиала */
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "Vehicle" (
	"id" bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	"model_fkey" bigint NOT NULL,
	"year" bigint NOT NULL,
	"price" bigint NOT NULL,
	"condition" bigint NOT NULL,
	"color" text NOT NULL,
	"dealer_fkey" bigint NOT NULL,
	"status_fkey" bigint NOT NULL, /* исправить бул на инт на диаграмме*/
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "Model" (
	"id" bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	"name" text NOT NULL,
	"year" bigint NOT NULL,
	"displacement" bigint NOT NULL,
	"power" bigint NOT NULL,
	"brand_fkey" bigint NOT NULL,
	"type_fkey" bigint NOT NULL,
	"service_quotient" double precision NOT NULL,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "Service" (
	"id" bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	"address" text NOT NULL UNIQUE,
	/* добавить поле name */
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "Mechanic" (
	"id" bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	"name" text NOT NULL,
	"new_field" bigint NOT NULL, /* что-то лишнее */
	"service_fkey" bigint NOT NULL,
	"salary" bigint NOT NULL,
	"phone_number" text NOT NULL,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "Operation" (
	"id" bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	"name" text NOT NULL UNIQUE,
	"base_price" bigint NOT NULL,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "ServiceList" (
	"service_fkey" bigint NOT NULL,
	"operation_fkey" bigint NOT NULL
);

CREATE TABLE IF NOT EXISTS "Client" (
	"id" bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	"name" text NOT NULL DEFAULT '100',
	"phone_number" bigint NOT NULL DEFAULT '30',
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "Order" (
	"id" bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	"vehicle_fkey" bigint NOT NULL,
	"mechanic_fkey" bigint NOT NULL,
	"client_fkey" bigint NOT NULL,
	"operation_fkey" bigint NOT NULL,
	"date" date NOT NULL,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "Deal" (
	"id" bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	"vehicle_fkey" bigint NOT NULL,
	"client_fkey" bigint NOT NULL,
	"date" date NOT NULL,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "Status" (
	"id" bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	"status" text NOT NULL UNIQUE,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "VehicleType" (
	"id" bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	"type" text NOT NULL UNIQUE,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "Brand" (
	"id" bigint GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
	"name" bigint NOT NULL,
	"country" bigint NOT NULL,
	"description" bigint NOT NULL,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "MechanicTypeSkills" (
	"mechanic_fkey" bigint NOT NULL,
	"type_fkey" bigint NOT NULL
);

CREATE TABLE IF NOT EXISTS "MechanicBrandSkills" (
	"mechanic_fkey" bigint NOT NULL,
	"brand_fkey" bigint NOT NULL
);


ALTER TABLE "MechanicTypeSkills" ADD CONSTRAINT "fkey_mechanictypeskills_mechanic" FOREIGN KEY ("mechanic_fkey") REFERENCES "Mechanic"("id");
ALTER TABLE "MechanicTypeSkills" ADD CONSTRAINT "fkey_mechanictypeskills_type" FOREIGN KEY ("type_fkey") REFERENCES "VehicleType"("id");

ALTER TABLE "MechanicBrandSkills" ADD CONSTRAINT "fkey_mechanicbrandskills_mechanic" FOREIGN KEY ("mechanic_fkey") REFERENCES "Mechanic"("id");
ALTER TABLE "MechanicBrandSkills" ADD CONSTRAINT "fkey_mechanicbrandskills_brand" FOREIGN KEY ("brand_fkey") REFERENCES "Brand"("id");

ALTER TABLE "Vehicle" ADD CONSTRAINT "fkey_vehicle_model" FOREIGN KEY ("model_fkey") REFERENCES "Model"("id");
ALTER TABLE "Vehicle" ADD CONSTRAINT "fkey_vehicle_dealer" FOREIGN KEY ("dealer_fkey") REFERENCES "Dealer"("id");
ALTER TABLE "Vehicle" ADD CONSTRAINT "fkey_vehicle_status" FOREIGN KEY ("status_fkey") REFERENCES "Status"("id");

ALTER TABLE "Model" ADD CONSTRAINT "fkey_model_brand" FOREIGN KEY ("brand_fkey") REFERENCES "Brand"("id");
ALTER TABLE "Model" ADD CONSTRAINT "fkey_model_type" FOREIGN KEY ("type_fkey") REFERENCES "VehicleType"("id");

ALTER TABLE "Mechanic" ADD CONSTRAINT "fkey_mechanic_service" FOREIGN KEY ("service_fkey") REFERENCES "Service"("id");

ALTER TABLE "ServiceList" ADD CONSTRAINT "fkey_servicelist_service" FOREIGN KEY ("service_fkey") REFERENCES "Service"("id");
ALTER TABLE "ServiceList" ADD CONSTRAINT "fkey_servicelist_operation" FOREIGN KEY ("operation_fkey") REFERENCES "Operation"("id");

ALTER TABLE "Order" ADD CONSTRAINT "fkey_order_vehicle" FOREIGN KEY ("vehicle_fkey") REFERENCES "Vehicle"("id");
ALTER TABLE "Order" ADD CONSTRAINT "fkey_order_mechanic" FOREIGN KEY ("mechanic_fkey") REFERENCES "Mechanic"("id");
ALTER TABLE "Order" ADD CONSTRAINT "fkey_order_client" FOREIGN KEY ("client_fkey") REFERENCES "Client"("id");
ALTER TABLE "Order" ADD CONSTRAINT "fkey_order_operation" FOREIGN KEY ("operation_fkey") REFERENCES "Operation"("id");

ALTER TABLE "Deal" ADD CONSTRAINT "fkey_deal_vehicle" FOREIGN KEY ("vehicle_fkey") REFERENCES "Vehicle"("id");
ALTER TABLE "Deal" ADD CONSTRAINT "fkey_deal_client" FOREIGN KEY ("client_fkey") REFERENCES "Client"("id");
