-- ======================================= AUDITORIA =============================================


SELECT * FROM audit.logged_actions;

CREATE SCHEMA audit;

CREATE TABLE audit.logged_actions (
    SCHEMA_NAME text NOT null,
    TABLE_NAME text NOT null,
    user_name text,
    action_tstamp timestamp WITH time zone NOT null DEFAULT CURRENT_TIMESTAMP,
    ACTION TEXT NOT NULL CHECK (ACTION IN ('I','D','U')),
    original_data text,
    new_data text,
    QUERY text
) WITH (fillfactor=100);


GRANT SELECT ON audit.logged_actions TO PUBLIC;

CREATE INDEX logged_actions_schema_table_idx 
ON audit.logged_actions(((SCHEMA_NAME||'.'||TABLE_NAME)::TEXT));

CREATE INDEX logged_actions_action_tstamp_idx 
ON audit.logged_actions(action_tstamp);

CREATE INDEX  logged_actions_action_idx 
ON audit.logged_actions(action);



CREATE OR REPLACE FUNCTION audit.if_modified_func() RETURNS trigger AS $body$
DECLARE
    v_old_data TEXT;
    v_new_data TEXT;
BEGIN
   
    if (TG_OP = 'UPDATE') then
        v_old_data := ROW(OLD.*);
        v_new_data := ROW(NEW.*);
        insert into audit.logged_actions (schema_name,table_name,user_name,action,original_data,new_data,query) 
        values (TG_TABLE_SCHEMA::TEXT,TG_TABLE_NAME::TEXT,session_user::TEXT,substring(TG_OP,1,1),v_old_data,v_new_data, current_query());
        RETURN NEW;
    elsif (TG_OP = 'DELETE') then
        v_old_data := ROW(OLD.*);
        insert into audit.logged_actions (schema_name,table_name,user_name,action,original_data,query)
        values (TG_TABLE_SCHEMA::TEXT,TG_TABLE_NAME::TEXT,session_user::TEXT,substring(TG_OP,1,1),v_old_data, current_query());
        RETURN OLD;
    elsif (TG_OP = 'INSERT') then
        v_new_data := ROW(NEW.*);
        insert into audit.logged_actions (schema_name,table_name,user_name,action,new_data,query)
        values (TG_TABLE_SCHEMA::TEXT,TG_TABLE_NAME::TEXT,session_user::TEXT,substring(TG_OP,1,1),v_new_data, current_query());
        RETURN NEW;
    else
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - Other action occurred: %, at %',TG_OP,now();
        RETURN NULL;
    end if;

EXCEPTION
    WHEN data_exception THEN
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - UDF ERROR [DATA EXCEPTION] - SQLSTATE: %, SQLERRM: %',SQLSTATE,SQLERRM;
        RETURN NULL;
    WHEN unique_violation THEN
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - UDF ERROR [UNIQUE] - SQLSTATE: %, SQLERRM: %',SQLSTATE,SQLERRM;
        RETURN NULL;
    WHEN others THEN
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - UDF ERROR [OTHER] - SQLSTATE: %, SQLERRM: %',SQLSTATE,SQLERRM;
        RETURN NULL;
END;
$body$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = pg_catalog, audit;


CREATE TRIGGER tablename_audit
AFTER INSERT OR UPDATE OR DELETE ON humanresources.employee 
FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();

CREATE TRIGGER tablename_audit
AFTER INSERT OR UPDATE OR DELETE ON humanresources.employeepayhistory 
FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();

CREATE TRIGGER tablename_audit
AFTER INSERT OR UPDATE OR DELETE ON sales.salesperson 
FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
 
CREATE TRIGGER tablename_audit
AFTER INSERT OR UPDATE OR DELETE ON  purchasing.vendor 
FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();

CREATE TRIGGER tablename_audit
AFTER INSERT OR UPDATE OR DELETE ON production.product
FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();

CREATE TRIGGER tablename_audit
AFTER INSERT OR UPDATE OR DELETE ON person.person
FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();

CREATE TRIGGER tablename_audit
AFTER INSERT OR UPDATE OR DELETE ON person.businessentity
FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();
