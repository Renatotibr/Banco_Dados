USE [HTAF]
GO

/****** Object:  Table [dbo].[01010e]    Script Date: 18/11/2021 09:07:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[01010e](
	[C01_FILIAL] [varchar](5) NOT NULL,
	[C01_ID] [varchar](6) NOT NULL,
	[C01_CODIGO] [varchar](2) NOT NULL,
	[C01_DESCRI] [varchar](220) NOT NULL,
	[C01_VALIDA] [varchar](8) NOT NULL,
	[D_E_L_E_T_] [varchar](1) NOT NULL,
	[R_E_C_N_O_] [int] IDENTITY(1,1) NOT NULL,
	[R_E_C_D_E_L_] [int] NOT NULL,
 CONSTRAINT [01010e_PK] PRIMARY KEY CLUSTERED 
(
	[R_E_C_N_O_] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[01010e] ADD  CONSTRAINT [01010e_C01_FILIAL_DF]  DEFAULT ('     ') FOR [C01_FILIAL]
GO

ALTER TABLE [dbo].[01010e] ADD  CONSTRAINT [01010e_C01_ID_DF]  DEFAULT ('      ') FOR [C01_ID]
GO

ALTER TABLE [dbo].[01010e] ADD  CONSTRAINT [01010e_C01_CODIGO_DF]  DEFAULT ('  ') FOR [C01_CODIGO]
GO

ALTER TABLE [dbo].[01010e] ADD  CONSTRAINT [01010e_C01_DESCRI_DF]  DEFAULT ('                                                                                                                                                                                                                            ') FOR [C01_DESCRI]
GO

ALTER TABLE [dbo].[01010e] ADD  CONSTRAINT [01010e_C01_VALIDA_DF]  DEFAULT ('        ') FOR [C01_VALIDA]
GO

ALTER TABLE [dbo].[01010e] ADD  CONSTRAINT [01010e_D_E_L_E_T__DF]  DEFAULT (' ') FOR [D_E_L_E_T_]
GO

ALTER TABLE [dbo].[01010e] ADD  CONSTRAINT [01010e_R_E_C_D_E_L__DF]  DEFAULT ((0)) FOR [R_E_C_D_E_L_]
GO


