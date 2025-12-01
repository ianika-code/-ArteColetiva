-- DROP SCHEMA artecoletiva;

CREATE SCHEMA artecoletiva AUTHORIZATION postgres;

-- artecoletiva.atelie definição

-- Drop table

-- DROP TABLE artecoletiva.atelie;

CREATE TABLE artecoletiva.atelie (
	id_atelie serial4 NOT NULL,
	nome varchar(120) NOT NULL,
	cnpj varchar(18) NOT NULL,
	telefone varchar(20) NULL,
	CONSTRAINT atelie_cnpj_key UNIQUE (cnpj),
	CONSTRAINT atelie_pkey PRIMARY KEY (id_atelie)
);


-- artecoletiva.cliente definição

-- Drop table

-- DROP TABLE artecoletiva.cliente;

CREATE TABLE artecoletiva.cliente (
	id_cliente serial4 NOT NULL,
	nome varchar(120) NOT NULL,
	cpf varchar(14) NOT NULL,
	telefone varchar(20) NULL,
	email varchar(120) NULL,
	CONSTRAINT cliente_cpf_key UNIQUE (cpf),
	CONSTRAINT cliente_email_key UNIQUE (email),
	CONSTRAINT cliente_pkey PRIMARY KEY (id_cliente)
);


-- artecoletiva.artesao definição

-- Drop table

-- DROP TABLE artecoletiva.artesao;

CREATE TABLE artecoletiva.artesao (
	id_artesao serial4 NOT NULL,
	id_atelie int4 NOT NULL,
	nome varchar(120) NOT NULL,
	cpf varchar(14) NOT NULL,
	telefone varchar(20) NULL,
	email varchar(120) NULL,
	CONSTRAINT artesao_cpf_key UNIQUE (cpf),
	CONSTRAINT artesao_email_key UNIQUE (email),
	CONSTRAINT artesao_pkey PRIMARY KEY (id_artesao),
	CONSTRAINT artesao_id_atelie_fkey FOREIGN KEY (id_atelie) REFERENCES artecoletiva.atelie(id_atelie) ON DELETE CASCADE
);


-- artecoletiva.endereco definição

-- Drop table

-- DROP TABLE artecoletiva.endereco;

CREATE TABLE artecoletiva.endereco (
	id_endereco serial4 NOT NULL,
	id_cliente int4 NULL,
	id_atelie int4 NULL,
	rua varchar(200) NOT NULL,
	numero varchar(10) NULL,
	bairro varchar(120) NULL,
	cidade varchar(120) NULL,
	cep varchar(10) NULL,
	CONSTRAINT endereco_pkey PRIMARY KEY (id_endereco),
	CONSTRAINT endereco_id_atelie_fkey FOREIGN KEY (id_atelie) REFERENCES artecoletiva.atelie(id_atelie) ON DELETE SET NULL,
	CONSTRAINT endereco_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES artecoletiva.cliente(id_cliente) ON DELETE SET NULL
);


-- artecoletiva.pedido definição

-- Drop table

-- DROP TABLE artecoletiva.pedido;

CREATE TABLE artecoletiva.pedido (
	id_pedido serial4 NOT NULL,
	id_cliente int4 NOT NULL,
	data_pedido date NOT NULL,
	status varchar(30) NOT NULL,
	valor_total numeric(10, 2) NULL,
	CONSTRAINT pedido_pkey PRIMARY KEY (id_pedido),
	CONSTRAINT pedido_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES artecoletiva.cliente(id_cliente) ON DELETE CASCADE
);


-- artecoletiva.produto definição

-- Drop table

-- DROP TABLE artecoletiva.produto;

CREATE TABLE artecoletiva.produto (
	id_produto serial4 NOT NULL,
	id_artesao int4 NOT NULL,
	nome varchar(120) NOT NULL,
	descricao text NULL,
	preco numeric(10, 2) NOT NULL,
	quantidade_estoque int4 NOT NULL,
	foto varchar(255) NULL,
	CONSTRAINT produto_pkey PRIMARY KEY (id_produto),
	CONSTRAINT produto_id_artesao_fkey FOREIGN KEY (id_artesao) REFERENCES artecoletiva.artesao(id_artesao) ON DELETE CASCADE
);


-- artecoletiva.envio definição

-- Drop table

-- DROP TABLE artecoletiva.envio;

CREATE TABLE artecoletiva.envio (
	id_envio serial4 NOT NULL,
	id_pedido int4 NOT NULL,
	CONSTRAINT envio_id_pedido_key UNIQUE (id_pedido),
	CONSTRAINT envio_pkey PRIMARY KEY (id_envio),
	CONSTRAINT envio_id_pedido_fkey FOREIGN KEY (id_pedido) REFERENCES artecoletiva.pedido(id_pedido) ON DELETE CASCADE
);


-- artecoletiva.item_pedido definição

-- Drop table

-- DROP TABLE artecoletiva.item_pedido;

CREATE TABLE artecoletiva.item_pedido (
	id_pedido int4 NOT NULL,
	id_produto int4 NOT NULL,
	quantidade int4 NOT NULL,
	subtotal numeric(10, 2) NULL,
	CONSTRAINT item_pedido_pkey PRIMARY KEY (id_pedido, id_produto),
	CONSTRAINT item_pedido_id_pedido_fkey FOREIGN KEY (id_pedido) REFERENCES artecoletiva.pedido(id_pedido) ON DELETE CASCADE,
	CONSTRAINT item_pedido_id_produto_fkey FOREIGN KEY (id_produto) REFERENCES artecoletiva.produto(id_produto) ON DELETE CASCADE
);