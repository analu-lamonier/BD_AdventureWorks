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
	
	







--VIEW para produtos com estoque baixo

CREATE OR REPLACE VIEW lista_reabastecimento AS
SELECT
	p.productid,
	p.name,
	p.productnumber,
	p.reorderpoint,
	i.quantity
FROM 
	production.product p
JOIN 
	production.productinventory i
ON 
	p.productid = i.productid;
	
	
-- Tabela person.person + person.password
CREATE OR REPLACE VIEW pessoa_senha AS
SELECT
    p.businessentityid,
    p.persontype,
    p.title,
    p.firstname,
    p.middlename,
    p.lastname,
    p.suffix,
    p.emailpromotion,
    pwd.passwordhash,
    pwd.passwordsalt
FROM
    person.person p
JOIN
    person.password pwd
ON 
	p.businessentityid = pwd.businessentityid;
	
SELECT * FROM person_combined_info;	



-- VIEW pessoas que desejam receber email da adventure works e seus emails

CREATE OR REPLACE VIEW enviar_emails_promocionais AS
SELECT 
    p.businessentityid,
    p.firstname,
    p.lastname,
    p.emailpromotion,
    e.emailaddress
FROM 
    person.person p 
JOIN 
    person.emailaddress e ON p.businessentityid = e.businessentityid
WHERE 
    p.emailpromotion = 1;
	
SELECT * FROM enviar_emails_promocionais;		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	