-- Criação do banco de dados para o cenário de e-commerce

create database ecommerce;
use ecommerce;
-- criar tabela cliente
create table IF NOT EXISTS  cliente (
	idClient int auto_increment primary key,
    Fname varchar (10),
    Minit char(3),
    Lname varchar (20),
    CPF char(11)not null,
    CNPJ char(14)not null,
	rua varchar (45),
    bairro varchar (45),
    complemento varchar (45),
    cidade varchar (45),
    estado char (2),
    tipo ENUM ('Fisica', 'Juridica', 'Estrangeira'),
    constraint unique_cpf_client unique (cpf),
    constraint unique_cnpj_client unique (cnpj)
    );

-- criar tabela produto

Create table IF NOT EXISTS  produto (
	idProduto int auto_increment primary key,
    produto_descricao varchar (10) not null,
    classificacao_kids bool default false,
    produto_categoria enum('Geral','Eletrônico','Vestuario','Brinquedo','Alimentos','Moveis') default 'Geral'not null,
    valor decimal (4,2) not null,
    avaliacao float default 0,
    dimensao varchar (10)
    );
    
-- criar tabela pedido

create table IF NOT EXISTS  pedido(
	idPedido int auto_increment primary key,
    idCliente int,
    pedido_descricao varchar (45) not null,
    pedido_status ENUM('Em andamento', 'Enviado', 'Processando', 'Entregue') default 'Processando',
    pedido_valor_frete decimal (4,2) default 0,
    constraint fk_cliente_pedido foreign key (idCliente) references cliente (idClient)
    on update cascade
    );

-- criar tabela fornecedor
create table IF NOT EXISTS fornecdor(
	idFornecedor int primary key auto_increment,
    fRazaoSocial varchar (45) not null,
    CNPJ char (14) not null unique,
    nomeFantasia varchar(45) not null
);
-- criar tabela terceiroVendedor
create table IF NOT EXISTS terceiroVendedor(
	idTerceiroVendedor int primary key auto_increment,
    tRazaoSocial varchar (255) not null,
    CNPJ char (14)  unique,
    CPF char (9) unique,
    contato char (11) not null,
    nomeFantasia varchar(45) not null
    );

-- criar tabela estoque
create table if not exists estoque(
	idEstoque int primary key auto_increment,
    localEstoque varchar (20) not null,
    estoqueDescricao varchar (45) not null
);
-- criar tabela Formas de pagamento
create table if not exists formasDePagamento(
	idFormasPagamento int primary key auto_increment,
    nome varchar (45) not null,
	parcelamento enum('A Vista','Parcelado') default 'A Vista' not null,
    especie ENUM('Cartão', 'Dinheiro', 'Crediario', 'Voucher', 'Pagamento Instantaneo') not null
);

-- criar tabela Cadastro de Cartão do Cliente
create table if not exists cadCartaoCliente(
	idCartao int primary key auto_increment,
    nomeTitular varchar (45) not null,
	numeroCartao varchar (20) not null,
    validade date,
    tipo enum ('Credito','Debito')
);

-- criar tabela de Frete
create table if not exists frete(
	idFrete int primary key auto_increment,
    idPedido int ,
    statusPedido enum('Separando itens', 'despachado', 'em trânsito', 'Entregue'),
    codRastreio int not null unique,
    valor decimal (4,2),
    constraint fk_frete_pedido foreign key (idPedido) references pedido (idPedido)
    
);
-- tabelas de relacinamentos M:N

-- criar tabela itemPedido
create table if not exists itemPedido(
idPedido int,
idProduto int,
statusItem  ENUM('Disponivel', 'Sem Estoque') not null,
quantidade int not null,
primary key (idPedido,idProduto),
constraint fk_item_pedido_pedido foreign key (idPedido) references pedido (idPedido),
constraint fk_item_pedido_produto foreign key (idProduto) references produto (idProduto)
);
-- criar tabela estoqueProduto
create table if not exists estoqueProduto(
	idEstoque int,
    idProduto int,
    quantidade int not null,
    primary key (idEstoque,idProduto),
    constraint fk_produto foreign key (idProduto) references produto (idProduto),
    constraint fk_estoque foreign key (idEstoque) references estoque (idEstoque)
);
create table if not exists  produtoPorVendedor(
	idTerceiroVendedor int,
    idProduto int,
    quantidade int not null,
    primary key (idTerceiroVendedor,idProduto),
    constraint fk_produto_vendedor foreign key (idProduto) references produto (idProduto),
    constraint fk_Terceiro_vendedor foreign key (idTerceiroVendedor) references terceiroVendedor (idTerceiroVendedor)   
);
create table if not exists produtoFornecedor(
	idProduto int,
    idFornecedor int,
     constraint fk_produto_fornecedor foreign key (idProduto) references produto (idProduto),
      constraint fk_fornecedor_produto foreign key (idFornecedor) references fornecedor (idFornecedor)
);
create table if not exists cartaoCliente(
idCartao int,
idCliente int,
idFormaDePagamento int,
 primary key (idCartao,idCliente),
 constraint fk_cartao foreign key (idCartao) references cadCartaoCliente (idCartao),
 constraint fk_Cliente foreign key (idCliente) references cliente (idClient),
constraint fk_FormaPagamento foreign key (idFormaDePagamento) references formasDePagamento (idFormasPagamento)
);
create table if not exists finalizacao(
idFinalizacao int auto_increment primary key,
idFormaDePagamento int,
idPedido int,
subtotal decimal (4,2) not null,
desconto decimal (4,2),
Total decimal (4,2),
constraint fk_FormaPagamento_finalizacao foreign key (idFormaDePagamento) references formasDePagamento (idFormasPagamento),
constraint fk_item_pedido_finalizacao foreign key (idPedido) references pedido (idPedido)
);

rename table fornecdor to fornecedor ;