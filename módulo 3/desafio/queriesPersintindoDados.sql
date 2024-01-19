-- inserção de dados e queries
use ecommerce;
show tables;

-- insercao tabela cliente
-- 
desc  cliente;
-- 'rua', 'Minit', 'Lname', 'idClient','Fname','estado', 'CPF', 'complemento', 'cidade','bairro', 
insert into cliente (Fname,Minit,Lname,CPF,rua,bairro,complemento,cidade,estado)
		values ('Roberta','Y','Lacerda','11111111111','Rua 1','Centro','Casa','Quixadá','CE'),
				('Amanda','K','Saldanha','22222222222','Rua 2','Alto São Francisco','Apt','Quixadá','CE'),
                ('Darliene','S','Viera','33333333333','Rua A','Ipiranga Ville','','Icó','CE'),
                ('Theo','L','Oliveira','44444444444','Rua 41','Centro','Apt','Quixadá','CE'),
                ('Jose','R','Oliveira','55555555555','Rua 6','Alto São Francisco','','Quixadá','CE');
select * from cliente;
--------------------------------------------------------------------------------------------------------------------
-- insercao tabela produto
desc produto;
-- idProduto,produto_descricao,classificacao_kids,produto_categoria,valor,avaliacao,dimensao
alter table produto 
	modify column valor float;
insert into produto (produto_descricao,classificacao_kids,produto_categoria,valor,avaliacao,dimensao)
			values ('Produto 1','0','Geral','100.00','1',''),
				   ('Produto 2','0','Eletronico','200.00','5',''),
                   ('Produto 3','1','Brinquedo','10.00','3',''),
                   ('Produto 4','0','Geral','30.00','0',''),
                   ('Produto 5','0','Alimentos','25','1',''),
                   ('Produto 6','0','Moveis','150','6','1.5');
select * from produto;
--------------------------------------------------------------------------------------------------------------------
-- insercao tabela fornecedor
desc fornecedor;
insert into fornecedor (fRazaoSocial, CNPJ,nomeFantasia)
		values ('Fornecedor1','11111111111111', 'Fornecedor 1 '),
			  ('Fornecedor2','22222222222222', 'Fornecedor 2'),
              ('Fornecedor3','33333333333333', 'Fornecedor3')
              ;
        select * from fornecedor;
--------------------------------------------------------------------------------------------------------------------

-- insercao tabela estoque
desc estoque;
insert into estoque (localEstoque,estoqueDescricao)
		values ('Rio De Janeiro','Estoque1'),
				('São Paulo','Estoque2'),
				('Ceará','Estoque3'),
				('Rio Grande do Norte','Estoque4');
select * from estoque;
--------------------------------------------------------------------------------------------------------------------

-- insercao tabela pedido
-- (\'Em andamento\',\'Enviado\',\'Processando\',\'Entregue\')'

desc pedido;
select * from cliente;
insert into pedido (idCliente,pedido_descricao,pedido_status,pedido_valor_frete)
			values('1','pedido via site','Em andamento',null),
           ('2','pedido via aplicativo','Enviado',null),
            ('3','compra na loja','processando',null),
            ('4','pedido de venda externa','Entregue',null);
select * from pedido;
insert into pedido (idCliente,pedido_descricao,pedido_status,pedido_valor_frete)
			values('1','pedido via site','Entregue',null);
--------------------------------------------------------------------------------------------------------------------

-- inserção tabela itempedido
-- idPedido,idProduto,StatusItem,quantidade
-- Disponivel, Sem Estoque
-- '43', '44','45', '46', '47','48'
desc itempedido;
insert into itempedido (idPedido,idProduto,StatusItem,quantidade)
						values('1','43','Disponivel','20'),
								('1','44','Disponivel','50'),
                                ('1','45','Disponivel','5'),
                                ('2','43','Disponivel','10'),
                                ('2','46','Disponivel','6'),
                                ('3','43','Disponivel','20'),
                                ('4','48','Disponivel','100'),
                                ('4','47','Disponivel','30');
                        
--------------------------------------------------------------------------------------------------------------------
-- insercao tabela finalizacao
-- idFormadeDePagamento, idPedido, subtotal, desconto,Total
-- 1 (Cartão de credito),2 Dinheiro,3 Cartao de Debito,4 Pix
desc finalizacao;
select * from formasdepagamento;
alter table finalizacao
	modify column subtotal float;
alter table finalizacao
	modify column total float;
    
insert into finalizacao (idFormaDePagamento,idPedido, subtotal, desconto,Total)
					values ('1','1','12000.00','0','12000.00'),
                           ('1','4','50.00','0','50.00'),
                           ('2','4','1180.00','0','1180.00'),
                           ('3','4','2000.00','0','2000.00'),
                           ('4','1','10000.00','0','100000.00'),
                           ('4','3','5000.00','0','5000.00'),
                           ('4','4','750.00','0','7500.00');
select * from finalizacao;
--------------------------------------------------------------------------------------------------------------------        

-- insercao tabela formasdepagamento
desc formasdepagamento;
insert into formasdepagamento (nome,parcelamento,especie)
						values ('Cartão de Crédito','Parcelado','Cartão'),
								('Dinheiro','A Vista','Dinheiro'),
                                ('Cartão de Debito','A Vista','Cartão'),
                                ('Pix','A Vista','Pagamento Instantaneo');
--------------------------------------------------------------------------------------------------------------------
-- insercao tabela cadcartaocliente

desc cadcartaocliente;
insert into cadcartaocliente (nomeTitular,numeroCartao,validade,tipo)
							values ('Roberta Yaskarelly','00000000001234567890','2029-01-05','Credito'),
									('Jose Rai','00000000001234586789','2018-12-07','Debito');
                                    
select * from cadcartaocliente;
--------------------------------------------------------------------------------------------------------------------
-- 'idCartao', 'int', 'NO', 'PRI', NULL, ''
-- 'idCliente', 'int', 'NO', 'PRI', NULL, ''
-- 'idFormaDePagamento', 'int', 'YES', 'MUL', NULL, ''

desc cartaoCliente;
select * from cliente;
select * from formasdepagamento;
select * from cadcartaocliente;
insert into cartaoCliente (idCartao,idCliente,idFormaDePagamento)
					values ('3','1','1'),('4','5','4');
                    
--------------------------------------------------------------------------------------------------------------------
-- insercao tabela terceirovendedor
desc terceirovendedor;
insert into terceirovendedor(tRazaoSocial,CNPJ,CPF,contato,nomeFantasia)
					values ('Vendedor LTDA','','000000000','88996658999', 'Vendedor 1'),
							('Vendedor ME','99999999999999','','88995658999', 'Vendedor 2');
                           
                            
insert into terceirovendedor(tRazaoSocial,CNPJ,CPF,contato,nomeFantasia)
					values ('Vendedor MEI','11111111111111','02525545','88965653131', 'Vendedor 3');                            
 select * from terceirovendedor;                           
  select * from fornecedor;                           
--------------------------------------------------------------------------------------------------------------------

-- insercao tabela produtofornecedor
use ecommerce;
desc produtofornecedor;
-- 'idProduto','idFornecedor'
select * from produto;
-- '43', '44','45', '46', '47','48'
SELECT * FROM FORNECEDOR;
-- 1,2,3,5

insert into produtofornecedor (idProduto,idFornecedor)
				values ('43','1'),
						('44','2'),
						('45','3'),
                        ('46','5'),
                        ('47','1'),
                        ('48','2');
 select * from produtofornecedor;                       
 --------------------------------------------------------------------------------------------------------------------               

-- insercao tabela produtoporvendedor
-- idTerceiroVendedor,idProduto,quantidade
-- 1,2
select * from terceirovendedor;
desc produtoporvendedor;
insert into produtoporvendedor(idTerceiroVendedor,idProduto,quantidade)
				values('1','44','10'),
                      ('2','45','5'),
                      ('1','48','15');
--------------------------------------------------------------------------------------------------------------------                
-- insercao tabela frete
desc frete;
-- idPedido,statusPedido,codRastreio,valor
select* from pedido;
insert into frete(idPedido,statusPedido,codRastreio,valor)
				values('1','Separando itens','123456456','20.00'),
					  ('2','despachado','123456457','20.00');
--------------------------------------------------------------------------------------------------------------------
                        
-- -- insercao tabela estoqueproduto
-- idEstoque,idProduto,quantidade
-- '43', '44','45', '46', '47','48'
-- 1,2,3,4
select * from estoque;
desc estoqueproduto;

insert into estoqueproduto (idEstoque,idProduto,quantidade)
				values ('1','43','1000'),
						('2','44','1500'),
                        ('3','45','2000'),
                        ('4','47','500'),
                        ('1','48','300');
--------------------------------------------------------------------------------------------------------------------                

