-----------------BEGIN: Script to be run at Publisher ----------------- 
:setvar Publisher "Windows10Ent\SQL2016"
:setvar Subscriber "Windows10Ent\SQL2014"
:setvar Distributor "Windows10Ent\SQL2016"
:setvar DatabaseName "AdventureWorks"
:setvar PublicationName "Pub-AdventureWorks"

-- Connect to the publisher
:CONNECT $(Publisher)

USE $(DatabaseName)

-- Add subscription at publisher
EXEC sp_addsubscription 
  @publication = "$(PublicationName)", 
  @subscriber = "$(Subscriber)", 
  @destination_db = $(DatabaseName), 
  @sync_type = N'Automatic', 
  @subscription_type = N'pull', 
  @update_mode = N'read only' 

GO
-----------------END: Script to be run at Publisher ----------------- 

-----------------BEGIN: Script to be run at Subscriber ----------------- 
:CONNECT $(Subscriber)

USE $(DatabaseName)

-- Create subscription at the subscriber
EXEC sp_addpullsubscription 
  @publisher = "$(Publisher)", 
  @publication = "$(PublicationName)", 
  @publisher_db = $(DatabaseName), 
  @independent_agent = N'True', 
  @subscription_type = N'pull', 
  @description = N'', 
  @update_mode = N'read only', 
  @immediate_sync = 1 

-- Add the distribution agent.
-- Pull subcription => distribution agent is at subscriber 
EXEC sp_addpullsubscription_agent 
  @publisher = "$(Publisher)", 
  @publisher_db = $(DatabaseName), 
  @publication = "$(PublicationName)", 
  @distributor = "$(Distributor)", 
  @distributor_security_mode = 1, 
  @distributor_login = N'', 
  @distributor_password = NULL,
  @frequency_type = 64, 
  @frequency_interval = 0, 
  @frequency_relative_interval = 0, 
  @frequency_recurrence_factor = 0, 
  @frequency_subday = 0, 
  @frequency_subday_interval = 0, 
  @active_start_time_of_day = 0, 
  @active_end_time_of_day = 235959, 
  @active_start_date = 20180515, 
  @active_end_date = 99991231, 
  @job_login = NULL, 
  @job_password = NULL, 
  @publication_type = 0 

go 
-----------------END: Script to be run at Subscriber----------------- 