:setvar Publisher "Neptune\SQL2016"
:setvar Subscriber "Neptune\SQL2014"
:setvar Distributor "Neptune\SQL2016"
:setvar DatabaseName "AdventureWorks"
:setvar PublicationName "AdventureWorks-Tran_Pub"

-- connect to the publisher and set replication options
:CONNECT $(Publisher)
USE "$(DatabaseName)"

-- Enable database for publication
EXEC sp_replicationdboption 
  @dbname = "$(DatabaseName)", 
  @optname = N'publish', 
  @value = N'true' 

-- Create the log reader agent
-- If this isn't specified, log reader agent is implicily created 
-- by the sp_addpublication procedure
EXEC sp_addlogreader_agent 
	@job_login = NULL, 
	@job_password = NULL,
	@publisher_security_mode = 1;
GO
-- Create publication 
EXEC sp_addpublication 
  @publication = "$(PublicationName)", 
  @description = 
N'Transactional publication of database ''AdventureWorks'' from Publisher ''WIN2012R2\SQL2016''.'
, 
@sync_method = N'concurrent', 
@retention = 0, 
@allow_push = N'true', 
@allow_pull = N'true', 
@allow_anonymous = N'true', 
@snapshot_in_defaultfolder = N'true', 
@compress_snapshot = N'false',
@repl_freq = N'continuous', 
@status = N'active', 
@independent_agent = N'true', 
@immediate_sync = N'true', 
@replicate_ddl = 1

GO

-- Create the snapshot agent
EXEC sp_addpublication_snapshot 
  @publication = "$(PublicationName)", 
  @frequency_type = 1, 
  @frequency_interval = 1, 
  @frequency_relative_interval = 1, 
  @frequency_recurrence_factor = 0, 
  @frequency_subday = 8, 
  @frequency_subday_interval = 1, 
  @active_start_time_of_day = 0, 
  @active_end_time_of_day = 235959, 
  @active_start_date = 0, 
  @active_end_date = 0, 
  @job_login = NULL, 
  @job_password = NULL, 
  @publisher_security_mode = 1 

-- Add articles to the publication 
EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'Address', 
  @source_owner = N'Person', 
  @source_object = N'Address', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'Address', 
  @destination_owner = N'Person', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_PersonAddress', 
  @del_cmd = N'CALL sp_MSdel_PersonAddress', 
  @upd_cmd = N'SCALL sp_MSupd_PersonAddress' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'AddressType', 
  @source_owner = N'Person', 
  @source_object = N'AddressType', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'AddressType', 
  @destination_owner = N'Person', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_PersonAddressType', 
  @del_cmd = N'CALL sp_MSdel_PersonAddressType', 
  @upd_cmd = N'SCALL sp_MSupd_PersonAddressType' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'BillOfMaterials', 
  @source_owner = N'Production', 
  @source_object = N'BillOfMaterials', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'BillOfMaterials', 
  @destination_owner = N'Production', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_ProductionBillOfMaterials', 
  @del_cmd = N'CALL sp_MSdel_ProductionBillOfMaterials', 
  @upd_cmd = N'SCALL sp_MSupd_ProductionBillOfMaterials' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'BusinessEntity', 
  @source_owner = N'Person', 
  @source_object = N'BusinessEntity', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'BusinessEntity', 
  @destination_owner = N'Person', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_PersonBusinessEntity', 
  @del_cmd = N'CALL sp_MSdel_PersonBusinessEntity', 
  @upd_cmd = N'SCALL sp_MSupd_PersonBusinessEntity' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'BusinessEntityAddress', 
  @source_owner = N'Person', 
  @source_object = N'BusinessEntityAddress', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'BusinessEntityAddress', 
  @destination_owner = N'Person', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_PersonBusinessEntityAddress', 
  @del_cmd = N'CALL sp_MSdel_PersonBusinessEntityAddress', 
  @upd_cmd = N'SCALL sp_MSupd_PersonBusinessEntityAddress' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'BusinessEntityContact', 
  @source_owner = N'Person', 
  @source_object = N'BusinessEntityContact', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'BusinessEntityContact', 
  @destination_owner = N'Person', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_PersonBusinessEntityContact', 
  @del_cmd = N'CALL sp_MSdel_PersonBusinessEntityContact', 
  @upd_cmd = N'SCALL sp_MSupd_PersonBusinessEntityContact' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'ContactType', 
  @source_owner = N'Person', 
  @source_object = N'ContactType', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'ContactType', 
  @destination_owner = N'Person', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_PersonContactType', 
  @del_cmd = N'CALL sp_MSdel_PersonContactType', 
  @upd_cmd = N'SCALL sp_MSupd_PersonContactType' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'CountryRegion', 
  @source_owner = N'Person', 
  @source_object = N'CountryRegion', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'CountryRegion', 
  @destination_owner = N'Person', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_PersonCountryRegion', 
  @del_cmd = N'CALL sp_MSdel_PersonCountryRegion', 
  @upd_cmd = N'SCALL sp_MSupd_PersonCountryRegion' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'CountryRegionCurrency', 
  @source_owner = N'Sales', 
  @source_object = N'CountryRegionCurrency', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'CountryRegionCurrency', 
  @destination_owner = N'Sales', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_SalesCountryRegionCurrency', 
  @del_cmd = N'CALL sp_MSdel_SalesCountryRegionCurrency', 
  @upd_cmd = N'SCALL sp_MSupd_SalesCountryRegionCurrency' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'CreditCard', 
  @source_owner = N'Sales', 
  @source_object = N'CreditCard', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'CreditCard', 
  @destination_owner = N'Sales', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_SalesCreditCard', 
  @del_cmd = N'CALL sp_MSdel_SalesCreditCard', 
  @upd_cmd = N'SCALL sp_MSupd_SalesCreditCard' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'Culture', 
  @source_owner = N'Production', 
  @source_object = N'Culture', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'Culture', 
  @destination_owner = N'Production', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_ProductionCulture', 
  @del_cmd = N'CALL sp_MSdel_ProductionCulture', 
  @upd_cmd = N'SCALL sp_MSupd_ProductionCulture' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'Currency', 
  @source_owner = N'Sales', 
  @source_object = N'Currency', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'Currency', 
  @destination_owner = N'Sales', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_SalesCurrency', 
  @del_cmd = N'CALL sp_MSdel_SalesCurrency', 
  @upd_cmd = N'SCALL sp_MSupd_SalesCurrency' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'CurrencyRate', 
  @source_owner = N'Sales', 
  @source_object = N'CurrencyRate', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'CurrencyRate', 
  @destination_owner = N'Sales', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_SalesCurrencyRate', 
  @del_cmd = N'CALL sp_MSdel_SalesCurrencyRate', 
  @upd_cmd = N'SCALL sp_MSupd_SalesCurrencyRate' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'Customer', 
  @source_owner = N'Sales', 
  @source_object = N'Customer', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'Customer', 
  @destination_owner = N'Sales', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_SalesCustomer', 
  @del_cmd = N'CALL sp_MSdel_SalesCustomer', 
  @upd_cmd = N'SCALL sp_MSupd_SalesCustomer' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'DatabaseLog', 
  @source_owner = N'dbo', 
  @source_object = N'DatabaseLog', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'DatabaseLog', 
  @destination_owner = N'dbo', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_dboDatabaseLog', 
  @del_cmd = N'CALL sp_MSdel_dboDatabaseLog', 
  @upd_cmd = N'SCALL sp_MSupd_dboDatabaseLog' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'Department', 
  @source_owner = N'HumanResources', 
  @source_object = N'Department', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'Department', 
  @destination_owner = N'HumanResources', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_HumanResourcesDepartment', 
  @del_cmd = N'CALL sp_MSdel_HumanResourcesDepartment', 
  @upd_cmd = N'SCALL sp_MSupd_HumanResourcesDepartment' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'Document', 
  @source_owner = N'Production', 
  @source_object = N'Document', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'Document', 
  @destination_owner = N'Production', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_ProductionDocument', 
  @del_cmd = N'CALL sp_MSdel_ProductionDocument', 
  @upd_cmd = N'SCALL sp_MSupd_ProductionDocument' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'EmailAddress', 
  @source_owner = N'Person', 
  @source_object = N'EmailAddress', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'EmailAddress', 
  @destination_owner = N'Person', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_PersonEmailAddress', 
  @del_cmd = N'CALL sp_MSdel_PersonEmailAddress', 
  @upd_cmd = N'SCALL sp_MSupd_PersonEmailAddress' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'Employee', 
  @source_owner = N'HumanResources', 
  @source_object = N'Employee', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'Employee', 
  @destination_owner = N'HumanResources', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_HumanResourcesEmployee', 
  @del_cmd = N'CALL sp_MSdel_HumanResourcesEmployee', 
  @upd_cmd = N'SCALL sp_MSupd_HumanResourcesEmployee' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'EmployeeDepartmentHistory', 
  @source_owner = N'HumanResources', 
  @source_object = N'EmployeeDepartmentHistory', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'EmployeeDepartmentHistory', 
  @destination_owner = N'HumanResources', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_HumanResourcesEmployeeDepartmentHistory', 
  @del_cmd = N'CALL sp_MSdel_HumanResourcesEmployeeDepartmentHistory', 
  @upd_cmd = N'SCALL sp_MSupd_HumanResourcesEmployeeDepartmentHistory' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'EmployeePayHistory', 
  @source_owner = N'HumanResources', 
  @source_object = N'EmployeePayHistory', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'EmployeePayHistory', 
  @destination_owner = N'HumanResources', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_HumanResourcesEmployeePayHistory', 
  @del_cmd = N'CALL sp_MSdel_HumanResourcesEmployeePayHistory', 
  @upd_cmd = N'SCALL sp_MSupd_HumanResourcesEmployeePayHistory' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'ErrorLog', 
  @source_owner = N'dbo', 
  @source_object = N'ErrorLog', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'ErrorLog', 
  @destination_owner = N'dbo', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_dboErrorLog', 
  @del_cmd = N'CALL sp_MSdel_dboErrorLog', 
  @upd_cmd = N'SCALL sp_MSupd_dboErrorLog' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'Illustration', 
  @source_owner = N'Production', 
  @source_object = N'Illustration', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'Illustration', 
  @destination_owner = N'Production', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_ProductionIllustration', 
  @del_cmd = N'CALL sp_MSdel_ProductionIllustration', 
  @upd_cmd = N'SCALL sp_MSupd_ProductionIllustration' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'JobCandidate', 
  @source_owner = N'HumanResources', 
  @source_object = N'JobCandidate', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'JobCandidate', 
  @destination_owner = N'HumanResources', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_HumanResourcesJobCandidate', 
  @del_cmd = N'CALL sp_MSdel_HumanResourcesJobCandidate', 
  @upd_cmd = N'SCALL sp_MSupd_HumanResourcesJobCandidate' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'Location', 
  @source_owner = N'Production', 
  @source_object = N'Location', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'Location', 
  @destination_owner = N'Production', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_ProductionLocation', 
  @del_cmd = N'CALL sp_MSdel_ProductionLocation', 
  @upd_cmd = N'SCALL sp_MSupd_ProductionLocation' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'Password', 
  @source_owner = N'Person', 
  @source_object = N'Password', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'Password', 
  @destination_owner = N'Person', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_PersonPassword', 
  @del_cmd = N'CALL sp_MSdel_PersonPassword', 
  @upd_cmd = N'SCALL sp_MSupd_PersonPassword' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'Person', 
  @source_owner = N'Person', 
  @source_object = N'Person', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'Person', 
  @destination_owner = N'Person', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_PersonPerson', 
  @del_cmd = N'CALL sp_MSdel_PersonPerson', 
  @upd_cmd = N'SCALL sp_MSupd_PersonPerson' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'PersonCreditCard', 
  @source_owner = N'Sales', 
  @source_object = N'PersonCreditCard', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'PersonCreditCard', 
  @destination_owner = N'Sales', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_SalesPersonCreditCard', 
  @del_cmd = N'CALL sp_MSdel_SalesPersonCreditCard', 
  @upd_cmd = N'SCALL sp_MSupd_SalesPersonCreditCard' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'PersonPhone', 
  @source_owner = N'Person', 
  @source_object = N'PersonPhone', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'PersonPhone', 
  @destination_owner = N'Person', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_PersonPersonPhone', 
  @del_cmd = N'CALL sp_MSdel_PersonPersonPhone', 
  @upd_cmd = N'SCALL sp_MSupd_PersonPersonPhone' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'PhoneNumberType', 
  @source_owner = N'Person', 
  @source_object = N'PhoneNumberType', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'PhoneNumberType', 
  @destination_owner = N'Person', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_PersonPhoneNumberType', 
  @del_cmd = N'CALL sp_MSdel_PersonPhoneNumberType', 
  @upd_cmd = N'SCALL sp_MSupd_PersonPhoneNumberType' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'Product', 
  @source_owner = N'Production', 
  @source_object = N'Product', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'Product', 
  @destination_owner = N'Production', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_ProductionProduct', 
  @del_cmd = N'CALL sp_MSdel_ProductionProduct', 
  @upd_cmd = N'SCALL sp_MSupd_ProductionProduct' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'ProductCategory', 
  @source_owner = N'Production', 
  @source_object = N'ProductCategory', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'ProductCategory', 
  @destination_owner = N'Production', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_ProductionProductCategory', 
  @del_cmd = N'CALL sp_MSdel_ProductionProductCategory', 
  @upd_cmd = N'SCALL sp_MSupd_ProductionProductCategory' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'ProductCostHistory', 
  @source_owner = N'Production', 
  @source_object = N'ProductCostHistory', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'ProductCostHistory', 
  @destination_owner = N'Production', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_ProductionProductCostHistory', 
  @del_cmd = N'CALL sp_MSdel_ProductionProductCostHistory', 
  @upd_cmd = N'SCALL sp_MSupd_ProductionProductCostHistory' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'ProductDescription', 
  @source_owner = N'Production', 
  @source_object = N'ProductDescription', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'ProductDescription', 
  @destination_owner = N'Production', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_ProductionProductDescription', 
  @del_cmd = N'CALL sp_MSdel_ProductionProductDescription', 
  @upd_cmd = N'SCALL sp_MSupd_ProductionProductDescription' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'ProductDocument', 
  @source_owner = N'Production', 
  @source_object = N'ProductDocument', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'ProductDocument', 
  @destination_owner = N'Production', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_ProductionProductDocument', 
  @del_cmd = N'CALL sp_MSdel_ProductionProductDocument', 
  @upd_cmd = N'SCALL sp_MSupd_ProductionProductDocument' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'ProductInventory', 
  @source_owner = N'Production', 
  @source_object = N'ProductInventory', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'ProductInventory', 
  @destination_owner = N'Production', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_ProductionProductInventory', 
  @del_cmd = N'CALL sp_MSdel_ProductionProductInventory', 
  @upd_cmd = N'SCALL sp_MSupd_ProductionProductInventory' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'ProductListPriceHistory', 
  @source_owner = N'Production', 
  @source_object = N'ProductListPriceHistory', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'ProductListPriceHistory', 
  @destination_owner = N'Production', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_ProductionProductListPriceHistory', 
  @del_cmd = N'CALL sp_MSdel_ProductionProductListPriceHistory', 
  @upd_cmd = N'SCALL sp_MSupd_ProductionProductListPriceHistory' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'ProductModel', 
  @source_owner = N'Production', 
  @source_object = N'ProductModel', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'ProductModel', 
  @destination_owner = N'Production', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_ProductionProductModel', 
  @del_cmd = N'CALL sp_MSdel_ProductionProductModel', 
  @upd_cmd = N'SCALL sp_MSupd_ProductionProductModel' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'ProductModelIllustration', 
  @source_owner = N'Production', 
  @source_object = N'ProductModelIllustration', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'ProductModelIllustration', 
  @destination_owner = N'Production', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_ProductionProductModelIllustration', 
  @del_cmd = N'CALL sp_MSdel_ProductionProductModelIllustration', 
  @upd_cmd = N'SCALL sp_MSupd_ProductionProductModelIllustration' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'ProductModelProductDescriptionCulture', 
  @source_owner = N'Production', 
  @source_object = N'ProductModelProductDescriptionCulture', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'ProductModelProductDescriptionCulture', 
  @destination_owner = N'Production', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_ProductionProductModelProductDescriptionCulture', 
  @del_cmd = N'CALL sp_MSdel_ProductionProductModelProductDescriptionCulture', 
  @upd_cmd = N'SCALL sp_MSupd_ProductionProductModelProductDescriptionCulture' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'ProductPhoto', 
  @source_owner = N'Production', 
  @source_object = N'ProductPhoto', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'ProductPhoto', 
  @destination_owner = N'Production', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_ProductionProductPhoto', 
  @del_cmd = N'CALL sp_MSdel_ProductionProductPhoto', 
  @upd_cmd = N'SCALL sp_MSupd_ProductionProductPhoto' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'ProductProductPhoto', 
  @source_owner = N'Production', 
  @source_object = N'ProductProductPhoto', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'ProductProductPhoto', 
  @destination_owner = N'Production', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_ProductionProductProductPhoto', 
  @del_cmd = N'CALL sp_MSdel_ProductionProductProductPhoto', 
  @upd_cmd = N'SCALL sp_MSupd_ProductionProductProductPhoto' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'ProductReview', 
  @source_owner = N'Production', 
  @source_object = N'ProductReview', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'ProductReview', 
  @destination_owner = N'Production', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_ProductionProductReview', 
  @del_cmd = N'CALL sp_MSdel_ProductionProductReview', 
  @upd_cmd = N'SCALL sp_MSupd_ProductionProductReview' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'ProductSubcategory', 
  @source_owner = N'Production', 
  @source_object = N'ProductSubcategory', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'ProductSubcategory', 
  @destination_owner = N'Production', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_ProductionProductSubcategory', 
  @del_cmd = N'CALL sp_MSdel_ProductionProductSubcategory', 
  @upd_cmd = N'SCALL sp_MSupd_ProductionProductSubcategory' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'ProductVendor', 
  @source_owner = N'Purchasing', 
  @source_object = N'ProductVendor', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'ProductVendor', 
  @destination_owner = N'Purchasing', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_PurchasingProductVendor', 
  @del_cmd = N'CALL sp_MSdel_PurchasingProductVendor', 
  @upd_cmd = N'SCALL sp_MSupd_PurchasingProductVendor' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'PurchaseOrderDetail', 
  @source_owner = N'Purchasing', 
  @source_object = N'PurchaseOrderDetail', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'PurchaseOrderDetail', 
  @destination_owner = N'Purchasing', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_PurchasingPurchaseOrderDetail', 
  @del_cmd = N'CALL sp_MSdel_PurchasingPurchaseOrderDetail', 
  @upd_cmd = N'SCALL sp_MSupd_PurchasingPurchaseOrderDetail' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'PurchaseOrderHeader', 
  @source_owner = N'Purchasing', 
  @source_object = N'PurchaseOrderHeader', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'PurchaseOrderHeader', 
  @destination_owner = N'Purchasing', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_PurchasingPurchaseOrderHeader', 
  @del_cmd = N'CALL sp_MSdel_PurchasingPurchaseOrderHeader', 
  @upd_cmd = N'SCALL sp_MSupd_PurchasingPurchaseOrderHeader' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'SalesOrderDetail', 
  @source_owner = N'Sales', 
  @source_object = N'SalesOrderDetail', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'SalesOrderDetail', 
  @destination_owner = N'Sales', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_SalesSalesOrderDetail', 
  @del_cmd = N'CALL sp_MSdel_SalesSalesOrderDetail', 
  @upd_cmd = N'SCALL sp_MSupd_SalesSalesOrderDetail' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'SalesOrderHeader', 
  @source_owner = N'Sales', 
  @source_object = N'SalesOrderHeader', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'SalesOrderHeader', 
  @destination_owner = N'Sales', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_SalesSalesOrderHeader', 
  @del_cmd = N'CALL sp_MSdel_SalesSalesOrderHeader', 
  @upd_cmd = N'SCALL sp_MSupd_SalesSalesOrderHeader' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'SalesOrderHeaderSalesReason', 
  @source_owner = N'Sales', 
  @source_object = N'SalesOrderHeaderSalesReason', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'SalesOrderHeaderSalesReason', 
  @destination_owner = N'Sales', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_SalesSalesOrderHeaderSalesReason', 
  @del_cmd = N'CALL sp_MSdel_SalesSalesOrderHeaderSalesReason', 
  @upd_cmd = N'SCALL sp_MSupd_SalesSalesOrderHeaderSalesReason' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'SalesPerson', 
  @source_owner = N'Sales', 
  @source_object = N'SalesPerson', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'SalesPerson', 
  @destination_owner = N'Sales', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_SalesSalesPerson', 
  @del_cmd = N'CALL sp_MSdel_SalesSalesPerson', 
  @upd_cmd = N'SCALL sp_MSupd_SalesSalesPerson' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'SalesPersonQuotaHistory', 
  @source_owner = N'Sales', 
  @source_object = N'SalesPersonQuotaHistory', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'SalesPersonQuotaHistory', 
  @destination_owner = N'Sales', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_SalesSalesPersonQuotaHistory', 
  @del_cmd = N'CALL sp_MSdel_SalesSalesPersonQuotaHistory', 
  @upd_cmd = N'SCALL sp_MSupd_SalesSalesPersonQuotaHistory' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'SalesReason', 
  @source_owner = N'Sales', 
  @source_object = N'SalesReason', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'SalesReason', 
  @destination_owner = N'Sales', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_SalesSalesReason', 
  @del_cmd = N'CALL sp_MSdel_SalesSalesReason', 
  @upd_cmd = N'SCALL sp_MSupd_SalesSalesReason' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'SalesTaxRate', 
  @source_owner = N'Sales', 
  @source_object = N'SalesTaxRate', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'SalesTaxRate', 
  @destination_owner = N'Sales', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_SalesSalesTaxRate', 
  @del_cmd = N'CALL sp_MSdel_SalesSalesTaxRate', 
  @upd_cmd = N'SCALL sp_MSupd_SalesSalesTaxRate' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'SalesTerritory', 
  @source_owner = N'Sales', 
  @source_object = N'SalesTerritory', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'SalesTerritory', 
  @destination_owner = N'Sales', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_SalesSalesTerritory', 
  @del_cmd = N'CALL sp_MSdel_SalesSalesTerritory', 
  @upd_cmd = N'SCALL sp_MSupd_SalesSalesTerritory' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'SalesTerritoryHistory', 
  @source_owner = N'Sales', 
  @source_object = N'SalesTerritoryHistory', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'SalesTerritoryHistory', 
  @destination_owner = N'Sales', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_SalesSalesTerritoryHistory', 
  @del_cmd = N'CALL sp_MSdel_SalesSalesTerritoryHistory', 
  @upd_cmd = N'SCALL sp_MSupd_SalesSalesTerritoryHistory' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'ScrapReason', 
  @source_owner = N'Production', 
  @source_object = N'ScrapReason', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'ScrapReason', 
  @destination_owner = N'Production', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_ProductionScrapReason', 
  @del_cmd = N'CALL sp_MSdel_ProductionScrapReason', 
  @upd_cmd = N'SCALL sp_MSupd_ProductionScrapReason' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'Shift', 
  @source_owner = N'HumanResources', 
  @source_object = N'Shift', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'Shift', 
  @destination_owner = N'HumanResources', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_HumanResourcesShift', 
  @del_cmd = N'CALL sp_MSdel_HumanResourcesShift', 
  @upd_cmd = N'SCALL sp_MSupd_HumanResourcesShift' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'ShipMethod', 
  @source_owner = N'Purchasing', 
  @source_object = N'ShipMethod', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'ShipMethod', 
  @destination_owner = N'Purchasing', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_PurchasingShipMethod', 
  @del_cmd = N'CALL sp_MSdel_PurchasingShipMethod', 
  @upd_cmd = N'SCALL sp_MSupd_PurchasingShipMethod' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'ShoppingCartItem', 
  @source_owner = N'Sales', 
  @source_object = N'ShoppingCartItem', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'ShoppingCartItem', 
  @destination_owner = N'Sales', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_SalesShoppingCartItem', 
  @del_cmd = N'CALL sp_MSdel_SalesShoppingCartItem', 
  @upd_cmd = N'SCALL sp_MSupd_SalesShoppingCartItem' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'SpecialOffer', 
  @source_owner = N'Sales', 
  @source_object = N'SpecialOffer', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'SpecialOffer', 
  @destination_owner = N'Sales', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_SalesSpecialOffer', 
  @del_cmd = N'CALL sp_MSdel_SalesSpecialOffer', 
  @upd_cmd = N'SCALL sp_MSupd_SalesSpecialOffer' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'SpecialOfferProduct', 
  @source_owner = N'Sales', 
  @source_object = N'SpecialOfferProduct', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'SpecialOfferProduct', 
  @destination_owner = N'Sales', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_SalesSpecialOfferProduct', 
  @del_cmd = N'CALL sp_MSdel_SalesSpecialOfferProduct', 
  @upd_cmd = N'SCALL sp_MSupd_SalesSpecialOfferProduct' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'StateProvince', 
  @source_owner = N'Person', 
  @source_object = N'StateProvince', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'StateProvince', 
  @destination_owner = N'Person', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_PersonStateProvince', 
  @del_cmd = N'CALL sp_MSdel_PersonStateProvince', 
  @upd_cmd = N'SCALL sp_MSupd_PersonStateProvince' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'Store', 
  @source_owner = N'Sales', 
  @source_object = N'Store', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'Store', 
  @destination_owner = N'Sales', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_SalesStore', 
  @del_cmd = N'CALL sp_MSdel_SalesStore', 
  @upd_cmd = N'SCALL sp_MSupd_SalesStore' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'TransactionHistory', 
  @source_owner = N'Production', 
  @source_object = N'TransactionHistory', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'TransactionHistory', 
  @destination_owner = N'Production', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_ProductionTransactionHistory', 
  @del_cmd = N'CALL sp_MSdel_ProductionTransactionHistory', 
  @upd_cmd = N'SCALL sp_MSupd_ProductionTransactionHistory' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'TransactionHistoryArchive', 
  @source_owner = N'Production', 
  @source_object = N'TransactionHistoryArchive', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'TransactionHistoryArchive', 
  @destination_owner = N'Production', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_ProductionTransactionHistoryArchive', 
  @del_cmd = N'CALL sp_MSdel_ProductionTransactionHistoryArchive', 
  @upd_cmd = N'SCALL sp_MSupd_ProductionTransactionHistoryArchive' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'UnitMeasure', 
  @source_owner = N'Production', 
  @source_object = N'UnitMeasure', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'UnitMeasure', 
  @destination_owner = N'Production', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_ProductionUnitMeasure', 
  @del_cmd = N'CALL sp_MSdel_ProductionUnitMeasure', 
  @upd_cmd = N'SCALL sp_MSupd_ProductionUnitMeasure' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'Vendor', 
  @source_owner = N'Purchasing', 
  @source_object = N'Vendor', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'Vendor', 
  @destination_owner = N'Purchasing', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_PurchasingVendor', 
  @del_cmd = N'CALL sp_MSdel_PurchasingVendor', 
  @upd_cmd = N'SCALL sp_MSupd_PurchasingVendor' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'WorkOrder', 
  @source_owner = N'Production', 
  @source_object = N'WorkOrder', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'WorkOrder', 
  @destination_owner = N'Production', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_ProductionWorkOrder', 
  @del_cmd = N'CALL sp_MSdel_ProductionWorkOrder', 
  @upd_cmd = N'SCALL sp_MSupd_ProductionWorkOrder' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'WorkOrderRouting', 
  @source_owner = N'Production', 
  @source_object = N'WorkOrderRouting', 
  @type = N'logbased', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x000000000803509F, 
  @identityrangemanagementoption = N'manual', 
  @destination_table = N'WorkOrderRouting', 
  @destination_owner = N'Production', 
  @vertical_partition = N'false', 
  @ins_cmd = N'CALL sp_MSins_ProductionWorkOrderRouting', 
  @del_cmd = N'CALL sp_MSdel_ProductionWorkOrderRouting', 
  @upd_cmd = N'SCALL sp_MSupd_ProductionWorkOrderRouting' 

GO

EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'ufnGetAccountingEndDate', 
  @source_owner = N'dbo', 
  @source_object = N'ufnGetAccountingEndDate', 
  @type = N'func schema only', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x0000000008000001, 
  @destination_table = N'ufnGetAccountingEndDate', 
  @destination_owner = N'dbo' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'ufnGetAccountingStartDate', 
  @source_owner = N'dbo', 
  @source_object = N'ufnGetAccountingStartDate', 
  @type = N'func schema only', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x0000000008000001, 
  @destination_table = N'ufnGetAccountingStartDate', 
  @destination_owner = N'dbo' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'ufnGetContactInformation', 
  @source_owner = N'dbo', 
  @source_object = N'ufnGetContactInformation', 
  @type = N'func schema only', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x0000000008000001, 
  @destination_table = N'ufnGetContactInformation', 
  @destination_owner = N'dbo' 

GO

EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'ufnGetDocumentStatusText', 
  @source_owner = N'dbo', 
  @source_object = N'ufnGetDocumentStatusText', 
  @type = N'func schema only', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x0000000008000001, 
  @destination_table = N'ufnGetDocumentStatusText', 
  @destination_owner = N'dbo' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'ufnGetProductDealerPrice', 
  @source_owner = N'dbo', 
  @source_object = N'ufnGetProductDealerPrice', 
  @type = N'func schema only', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x0000000008000001, 
  @destination_table = N'ufnGetProductDealerPrice', 
  @destination_owner = N'dbo' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'ufnGetProductListPrice', 
  @source_owner = N'dbo', 
  @source_object = N'ufnGetProductListPrice', 
  @type = N'func schema only', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x0000000008000001, 
  @destination_table = N'ufnGetProductListPrice', 
  @destination_owner = N'dbo' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'ufnGetProductStandardCost', 
  @source_owner = N'dbo', 
  @source_object = N'ufnGetProductStandardCost', 
  @type = N'func schema only', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x0000000008000001, 
  @destination_table = N'ufnGetProductStandardCost', 
  @destination_owner = N'dbo' 

GO



EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'ufnGetPurchaseOrderStatusText', 
  @source_owner = N'dbo', 
  @source_object = N'ufnGetPurchaseOrderStatusText', 
  @type = N'func schema only', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x0000000008000001, 
  @destination_table = N'ufnGetPurchaseOrderStatusText', 
  @destination_owner = N'dbo' 

GO

EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'ufnGetSalesOrderStatusText', 
  @source_owner = N'dbo', 
  @source_object = N'ufnGetSalesOrderStatusText', 
  @type = N'func schema only', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x0000000008000001, 
  @destination_table = N'ufnGetSalesOrderStatusText', 
  @destination_owner = N'dbo' 

GO

EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'ufnGetStock', 
  @source_owner = N'dbo', 
  @source_object = N'ufnGetStock', 
  @type = N'func schema only', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x0000000008000001, 
  @destination_table = N'ufnGetStock', 
  @destination_owner = N'dbo' 

GO

EXEC sp_addarticle 
  @publication = "$(PublicationName)", 
  @article = N'ufnLeadingZeros', 
  @source_owner = N'dbo', 
  @source_object = N'ufnLeadingZeros', 
  @type = N'func schema only', 
  @description = NULL, 
  @creation_script = NULL, 
  @pre_creation_cmd = N'drop', 
  @schema_option = 0x0000000008000001, 
  @destination_table = N'ufnLeadingZeros', 
  @destination_owner = N'dbo' 

GO

-- Start the snapshot agent job so as to generate the snapshot.
-- This will cause the subscriber to sync immediately (if this option is selected when
-- creating the subscriber)
-- Get the snapshot agent job name from the distribution database

DECLARE @jobname NVARCHAR(200)
SELECT @jobname=name FROM [distribution].[dbo].[MSsnapshot_agents]
WHERE [publication]='$(PublicationName)' AND [publisher_db]='$(DatabaseName)'

Print 'Starting Snapshot Agent ' + @jobname + '....'

-- Start the snapshot agent to generate the snapshot
-- The snapshot is picked up and applied to the subscriber by the distribution agent
EXECUTE msdb.dbo.sp_start_job @job_name=@jobname

