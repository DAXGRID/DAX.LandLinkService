-- Notice if this database does not exist, then create it
Use LandLinkTest
GO

CREATE SCHEMA [Fiber]
GO

CREATE SCHEMA [Survey]
GO


-------------------------------------------------------------------------------------------------
-- Survey Point
-------------------------------------------------------------------------------------------------
DROP TABLE [Survey].[SurveyPoint]
GO

CREATE TABLE [Survey].[SurveyPoint] (
	[id] [int] IDENTITY(1,1) NOT NULL,
	geom [geometry] NOT NULL,
	SurveyPointId varchar(max),
	SurveyJobName varchar(max),
	SurveyProjectName varchar(max),
	SurveyImportedDate datetime,
	SurveyImportedBy varchar(max),
	SurveyMeasuredDate datetime,
	SurveyX float,
	SurveyY float,
	SurveyZ float,
	SurveyPrecisionXY float,
	SurveyPrecisionZ float
 CONSTRAINT [pk_surveypoint] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE SPATIAL INDEX [survey_surveypoint_sidx] ON [Survey].[SurveyPoint] (geom) 
USING  GEOMETRY_GRID WITH (BOUNDING_BOX =(400000, 6000000, 900000, 6450000), GRIDS =(LEVEL_1 = MEDIUM,LEVEL_2 = MEDIUM,LEVEL_3 = MEDIUM,LEVEL_4 = MEDIUM), CELLS_PER_OBJECT = 16) 
ON [PRIMARY]
GO


-------------------------------------------------------------------------------------------------
-- Survey Fiber Conduit
-------------------------------------------------------------------------------------------------
DROP TABLE [Survey].[FiberConduit]
GO

CREATE TABLE [Survey].[FiberConduit] (
	[id] [int] IDENTITY(1,1) NOT NULL,
	geom [geometry] NOT NULL,
	SurveyJobName varchar(max),
	SurveyProjectName varchar(max),
	SurveyImportedDate datetime,
	SurveyImportedBy varchar(max),
	SurveyMeasuredDate datetime,
	SurveyPrecisionXY float,
	SurveyPrecisionZ float,
	ConduitCategory varchar(max),
	ManufacturerType varchar(max),
 CONSTRAINT [pk_survey_fiberconduit] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE SPATIAL INDEX [survey_fiberconduit_sidx] ON [Survey].[FiberConduit] (geom) 
USING  GEOMETRY_GRID WITH (BOUNDING_BOX =(400000, 6000000, 900000, 6450000), GRIDS =(LEVEL_1 = MEDIUM,LEVEL_2 = MEDIUM,LEVEL_3 = MEDIUM,LEVEL_4 = MEDIUM), CELLS_PER_OBJECT = 16) 
ON [PRIMARY]
GO


-------------------------------------------------------------------------------------------------
-- Survey Fiber Cable
-------------------------------------------------------------------------------------------------
DROP TABLE [Survey].[FiberCable]
GO

CREATE TABLE [Survey].[FiberCable] (
	[id] [int] IDENTITY(1,1) NOT NULL,
	geom [geometry] NOT NULL,
	SurveyJobName varchar(max),
	SurveyProjectName varchar(max),
	SurveyImportedDate datetime,
	SurveyImportedBy varchar(max),
	SurveyMeasuredDate datetime,
	SurveyPrecisionXY float,
	SurveyPrecisionZ float,
	ConduitCategory varchar(max),
	ManufacturerType varchar(max),
 CONSTRAINT [pk_survey_fibercable] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE SPATIAL INDEX [survey_fibercable_sidx] ON [Survey].[FiberCable] (geom) 
USING  GEOMETRY_GRID WITH (BOUNDING_BOX =(400000, 6000000, 900000, 6450000), GRIDS =(LEVEL_1 = MEDIUM,LEVEL_2 = MEDIUM,LEVEL_3 = MEDIUM,LEVEL_4 = MEDIUM), CELLS_PER_OBJECT = 16) 
ON [PRIMARY]
GO

-------------------------------------------------------------------------------------------------
-- Survey Fiber Well
-------------------------------------------------------------------------------------------------
DROP TABLE [Survey].[FiberWell]
GO

CREATE TABLE [Survey].[FiberWell] (
	[id] [int] IDENTITY(1,1) NOT NULL,
	geom [geometry] NOT NULL,
	SurveyJobName varchar(max),
	SurveyProjectName varchar(max),
	SurveyImportedDate datetime,
	SurveyImportedBy varchar(max),
	SurveyMeasuredDate datetime,
	SurveyPrecisionXY float,
	SurveyPrecisionZ float,
	ConduitCategory varchar(max),
	ManufacturerType varchar(max),
 CONSTRAINT [pk_survey_fiberwell] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE SPATIAL INDEX [survey_fiberwell_sidx] ON [Survey].[FiberWell] (geom) 
USING  GEOMETRY_GRID WITH (BOUNDING_BOX =(400000, 6000000, 900000, 6450000), GRIDS =(LEVEL_1 = MEDIUM,LEVEL_2 = MEDIUM,LEVEL_3 = MEDIUM,LEVEL_4 = MEDIUM), CELLS_PER_OBJECT = 16) 
ON [PRIMARY]
GO



-------------------------------------------------------------------------------------------------
-- Fiber Conduit
-------------------------------------------------------------------------------------------------
DROP TABLE [Fiber].[Conduit]
GO

CREATE TABLE [Fiber].[Conduit] (
	[id] [int] IDENTITY(1,1) NOT NULL,
	geom [geometry] NOT NULL,
	SurveyJobName varchar(max),
	SurveyProjectName varchar(max),
	SurveyImportedDate datetime,
	SurveyImportedBy varchar(max),
	SurveyMeasuredDate datetime,	
	ConduitCategory varchar(max),
	ManufacturerType varchar(max),
 CONSTRAINT [pk_Fiber_fiberconduit] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE SPATIAL INDEX [Fiber_fiberconduit_sidx] ON [Fiber].[Conduit] (geom) 
USING  GEOMETRY_GRID WITH (BOUNDING_BOX =(400000, 6000000, 900000, 6450000), GRIDS =(LEVEL_1 = MEDIUM,LEVEL_2 = MEDIUM,LEVEL_3 = MEDIUM,LEVEL_4 = MEDIUM), CELLS_PER_OBJECT = 16) 
ON [PRIMARY]
GO


-------------------------------------------------------------------------------------------------
-- Fiber Cable
-------------------------------------------------------------------------------------------------
DROP TABLE [Fiber].[Cable]
GO

CREATE TABLE [Fiber].[Cable] (
	[id] [int] IDENTITY(1,1) NOT NULL,
	geom [geometry] NOT NULL,
	SurveyJobName varchar(max),
	SurveyProjectName varchar(max),
	SurveyImportedDate datetime,
	SurveyImportedBy varchar(max),
	SurveyMeasuredDate datetime,	ConduitCategory varchar(max),
	ManufacturerType varchar(max),
 CONSTRAINT [pk_Fiber_fibercable] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE SPATIAL INDEX [Fiber_fibercable_sidx] ON [Fiber].[Cable] (geom) 
USING  GEOMETRY_GRID WITH (BOUNDING_BOX =(400000, 6000000, 900000, 6450000), GRIDS =(LEVEL_1 = MEDIUM,LEVEL_2 = MEDIUM,LEVEL_3 = MEDIUM,LEVEL_4 = MEDIUM), CELLS_PER_OBJECT = 16) 
ON [PRIMARY]
GO

-------------------------------------------------------------------------------------------------
-- Fiber Well
-------------------------------------------------------------------------------------------------
DROP TABLE [Fiber].[Well]
GO

CREATE TABLE [Fiber].[Well] (
	[id] [int] IDENTITY(1,1) NOT NULL,
	geom [geometry] NOT NULL,
	SurveyJobName varchar(max),
	SurveyProjectName varchar(max),
	SurveyImportedDate datetime,
	SurveyImportedBy varchar(max),
	SurveyMeasuredDate datetime,	ConduitCategory varchar(max),
	ManufacturerType varchar(max),
 CONSTRAINT [pk_Fiber_fiberwell] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE SPATIAL INDEX [Fiber_fiberwell_sidx] ON [Fiber].[Well] (geom) 
USING  GEOMETRY_GRID WITH (BOUNDING_BOX =(400000, 6000000, 900000, 6450000), GRIDS =(LEVEL_1 = MEDIUM,LEVEL_2 = MEDIUM,LEVEL_3 = MEDIUM,LEVEL_4 = MEDIUM), CELLS_PER_OBJECT = 16) 
ON [PRIMARY]
GO