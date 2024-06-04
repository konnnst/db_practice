/* Скрипты удаления основных сущностей */
CREATE OR REPLACE PROCEDURE delete_client(del_id int)
LANGUAGE SQL AS
$$
DELETE FROM repair WHERE client_fkey = del_id;
DELETE FROM deal WHERE client_fkey = del_id;
DELETE FROM client WHERE client.id = del_id;
$$;


CREATE OR REPLACE PROCEDURE 
delete_vehicle(del_id int)
LANGUAGE SQL AS
$$
DELETE FROM repair WHERE vehicle_fkey = del_id;
DELETE FROM deal WHERE vehicle_fkey = del_id;
DELETE FROM vehicle WHERE vehicle.id = del_id;
$$;

CREATE OR REPLACE PROCEDURE delete_deal(del_id int)
LANGUAGE SQL AS
$$
DELETE FROM deal WHERE deal.id = del_id;
$$;

CREATE OR REPLACE PROCEDURE delete_repair(del_id int)
LANGUAGE SQL AS
$$
DELETE FROM repair WHERE repair.id = del_id;
$$;


