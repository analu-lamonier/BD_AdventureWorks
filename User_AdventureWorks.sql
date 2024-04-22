-- ======================================= USERS =============================================

-- CEO
CREATE USER ceo 
	WITH PASSWORD 'senhaceo';

-- SETOR RH

CREATE USER coordenador_rh 
	WITH PASSWORD 'senhacoordenador_rh';
CREATE USER analista_rh  
	WITH PASSWORD 'senhaanalista_rh';
CREATE USER estagiario_rh 
	WITH PASSWORD 'senhaestagiario_rh';	

-- SETOR VENDAS

CREATE USER coordenador_vendas
	WITH PASSWORD 'senhacoordenador_vendas';
ALTER USER vendedor
	WITH PASSWORD 'senhavendedor';
CREATE USER estagiario_vendedor 
	WITH PASSWORD 'senhaestagiario_vendedor';
	
-- SETOR COMPRAS 	
	
CREATE USER coordenador_compras 
	WITH PASSWORD 'senhacoordenador_compras';
CREATE USER comprador  
	WITH PASSWORD 'senhacomprador';
CREATE USER estagiario_comprador 
	WITH PASSWORD 'senhaestagiario_comprador';
	
-- SETOR PRODUÇÃO 

CREATE USER coordenador_producao 
	WITH PASSWORD 'senhacoordenador_producao'
CREATE USER produtor 
	WITH PASSWORD 'senhaprodutor'
CREATE USER estagiario_producao
	WITH PASSWORD 'senhaestagiario_producao'
	
-- SETOR PESSOAS

CREATE USER	gerente_pessoas 
	WITH PASSWORD 'senhagerente_pessoas'        
CREATE USER estagiario_pessoas     
	WITH PASSWORD 'senhaestagiario_pessoas'
	
-------------------------------------------- CRIANDO GRUPOS -----------------------------

CREATE GROUP setor_rh;
ALTER GROUP setor_rh ADD USER coordenador_rh, analista_rh, estagiario_rh;

CREATE GROUP setor_vendas;
ALTER GROUP setor_vendas ADD USER coordenador_vendas, vendedor, estagiario_vendedor;

CREATE GROUP setor_compras;
ALTER GROUP setor_compras ADD USER coordenador_compras, comprador, estagiario_comprador;
	
CREATE GROUP setor_producao;
ALTER GROUP setor_producao ADD USER coordenador_producao, produtor, estagiario_producao;	

CREATE GROUP setor_pessoas;
ALTER GROUP setor_pessoas ADD USER gerente_pessoas, estagiario_pessoas;	
	
	
-------------------------------------------- PERMISSÕES ---------------------- 
	
-- CEO 
GRANT ALL PRIVILEGES ON SCHEMA humanresources, sales, purchasing, production, person, person
TO ceo WITH GRANT OPTION;


-- 	SETOR RH
GRANT ALL PRIVILEGES ON SCHEMA humanresources TO coordenador_rh WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON humanresources.employee, humanresources.jobcandidate, humanresources.employeepayhistory TO analista_rh ;
GRANT SELECT ON humanresources.employee, humanresources.jobcandidate, humanresources.employeepayhistory TO estagiario_rh;	


-- SETOR VENDAS
GRANT ALL PRIVILEGES ON SCHEMA sales TO coordenador_vendas WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON sales.Customer, sales.SalesOrderHeader, sales.SalesPerson TO vendedor;
GRANT SELECT ON sales.Customer, sales.SalesOrderHeader, sales.SalesPerson TO estagiario_vendedor;	

-- SETOR COMPRAS
GRANT ALL PRIVILEGES ON SCHEMA purchasing TO coordenador_compras WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON purchasing.purchaseorderheader, purchasing.vendor TO comprador;
GRANT SELECT ON purchasing.purchaseorderheader, purchasing.vendor TO estagiario_comprador;	


-- SETOR PRODUÇÃO
GRANT ALL PRIVILEGES ON SCHEMA production TO coordenador_producao WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON production.product, production.billofmaterials TO produtor;
GRANT SELECT ON production.product, production.billofmaterials TO estagiario_producao;	


-- SETOR PESSOAS
GRANT ALL PRIVILEGES ON SCHEMA person TO gerente_pessoas WITH GRANT OPTION;
GRANT SELECT ON person.person, person.emailaddress, person.businessentity  TO estagiario_pessoas;









