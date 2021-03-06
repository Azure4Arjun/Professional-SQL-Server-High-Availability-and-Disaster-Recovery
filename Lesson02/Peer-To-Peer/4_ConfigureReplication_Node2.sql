:setvar Publisher "Neptune\SQL2014"
:setvar Subscriber "Neptune\SQL2016"
:setvar DatabaseName "AdventureWorks"
:setvar PublicationName "P2P_AdventureWorks"


:CONNECT $(Subscriber)
-- Enabling the replication database 
USE master 

EXEC sp_replicationdboption 
  @dbname = N'AdventureWorks', 
  @optname = N'publish', 
  @value = N'true' 

GO

-- Adding the transactional publication 
USE $(DatabaseName) 

EXEC sp_addpublication 
@publication = "$(PublicationName)", 
@description = N'Peer-to-Peer publication of database ''AdventureWorks'' from Publisher ''NEPTUNE\SQL2014''.' , 
@sync_method = N'native', 
@allow_push = N'true', 
@allow_pull = N'true', 
@allow_anonymous = N'false', 
@repl_freq = N'continuous', 
@status = N'active', 
@independent_agent = N'true', 
@immediate_sync = N'true', 
@replicate_ddl = 1, 
@allow_initialize_from_backup = N'true', 
@enabled_for_p2p = N'true', 
@p2p_conflictdetection = N'true', 
@p2p_continue_onconflict=N'true',
@p2p_originator_id = 2 

go 

-- Adding the transactional articles 

EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'SalesOrderDetail', 
  @source_owner = N'Sales', 
  @source_object = N'SalesOrderDetail', 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'SalesOrderDetail', 
  @status = 24, 
  @ins_cmd = N'CALL [sp_MSins_SalesSalesOrderDetail01166611037473422351]', 
  @del_cmd = N'CALL [sp_MSdel_SalesSalesOrderDetail01166611037473422351]', 
  @upd_cmd = N'SCALL [sp_MSupd_SalesSalesOrderDetail01166611037473422351]' 

GO

EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'SalesOrderHeader', 
  @source_owner = N'Sales', 
  @source_object = N'SalesOrderHeader', 
  @destination_table = N'SalesOrderHeader', 
  @destination_owner = N'Sales', 
  @ins_cmd = N'CALL [sp_MSins_SalesSalesOrderHeader06115380772026372895]', 
  @del_cmd = N'CALL [sp_MSdel_SalesSalesOrderHeader06115380772026372895]', 
  @upd_cmd = N'SCALL [sp_MSupd_SalesSalesOrderHeader06115380772026372895]' 

GO


EXEC sp_addsubscription 
  @publication = "$(PublicationName)", 
  @subscriber = "$(Publisher)", 
  @destination_db = "$(DatabaseName)", 
  @subscription_type = N'Push', 
  @sync_type = N'replication support only', 
  @article = N'all', 
  @update_mode = N'read only', 
  @subscriber_type = 0 


EXEC sp_addpushsubscription_agent 
  @publication = "$(PublicationName)", 
  @subscriber = "$(Publisher)", 
  @subscriber_db = "$(DatabaseName)", 
  @job_login = NULL, 
  @job_password = NULL, 
  @subscriber_security_mode = 1, 
  @frequency_type = 64, 
  @frequency_interval = 1, 
  @frequency_relative_interval = 1, 
  @frequency_recurrence_factor = 0, 
  @frequency_subday = 4, 
  @frequency_subday_interval = 5, 
  @active_start_time_of_day = 0, 
  @active_end_time_of_day = 235959, 
  @active_start_date = 0, 
  @active_end_date = 0

 