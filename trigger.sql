create database aulaTrigger

use aulaTrigger


create table caixa(
	dataVenda date,
	saldoInicial float,
	saldoFinal float
)

insert into caixa
values(GETDATE(), 100, 100)

select * from caixa

create table vendas(
	dataVenda date,
	codigo int,
	valor float
)


create trigger tgr_novaVenda
on vendas for insert
as
begin
declare
	@valor float,
	@data datetime
	select @data = dataVenda, @valor = valor from inserted
	update caixa set saldoFinal = saldoFinal + @valor
	where dataVenda = @data
end

insert into vendas
values(GETDATE(), 3, 150)



create trigger tgr_excluirVenda
on vendas for delete
as
begin
declare
	@valor float,
	@data datetime
	select @data = dataVenda, @valor = valor from deleted
	update caixa set saldoFinal = saldoFinal - @valor
	where dataVenda = @data
end

delete vendas
where codigo = 3


select * from caixa

select * from vendas
