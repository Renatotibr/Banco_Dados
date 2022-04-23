ALTER procedure RMAtualizaestatisticas  

as  

  

declare @tablename varchar(100)  

declare @tablename_header varchar(75)  

declare tnames_cursor cursor for select name from sysobjects  

 where type = 'u'  

open tnames_cursor  

fetch next from tnames_cursor into @tablename  

while (@@fetch_status <> -1)  

begin  

 if (@@fetch_status <> -2)  

 begin  

  select @tablename_header = 'atualizando '  + rtrim(upper(@tablename))  

  print @tablename_header  

  exec ('update statistics '  + @tablename )  

 end  

 fetch next from tnames_cursor into @tablename  

end  

print ' '  

print ' '  

select @tablename_header = '*************  fim das tabelas  *************'  

print @tablename_header  

print ' '  

print 'as estatisticas foram atualizadas para todas as tabelas'  

deallocate tnames_cursor 
GO
