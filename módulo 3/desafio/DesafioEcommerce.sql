use ecommerce;
show tables;
-- Query para retornar o valor total do pedido atráves da somatório dos item do pedido realizando um join a tabela produto
-- agrupando e ordenando pelo idPedido;
select  idPedido, sum(quantidade*valor) as valor
		from itemPedido i inner join produto p
		where p.idProduto = i.idProduto
        group by idPedido
        order by idPedido;
-- Query para destacar a quantidade , valor do item e valor total, criando um atributo variavel atráves da função de agregação, utilizando inner join entre as tabelas
-- itemPedido e Produto.   
 
select  idPedido as Cod_Pedido,p.idProduto as Cod_Produto,p.produto_descricao as Descricao, quantidade, valor as Valor_unitario, (quantidade*valor) as total
		from itemPedido i inner join produto p
		where p.idProduto = i.idProduto
       order by idPedido;
-- Query utilizando a função de agregação SUM para informar a somatório de todos os pedidos  utilizando a inner join entre a tabela itemPedido e produto. 
select sum(quantidade*valor) as valor
		from itemPedido i inner join produto p
		where p.idProduto = i.idProduto;
        
-- Query para retornar quantos pedidos foram feitos por cada cliente
select p.idCliente as Cod_Cliente,concat(c.Fname, ' ', Lname) as Nome,count(*) as Total_Pedidos 
	from pedido p 
	inner join cliente c on p.idCliente = c.idClient
	group by p.idCliente;

-- Query para retornar se Algum Vendedor tambem é um fornecedor

select v.nomeFantasia, v.CNPJ from fornecedor f
inner join terceirovendedor v on f.CNPJ= v.CNPJ
where f.CNPJ = v.CNPJ;

-- Relação de Produtos, Fornecedor e Estoque
select p.idProduto, p.produto_descricao as Descricao,pf.idFornecedor as Cod_Fornecedor, f.nomeFantasia as Fornecedor, e.estoqueDescricao as Local_estoque,ep.quantidade as Quantidade
from produto p
inner join estoqueproduto ep on p.idProduto = ep.idProduto
inner join estoque e on ep.idEstoque = e.idEstoque
inner join produtofornecedor pf on p.idProduto = pf.idProduto
inner join fornecedor f on pf.idFornecedor = f.idFornecedor
order by idProduto;

-- Query para Retornar a relação de quantidade de estoque por local de estoque
select e.estoqueDescricao as Local_estoque, sum(quantidade) as quantidade from estoque e
inner join estoqueproduto ep on e.idEstoque = ep.idEstoque
group by e.estoqueDescricao;

-- Relação De Nomes dos fornecedores e Nomes dos produtos
select p.produto_descricao, f.nomeFantasia from produto p
inner join produtofornecedor pf on p.idProduto = pf.idProduto
inner join fornecedor f on pf.idFornecedor = f.idFornecedor;


 -- Ticket médio dos produtos    
 select * from itempedido;
       select ip.idProduto, p.produto_descricao , avg(quantidade) as ticket_medio from itempedido ip
       inner join produto p on p.idProduto = ip.idProduto
       group by idProduto;
       
-- Query para relação de produtos total vendas, ordenando por valor total
select  p.idProduto,p.produto_descricao as Descricao, sum(quantidade*valor) as total
		from itemPedido i inner join produto p
		where p.idProduto = i.idProduto
        group by i.idProduto
       order by total desc;
       
-- Mostrar informações do pedido e valor do frete.

select p.idPedido, p.idCliente, c.Fname as Nome_cliente,  p.pedido_status, f.statusPedido as status_frete, f.codRastreio, f.valor as Valor_frete
from pedido p 
left join frete f on f.idPedido = p.idPedido
inner join cliente c on c.idClient = p.idCliente;

-- agrupando as formas de pagamento utilizado na finalizacao com valor total acima de 3000,0 e ordenando por valor em formato desc.

select idFormaDePagamento,fp.Nome, fp.parcelamento, fp.especie, sum(subtotal) as Total from finalizacao f
inner join formasdepagamento fp on f.idFormaDePagamento = fp.idFormasPagamento
group by f.idFormaDePagamento
having sum(subtotal) >3000
order by Total desc;

-- Compras que tiveram finalizacao com cartao cadastrado na plataforma

select f.idFinalizacao, f.idPedido, concat (c.Fname, '',c.Lname) as Nome_cliente_Pedido,f.idFormaDePagamento,  fp.nome ,cc.idCliente,cc2.NomeTitular, cc2.numeroCartao from finalizacao f
inner join formasdepagamento fp on f.idFormaDePagamento = fp.idFormasPagamento
inner join cartaoCliente cc on cc.idFormaDePagamento  = fp.idFormasPagamento
inner join cadcartaocliente cc2 on cc2.idCartao = cc.idCartao
inner join pedido p on p.idPedido = f.idPedido
inner join cliente c on c.idClient = p.idCliente;



