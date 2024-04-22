/*=================================== UNIVERSIDADE FEDERAL DE UBERLÂNDIA ============================================= --
											ENGENHARIA DE COMPUTAÇÃO




 												BANCO DE DADOS

										   APRESENTAÇÃO PROJETO FINAL

			
			




 ALUNOS:
 		Ana Luiza F. Lamonier
		João Pedro Caixeta
		Samuel Andrade
			
 BASE DE DADOS UTILIZADA: 
 		Adventure Works
 
=============================================== UBERLÂNDIA 2024 ===================================================== --*/



----------------------------------------------- CRIANDO USUÁRIOS --------------------------------------------------------


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
	
------------------------------------------------ CRIANDO GRUPOS ----------------------------------------------------------

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

-------------------------------- CONCEDENDO AS PERMISSÕES AOS CARGOS SUPERIORES --------------------------------------------


GRANT ALL PRIVILEGES ON SCHEMA humanresources, sales, purchasing, production, person, person
TO ceo WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON SCHEMA humanresources TO coordenador_rh WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON SCHEMA sales TO coordenador_vendas WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON SCHEMA purchasing TO coordenador_compras WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON SCHEMA production TO coordenador_producao WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON SCHEMA person TO gerente_pessoas WITH GRANT OPTION;


----------------------------------- TESTANDO AS PERMISSÕES E OS COMANDOS CRUD --------------------------------------------


									/************** SETOR RH **************/

-- Fazer login no usuário coordenador_rh
-- PASSWORD 'senhacoordenador_rh'

-- Dar privilégio para o usuário analista_rh
	GRANT ALL ON SCHEMA humanresources TO analista_rh;
	GRANT SELECT, INSERT, UPDATE, DELETE ON humanresources.employee, humanresources.jobcandidate, humanresources.employeepayhistory 
	TO analista_rh ;

-- Dar privilégio para o usuário estagiario_rh 
	GRANT ALL ON SCHEMA humanresources TO estagiario_rh;	
	GRANT SELECT ON humanresources.employee, humanresources.jobcandidate, humanresources.employeepayhistory 
	TO estagiario_rh;
	
	-- Testar comandos RUD:

	INSERT INTO humanresources.employeepayhistory (
		businessentityid, ratechangedate, rate, payfrequency)
	VALUES (505, '2022-04-21 08:00:00', 15.00, 1);
	
	UPDATE humanresources.employeepayhistory SET rate = '20', ratechangedate = CURRENT_TIMESTAMP 
            WHERE businessentityid = 505;
			
	DELETE FROM humanresources.employeepayhistory 
            WHERE businessentityid = 505;

	SELECT * FROM humanresources.employeepayhistory
	WHERE businessentityid in (505, 50);
	
	
-- Fazer login no usuário analista_rh
-- Password: senhaanalista_rh

	-- Testar comandos RUD:

	INSERT INTO humanresources.employee (
			businessentityid, nationalidnumber, loginid, jobtitle, birthdate, maritalstatus, 
			gender, hiredate, salariedflag, vacationhours, sickleavehours, currentflag, organizationnode)
			VALUES (
			291, '987654421', 'jane_smita',  'RH GERENTE', '1985-08-20', 'S',
			'F', '2010-10-10', true, 80, 20, true, '/Company B/');

	UPDATE humanresources.employee SET jobtitle = 'RH CHEFE', vacationhours = 100, modifieddate = CURRENT_TIMESTAMP
	WHERE businessentityid = 291;
	
	SELECT * FROM humanresources.employee
	WHERE businessentityid IN (505, 50);
	
	DELETE FROM humanresources.employee 
	WHERE businessentityid = 291;
	

-- Fazer login no usuário estagiario_rh
-- PASSWORD: senhaestagiario_rh

-- Testar os comandos RUD acima
-- Note que não são possíveis, apenas o comando select


									/************** SETOR VENDAS **************/
									

-- Fazer login no usuário coordenador_vendas
-- Password: senhacoordenador_vendas

-- Dar privilégio para o usuário vendedor
	GRANT ALL ON SCHEMA sales TO vendedor;
	GRANT SELECT, INSERT, UPDATE, DELETE ON sales.Customer, sales.SalesOrderHeader, sales.SalesPerson 
	TO vendedor;

-- Dar privilégio para o usuário estagiario_vendedor
	GRANT ALL ON SCHEMA sales TO estagiario_vendedor;
	GRANT SELECT ON sales.Customer, sales.SalesOrderHeader, sales.SalesPerson 
	TO estagiario_vendedor;	
	
-- Fazer login no usuário vendedor
-- Password: senhavendedor

	-- Testar comandos RUD:

	INSERT INTO sales.salesperson (
		businessentityid, territoryid, salesquota, bonus, commissionpct, salesytd, saleslastyear) 
	VALUES (
		505, 10, 1000000.00, 5000.00, 0.05, 250000.00, 2000000.00);
	
	UPDATE sales.salesperson SET commissionpct = 0.06, modifieddate = CURRENT_TIMESTAMP
            WHERE businessentityid = 505;
			
	SELECT * FROM sales.salesperson
	WHERE businessentityid in (505, 50);
	
	DELETE FROM sales.salesperson 
	WHERE businessentityid = 505;

-- Fazer login no usuário estagiario_vendedor
-- Password: senhaestagiario_vendedor

-- Testar os comandos RUD acima
-- Note que não são possíveis, apenas o comando select



									/************** SETOR COMPRAS **************/
									

-- Fazer login no usuário coordenador_compras
-- Password: senhacoordenador_compras


-- Dar privilégio para o usuário comprador
	GRANT ALL ON SCHEMA purchasing TO comprador;
	GRANT SELECT, INSERT, UPDATE, DELETE ON purchasing.purchaseorderheader, purchasing.vendor 
	TO comprador;

-- Dar privilégio para o usuário estagiario_comprador
	GRANT ALL ON SCHEMA purchasing TO estagiario_comprador;
	GRANT SELECT ON purchasing.purchaseorderheader, purchasing.vendor 
	TO estagiario_comprador;	


-- Fazer login no usuário comprador
-- Password: senhacomprador

	-- Testar comandos RUD:
	
	INSERT INTO purchasing.vendor (businessentityid, accountnumber, name, creditrating, preferredvendorstatus, activeflag, purchasingwebserviceurl) 
	VALUES (600, '123456', 'Fornecedor topzera', 4, true, true, 'http://www.fornecedor.com');
	
	UPDATE purchasing.vendor SET creditrating = 5, modifieddate = CURRENT_TIMESTAMP
            WHERE businessentityid = 600;
	--'1 = Superior, 2 = Excellent, 3 = Above average, 4 = Average, 5 = Below average';		
	
	SELECT * FROM purchasing.vendor
	WHERE businessentityid in (600, 50);
	
	DELETE FROM purchasing.vendor 
	WHERE businessentityid = 600;
	
-- Fazer login no usuário estagiario_comprador
-- Password: senhaestagiario_comprador
	
-- Testar os comandos RUD acima
-- Note que não são possíveis, apenas o comando select



									/************** SETOR PRODUÇÃO **************/
									

-- Fazer login no usuário coordenador_producao
-- Password: senhacoordenador_producao


-- Dar privilégio para o usuário produtor
	GRANT ALL ON SCHEMA production TO produtor;
	GRANT SELECT, INSERT, UPDATE, DELETE ON production.product, production.billofmaterials 
	TO produtor;


-- Dar privilégio para o usuário estagiario_producao
	GRANT ALL ON SCHEMA production TO estagiario_producao;
	GRANT SELECT ON production.product, production.billofmaterials 
	TO estagiario_producao;	


-- Fazer login no usuário produtor
-- Password: senhaprodutor

	-- Testar comandos RUD:

	INSERT INTO production.product (
		productid, name, productnumber, makeflag, finishedgoodsflag, color, safetystocklevel, reorderpoint, 
		standardcost, listprice, size,sizeunitmeasurecode, weightunitmeasurecode, weight, daystomanufacture, 
		productline, class, style, productsubcategoryid, productmodelid, sellstartdate, sellenddate, discontinueddate) 
	VALUES (500,'Garrafa de agua', 'BK-M82B-42', true, true, 'Black',100,75,
			500,75.00,'1','L','G',50,1,
			'M','M','U', 32, 19, '2008-04-01', NULL, NULL);
		
	UPDATE production.product 
	SET name = 'Garrafa de água', 
		color = 'Red', 
		listprice = 69.00, 
		modifieddate = CURRENT_TIMESTAMP 
	WHERE productid = 500;

	SELECT * FROM production.product
	WHERE productid in (500, 1);
	
	DELETE FROM production.product 
	WHERE productid = 500;


-- Fazer login no usuário estagiario_producao
-- Password: senhaestagiario_producao
	
-- Testar os comandos RUD acima
-- Note que não são possíveis, apenas o comando select


									/************** SETOR PESSOAS **************/


-- Fazer login no usuário gerente_pessoas
-- Password: senhagerente_pessoas


-- Dar privilégio para o usuário estagiario_pessoas
	GRANT ALL ON SCHEMA person TO estagiario_pessoas;
	GRANT SELECT ON person.person, person.emailaddress, person.businessentity 
	TO estagiario_pessoas;


	-- Testar comandos RUD:

	INSERT INTO person.businessentity (businessentityid)
	VALUES(20779);

	INSERT INTO person.person (
		businessentityid, persontype, namestyle, title, firstname, middlename, lastname, suffix, emailpromotion, additionalcontactinfo, demographics)
	VALUES(
		20779, 'IN', false, 'Sra.', 'Ana', 'M', 'Silva', NULL, 1, NULL, NULL);
			-- 0 = Contact does not wish to receive e-mail promotions, ]
			-- 1 = Contact does wish to receive e-mail promotions from AdventureWorks
			-- 2 = Contact does wish to receive e-mail promotions from AdventureWorks and selected partners.
  
 	SELECT * FROM person.person
 	WHERE businessentityid = 20779;
  
	UPDATE person.person 
	SET emailpromotion = 0 
		modifieddate = CURRENT_TIMESTAMP 
	WHERE businessentityid = 20779;
	
	DELETE FROM person.person 
	WHERE businessentityid = 20779;

-- Fazer login no usuário estagiario_pessoas
-- Password: senhaestagiario_pessoas
	
-- Testar os comandos RUD acima
-- Note que não são possíveis, apenas o comando select


-- ======================================= AUDITORIA =============================================

-- Fazer login no usuário postgres


	SELECT * FROM audit.logged_actions;
	
	SELECT * FROM audit.logged_actions WHERE schema_name = 'humanresources';

	SELECT * FROM audit.logged_actions WHERE schema_name = 'person';

	SELECT * FROM audit.logged_actions WHERE schema_name = 'production';

	SELECT * FROM audit.logged_actions WHERE schema_name = 'purchasing';

	SELECT * FROM audit.logged_actions WHERE schema_name = 'sales';



-- ======================================= VIEWS =============================================

-- Apenas o CEO pode executar todos - apenas ele tem acesso à todos os schemas 

-- Fazer login no usuário ceo
-- Password: senhaceo


	-- VIEW pessoas que desejam receber email da adventure works e seus emails

		SELECT * FROM enviar_emails_promocionais;


	--VIEW para produtos com estoque baixo

		SELECT * FROM  lista_reabastecimento;


	-- Tabela person.person + person.password

		SELECT * FROM pessoa_senha;	




































