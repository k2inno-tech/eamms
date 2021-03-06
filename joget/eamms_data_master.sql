SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[app_fd_eamms_condition_hw]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[app_fd_eamms_condition_hw](
	[id] [varchar](30) NOT NULL,
	[name] [varchar](50) NULL,
	[description] [varchar](255) NULL,
	[active] [varchar](1) NULL,
	[createdBy] [varchar](250) NULL,
	[dateCreated] [datetime] NULL,
 CONSTRAINT [PK__app_fd_eamms_con__32767D0B] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[app_fd_eamms_category_hw]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[app_fd_eamms_category_hw](
	[id] [varchar](30) NOT NULL,
	[name] [varchar](50) NULL,
	[description] [varchar](255) NULL,
	[active] [varchar](1) NULL,
	[createdBy] [varchar](250) NULL,
	[dateCreated] [datetime] NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[app_fd_eamms_status_hw]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[app_fd_eamms_status_hw](
	[id] [varchar](30) NOT NULL,
	[name] [varchar](50) NULL,
	[description] [varchar](255) NULL,
	[active] [varchar](1) NULL,
	[createdBy] [varchar](250) NULL,
	[dateCreated] [datetime] NULL
) ON [PRIMARY]
END



insert into app_fd_eamms_condition_hw (id, name, active) values ('1', 'Great', '1');
insert into app_fd_eamms_condition_hw (id, name, active) values ('2', 'Good', '1');
insert into app_fd_eamms_condition_hw (id, name, active) values ('3', 'Satisfactory', '1');
insert into app_fd_eamms_condition_hw (id, name, active) values ('4', 'Poor', '1');
insert into app_fd_eamms_condition_hw (id, name, active) values ('5', 'Down', '1');

insert into app_fd_eamms_category_hw (id, name, active) values ('1', 'Tools', '1');
insert into app_fd_eamms_category_hw (id, name, active) values ('2', 'Equipment', '1');

insert into app_fd_eamms_status_hw (id, name, active) values ('1', 'Active', '1');
insert into app_fd_eamms_status_hw (id, name, active) values ('2', 'In Use', '1');
insert into app_fd_eamms_status_hw (id, name, active) values ('3', 'Rent Out', '1');
insert into app_fd_eamms_status_hw (id, name, active) values ('4', 'Inactive', '1');
insert into app_fd_eamms_status_hw (id, name, active) values ('5', 'Write Off', '1');
insert into app_fd_eamms_status_hw (id, name, active) values ('6', 'Faulty', '1');
insert into app_fd_eamms_status_hw (id, name, active) values ('1', 'Great', '1');


