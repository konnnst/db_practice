/* Пользовательские запросы к базе данных */

/* Подсчёт количества механиков, работающих в каждом городе */
SELECT address, count(*) FROM service JOIN mechanic ON service.id = mechanic.service_fkey GROUP BY address;

/* В каких городах смогут провести работы по замене масла в двигателе мотоцикла Honda */
SELECT address FROM service 
JOIN mechanic ON service.id = mechanic.service_fkey
JOIN type_skills ON mechanic.id = type_skills.mechanic_fkey
JOIN type ON type.id = type_skills.type_fkey
JOIN brand_skills ON mechanic.id = brand_skills.mechanic_fkey
JOIN brand ON brand.id = brand_skills.brand_fkey
JOIN service_list ON servicelist.service_fkey = service.id
JOIN operation ON operation.id = service_list.operation_fkey
WHERE brand.name = 'HONda' AND type.type = 'motorcycle' AND operation.name = 'Замена масла в двигателе';

/* Вычислить сумму, потраченную на ремонт каждым из клиентов */
SELECT name, sum(price) FROM
(SELECT client.name, operation.base_price * model.service_quotient AS price FROM client
JOIN repair ON repair.client_fkey = client.id
JOIN vehicle ON vehicle.id = repair.vehicle_fkey
JOIN model ON model.id = vehicle.model_fkey
JOIN operation ON operation.id = repair.operation_fkey)
GROUP BY name;

/* Вычислить сумму, потраченную каждым из клиентов на покупку ТС */
SELECT client.name, sum(price) FROM client
JOIN deal ON client.id = deal.client_fkey
JOIN vehicle ON vehicle.id = deal.vehicle_fkey
GROUP BY client.name;

/* Отобразить суммарную стоимость всех ТС из каждой категории в порядке возрастания стоимости */
SELECT type, sum(price) FROM vehicle
JOIN model ON model.id = vehicle.model_fkey
JOIN type ON type.id = model.type_fkey
GROUP BY type;

/* Суммарная стоимость услуг, оказанная каждым из механиков */	
SELECT mechanic.name, sum(repair_price(repair.id::INT)) FROM mechanic
JOIN repair ON mechanic.id = repair.mechanic_fkey
JOIN operation ON operation.id = repair.operation_fkey
GROUP BY mechanic.name;

/* Отобразить услуги, доступные в сервисе в Санкт-Петербурге */
SELECT name FROM service 
JOIN service_list ON service.id = servicelist.service_fkey
JOIN operation ON operation.id = service_list.operation_fkey
WHERE address = 'Санкт-Петербург';

/* Отобразить количество общее количество услуг и сделок каждого клиента */
SELECT name, count(name) FROM client
JOIN (SELECT client_fkey FROM deal UNION ALL (SELECT client_fkey FROM repair))
ON client.id = client_fkey GROUP BY name;

/* Отобразить навыки механиков по маркам ТС в сервисе Санкт-Петербурга  */
SELECT brand.name FROM
(SELECT * FROM service WHERE address = 'Санкт-Петербург') as service
JOIN mechanic ON service.id = mechanic.service_fkey
JOIN brand_skills ON brand_skills.mechanic_fkey = mechanic.id
JOIN brand ON brand.id = brand_skills.brand_fkey
GROUP BY brand.name;

/*  Отобразить все ТС дороже 350000 рублей, отсортировав их по возрастанию цены */
SELECT * FROM vehicle WHERE price > 350000 ORDER BY price;

/* Отобразить самое дорогое ТС */
SELECT vehicle.name FROM vehicle WHERE price >= ALL(select price FROM vehicle)

/*  Отобразить российсские машины новее 2000 года (с использованием т.-мн. операций)*/
SELECT * FROM
(SELECT * FROM vehicle JOIN model ON model.id = vehicle.model_fkey JOIN brand ON brand.id = model.brand_fkey  WHERE country = 'Russia')
EXCEPT
(SELECT * FROM vehicle JOIN model ON model.id = vehicle.model_fkey JOIN brand ON brand.id = model.brand_fkey WHERE vehicle.year < 2000);

/* Отобразить модели машин с названием марки, начинающимся на "H" */
SELECT model.name FROM model
JOIN brand ON brand.id = model.brand_fkey
WHERE brand.name LIKE 'H%';

/* Отобразить список машин и их владельцев */
SELECT vehicle.name, client_deal.name FROM vehicle 
LEFT JOIN (client JOIN deal ON deal.client_fkey = client.id) AS client_deal
ON client_deal.vehicle_fkey = vehicle.id;

