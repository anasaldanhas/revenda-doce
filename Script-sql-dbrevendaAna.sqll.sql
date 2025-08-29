create database db_revenda_anaclara

create table cliente (
    cliente_id serial primary key,
    nome varchar(150) not null,
    email varchar(150) unique not null,
    telefone varchar(20) not null,
    data_cadastro date default current_date
);

create table doce (
    doce_id serial primary key,
    nome varchar(150) not null,
    sabor varchar(100) not null,
    preco numeric(10,2) not null check (preco > 0),
    estoque int not null default 0
);

create table fornecedor (
    fornecedor_id serial primary key,
    nome varchar(150) not null,
    cnpj varchar(20) unique not null,
    telefone varchar(20),
    cidade varchar(100) not null
);

create table pedido (
    pedido_id serial primary key,
    cliente_id int not null references cliente(cliente_id),
    data_pedido date default current_date,
    status varchar(20) not null default 'Pendente',
    valor_total numeric(10,2) not null check (valor_total >= 0)
);

create table pedido_doce (
    pedido_id int not null references pedido(pedido_id),
    doce_id int not null references doce(doce_id),
    quantidade int not null check (quantidade > 0),
    primary key (pedido_id, doce_id)
);

create table pagamento (
    pagamento_id serial primary key,
    pedido_id int not null references pedido(pedido_id),
    forma_pagamento varchar(50) not null,
    valor_pago numeric(10,2) not null check (valor_pago >= 0),
    data_pagamento date default current_date
);

create view vw_pedidos_clientes as
select p.pedido_id, c.nome as cliente, p.data_pedido, p.status, p.valor_total
from pedido p
join cliente c on p.cliente_id = c.cliente_id;

create view vw_itens_pedido as
select pd.pedido_id, d.nome as doce, d.sabor, pd.quantidade, d.preco, (pd.quantidade * d.preco) as subtotal
from pedido_doce pd
join doce d on pd.doce_id = d.doce_id;

insert into cliente (nome, email, telefone) values
('Maria Silva', 'maria.silva@email.com', '11988887777'),
('João Souza', 'joao.souza@email.com', '11977776666'),
('Ana Clara Saldanha', 'ana.clara@email.com', '11955554444'),
('Fernanda Lima', 'fernanda.lima@email.com', '11966667777'),
('Paulo Henrique', 'paulo.henrique@email.com', '11999998888'),
('Juliana Alves', 'juliana.alves@email.com', '11944443333'),
('Roberto Dias', 'roberto.dias@email.com', '11911112222'),
('Beatriz Costa', 'beatriz.costa@email.com', '11922221111'),
('Lucas Rocha', 'lucas.rocha@email.com', '11933334444'),
('Carla Mendes', 'carla.mendes@email.com', '11955556666');

insert into doce (nome, sabor, preco, estoque) values
('Brigadeiro Gourmet', 'Chocolate', 2.50, 200),
('Beijinho', 'Coco', 2.00, 150),
('Trufa Recheada', 'Morango', 3.00, 100),
('Pé de Moleque', 'Amendoim', 2.80, 120),
('Bala de Goma', 'Frutas Sortidas', 0.50, 500),
('Pão de Mel', 'Chocolate ao leite', 4.50, 80),
('Pirulito Artesanal', 'Frutas Vermelhas', 1.00, 300),
('Cupcake', 'Baunilha', 5.00, 60),
('Brownie', 'Chocolate', 6.00, 70),
('Marshmallow', 'Morango', 1.20, 250);

insert into fornecedor (nome, cnpj, telefone, cidade) values
('Doces da Rosa', '12.345.678/0001-01', '1133334444', 'São Paulo'),
('Fábrica Santo Antônio', '23.456.789/0001-02', '1144445555', 'Campinas'),
('Delícias do Interior', '34.567.890/0001-03', '1155556666', 'Sorocaba'),
('Sabor Mineiro', '45.678.901/0001-04', '1166667777', 'Belo Horizonte'),
('Doceria Real', '56.789.012/0001-05', '1177778888', 'Rio de Janeiro'),
('Doce Encanto', '67.890.123/0001-06', '1188889999', 'São Paulo'),
('Açúcar e Afeto', '78.901.234/0001-07', '1199990000', 'Campinas'),
('Império dos Doces', '89.012.345/0001-08', '1133332222', 'Fortaleza'),
('Fábrica Estrela', '90.123.456/0001-09', '1144443333', 'Natal'),
('Casa do Chocolate', '01.234.567/0001-10', '1155554444', 'Curitiba');

insert into pedido (cliente_id, data_pedido, status, valor_total) values
(1, '2025-08-01', 'Pago', 25.00),
(2, '2025-08-02', 'Pendente', 15.00),
(3, '2025-08-03', 'Pago', 30.00),
(4, '2025-08-04', 'Pago', 12.00),
(5, '2025-08-05', 'Cancelado', 0.00),
(6, '2025-08-06', 'Pago', 18.50),
(7, '2025-08-07', 'Pendente', 20.00),
(8, '2025-08-08', 'Pago', 50.00),
(9, '2025-08-09', 'Pago', 10.00),
(10,'2025-08-10', 'Pago', 8.00);

insert into pedido_doce (pedido_id, doce_id, quantidade) values
(1, 1, 10),
(1, 2, 5),
(2, 3, 5),
(3, 1, 6),
(3, 4, 3),
(4, 5, 20),
(5, 6, 2),
(6, 7, 10),
(7, 8, 4),
(8, 9, 5);

insert into pagamento (pedido_id, forma_pagamento, valor_pago, data_pagamento) values
(1, 'Cartão de Crédito', 25.00, '2025-08-01'),
(3, 'Pix', 30.00, '2025-08-03'),
(4, 'Dinheiro', 12.00, '2025-08-04'),
(6, 'Cartão de Débito', 18.50, '2025-08-06'),
(8, 'Pix', 50.00, '2025-08-08'),
(9, 'Dinheiro', 10.00, '2025-08-09'),
(10,'Cartão de Crédito', 8.00, '2025-08-10'),
(2, 'Boleto', 15.00, '2025-08-02'),
(7, 'Pix', 20.00, '2025-08-07'),
(5, '---', 0.00, '2025-08-05');

select * from vw_pedidos_clientes;

select * from vw_itens_pedido;

-- ============================================
-- 1. CONSULTA COM LIKE
-- ============================================
select * from cliente
where nome like 'A%';

-- ============================================
-- 2. EXPLAIN DA CONSULTA (PRINT 1)
-- ============================================
explain select * from cliente
where nome like 'A%';

-- ============================================
-- 3. CRIAÇÃO DE INDEX
-- ============================================
create index idx_cliente_nome on cliente(nome);

drop index if exists idx_cliente_nome;
create index idx_cliente_nome on cliente(nome);

-- ============================================
-- 4. EXPLAIN NOVAMENTE (PRINT 2, deve usar Index Scan)
-- ============================================
explain select * from cliente
where nome like 'A%';

-- ============================================
-- 5. ALTERAR TIPOS DE COLUNAS

-- varchar -> int (tentando voltar, pode dar erro se existir texto inválido)
alter table doce alter column estoque type int using estoque::int;
-- int -> varchar
alter table doce alter column estoque type varchar(10);

-- ============================================
-- 6. CRIAR USUÁRIOS
-- ============================================

-- Usuário com todas as permissões
create user anaclara with password '12345';
grant all privileges on all tables in schema public to anaclara;

-- Usuário colega com permissão somente de SELECT na tabela cliente
create user colega with password '12345';
grant select on cliente to colega;

-- Teste esperado:
-- no usuário colega → select * from cliente; funciona ✅
-- no usuário colega → insert/update/delete em cliente → erro ❌

-- ============================================
-- 7. CONSULTAS COM JOIN (12 no total, 4 grupos x 3 joins)
-- ============================================

-- 7.1 Pedidos e Clientes
select c.nome, p.pedido_id, p.valor_total
from cliente c inner join pedido p on c.cliente_id = p.cliente_id;

select c.nome, p.pedido_id, p.valor_total
from cliente c left join pedido p on c.cliente_id = p.cliente_id;

select c.nome, p.pedido_id, p.valor_total
from cliente c right join pedido p on c.cliente_id = p.cliente_id;

-- 7.2 Pedido e Pagamento
select p.pedido_id, pg.forma_pagamento, pg.valor_pago
from pedido p inner join pagamento pg on p.pedido_id = pg.pedido_id;

select p.pedido_id, pg.forma_pagamento, pg.valor_pago
from pedido p left join pagamento pg on p.pedido_id = pg.pedido_id;

select p.pedido_id, pg.forma_pagamento, pg.valor_pago
from pedido p right join pagamento pg on p.pedido_id = pg.pedido_id;

-- 7.3 Pedido e Doces (via tabela de ligação)
select p.pedido_id, d.nome, pd.quantidade
from pedido p
inner join pedido_doce pd on p.pedido_id = pd.pedido_id
inner join doce d on pd.doce_id = d.doce_id;

select p.pedido_id, d.nome, pd.quantidade
from pedido p
left join pedido_doce pd on p.pedido_id = pd.pedido_id
left join doce d on pd.doce_id = d.doce_id;

select p.pedido_id, d.nome, pd.quantidade
from pedido p
right join pedido_doce pd on p.pedido_id = pd.pedido_id
right join doce d on pd.doce_id = d.doce_id;

-- 7.4 Cliente e Pagamento (exemplo adicional)
select c.nome, pg.forma_pagamento, pg.valor_pago
from cliente c
inner join pedido p on c.cliente_id = p.cliente_id
inner join pagamento pg on p.pedido_id = pg.pedido_id;

select c.nome, pg.forma_pagamento, pg.valor_pago
from cliente c
left join pedido p on c.cliente_id = p.cliente_id
left join pagamento pg on p.pedido_id = pg.pedido_id;

select c.nome, pg.forma_pagamento, pg.valor_pago
from cliente c
right join pedido p on c.cliente_id = p.cliente_id
right join pagamento pg on p.pedido_id = pg.pedido_id;

-- ============================================
-- 8. ATUALIZAR REGISTROS COM NULL
-- ============================================

update cliente set telefone = not null where cliente_id in (2,4,6);
update pagamento set forma_pagamento = not null where pagamento_id in (3,5);
alter table cliente alter column telefone drop not null;
alter table cliente alter column telefone drop not null;
update cliente set telefone = null where cliente_id in (2,4,6);


-- depois o update funciona:
update pagamento set forma_pagamento = null where pagamento_id in (3,5);

-- ============================================
-- 9. REFAR AS CONSULTAS COM JOIN
-- ============================================
-- (execute novamente as consultas do item 7 e compare os resultados)
-- Com valores NULL, INNER JOIN pode excluir registros
-- Já LEFT/RIGHT JOIN ainda mostram, mas com campos NULL

