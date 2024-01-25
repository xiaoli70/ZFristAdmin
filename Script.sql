USE [master]
GO
/****** Object:  Database [AdminDb]    Script Date: 2024/1/25 9:40:21 ******/
CREATE DATABASE [AdminDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AdminDb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER2022\MSSQL\DATA\AdminDb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AdminDb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER2022\MSSQL\DATA\AdminDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [AdminDb] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AdminDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AdminDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AdminDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AdminDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AdminDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AdminDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [AdminDb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AdminDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AdminDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AdminDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AdminDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AdminDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AdminDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AdminDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AdminDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AdminDb] SET  ENABLE_BROKER 
GO
ALTER DATABASE [AdminDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AdminDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AdminDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AdminDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AdminDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AdminDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AdminDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AdminDb] SET RECOVERY FULL 
GO
ALTER DATABASE [AdminDb] SET  MULTI_USER 
GO
ALTER DATABASE [AdminDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AdminDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AdminDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AdminDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [AdminDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [AdminDb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'AdminDb', N'ON'
GO
ALTER DATABASE [AdminDb] SET QUERY_STORE = ON
GO
ALTER DATABASE [AdminDb] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [AdminDb]
GO
/****** Object:  Table [dbo].[Menu]    Script Date: 2024/1/25 9:40:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Menu](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[Index] [varchar](200) NOT NULL,
	[FilePath] [varchar](200) NOT NULL,
	[ParentId] [bigint] NOT NULL,
	[Order] [int] NOT NULL,
	[IsEnable] [bit] NOT NULL,
	[Description] [varchar](200) NULL,
	[CreateUserId] [bigint] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModifyUserId] [bigint] NULL,
	[ModifyDate] [datetime] NULL,
	[IsDeleted] [int] NOT NULL,
 CONSTRAINT [PK_Menu_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MenuRoleRelation]    Script Date: 2024/1/25 9:40:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenuRoleRelation](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[MenuId] [bigint] NOT NULL,
	[RoleId] [bigint] NOT NULL,
 CONSTRAINT [PK_MenuRoleRelation_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OperationLog]    Script Date: 2024/1/25 9:40:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OperationLog](
	[Id] [bigint] NOT NULL,
	[Title] [varchar](255) NOT NULL,
	[OperType] [int] NOT NULL,
	[RequestMethod] [varchar](255) NOT NULL,
	[OperUser] [varchar](255) NOT NULL,
	[OperIp] [varchar](255) NOT NULL,
	[OperLocation] [varchar](255) NOT NULL,
	[Method] [varchar](255) NOT NULL,
	[RequestParam] [varchar](255) NOT NULL,
	[RequestResult] [varchar](max) NOT NULL,
	[CreationTime] [datetime] NOT NULL,
	[CreatorId] [bigint] NOT NULL,
 CONSTRAINT [PK_OperationLog_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 2024/1/25 9:40:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[Order] [int] NOT NULL,
	[IsEnable] [bit] NOT NULL,
	[Description] [varchar](200) NULL,
	[CreateUserId] [bigint] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModifyUserId] [bigint] NULL,
	[ModifyDate] [datetime] NULL,
	[IsDeleted] [int] NOT NULL,
 CONSTRAINT [PK_Role_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[String]    Script Date: 2024/1/25 9:40:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[String](
	[Chars] [varchar](1) NOT NULL,
	[Length] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoleRelation]    Script Date: 2024/1/25 9:40:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoleRelation](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[RoleId] [bigint] NOT NULL,
 CONSTRAINT [PK_UserRoleRelation_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 2024/1/25 9:40:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[NickName] [varchar](200) NOT NULL,
	[Password] [varchar](200) NOT NULL,
	[UserType] [int] NOT NULL,
	[IsEnable] [bit] NOT NULL,
	[Description] [varchar](200) NULL,
	[CreateUserId] [bigint] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModifyUserId] [bigint] NULL,
	[ModifyDate] [datetime] NULL,
	[IsDeleted] [int] NOT NULL,
 CONSTRAINT [PK_Users_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Menu] ON 

INSERT [dbo].[Menu] ([Id], [Name], [Index], [FilePath], [ParentId], [Order], [IsEnable], [Description], [CreateUserId], [CreateDate], [ModifyUserId], [ModifyDate], [IsDeleted]) VALUES (1, N'菜单管理', N'menumanager', N'../view/admin/menu/MenuManager', 0, 0, 1, N'数据库初始化时默认添加的默认菜单', 3, CAST(N'2023-11-27T10:12:14.410' AS DateTime), 3, CAST(N'2023-11-27T11:02:46.733' AS DateTime), 0)
INSERT [dbo].[Menu] ([Id], [Name], [Index], [FilePath], [ParentId], [Order], [IsEnable], [Description], [CreateUserId], [CreateDate], [ModifyUserId], [ModifyDate], [IsDeleted]) VALUES (2, N'用户管理', N'Personmanager', N'../view/admin/person/PersonManager', 0, 0, 1, N'数据库初始化时默认添加的默认菜单', 3, CAST(N'2023-11-27T10:12:14.410' AS DateTime), 0, NULL, 0)
INSERT [dbo].[Menu] ([Id], [Name], [Index], [FilePath], [ParentId], [Order], [IsEnable], [Description], [CreateUserId], [CreateDate], [ModifyUserId], [ModifyDate], [IsDeleted]) VALUES (4, N'角色管理', N'rolemanager', N'../view/admin/role/RoleManager', 0, 0, 1, N'数据库初始化时默认添加的默认菜单', 3, CAST(N'2023-11-27T14:49:44.557' AS DateTime), 0, NULL, 0)
SET IDENTITY_INSERT [dbo].[Menu] OFF
GO
SET IDENTITY_INSERT [dbo].[MenuRoleRelation] ON 

INSERT [dbo].[MenuRoleRelation] ([Id], [MenuId], [RoleId]) VALUES (1, 2, 1)
SET IDENTITY_INSERT [dbo].[MenuRoleRelation] OFF
GO
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1731922188380016640, N's', 4, N'GET', N'222', N'127.0.0.1', N'192.168.0.102', N'/api/Role/GetRole', N'1', N'{"IsSuccess":true,"Result":{"Id":1,"Name":"QAadmin","Order":99,"IsEnable":true,"Description":"权限管理","CreateUserId":"3","CreateDate":"2023-11-27T14:50:37.98","ModifyUserId":"0","ModifyDate":null,"IsDeleted":0},"Msg":null}', CAST(N'2023-12-05T14:23:22.923' AS DateTime), 112515)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1742017338556944384, N'获取角色', 9, N'GET', N'admin', N'127.0.0.1', N'192.168.0.102', N'/api/Role/GetRole', N'1', N'{"IsSuccess":true,"Result":{"Id":1,"Name":"QAadmin","Order":99,"IsEnable":true,"Description":"权限管理","CreateUserId":"3","CreateDate":"2023-11-27T14:50:37.98","ModifyUserId":"0","ModifyDate":null,"IsDeleted":0},"Msg":null}', CAST(N'2024-01-02T10:57:53.287' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1742376432006467584, N'登录', 3, N'GET', N'admin', N'127.0.0.1', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":true,"Result":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjMiLCJOaWNrTmFtZSI6IueCkum4oeeuoeeQhuWRmCIsIk5hbWUiOiJhZG1pbiIsIlVzZXJUeXBlIjoiMCIsImV4cCI6MTcwNDI1MDQ3NSwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0In0.-UURBJXGLad6CwmyN3eKToVGidNT_CGntEV1ppVSHCE","Msg":null}', CAST(N'2024-01-03T10:44:56.933' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1742381330592829440, N'登录', 3, N'GET', N'admin', N'127.0.0.1', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":true,"Result":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjMiLCJOaWNrTmFtZSI6IueCkum4oeeuoeeQhuWRmCIsIk5hbWUiOiJhZG1pbiIsIlVzZXJUeXBlIjoiMCIsImV4cCI6MTcwNDI1MTY1NSwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0In0.y6uYvz7L6gKmvhx-FylydVPcrf67QnY2zJna4Jz_u0s","Msg":null}', CAST(N'2024-01-03T11:04:15.753' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1742383781387571200, N'登录', 3, N'GET', N'admin', N'127.0.0.1', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":true,"Result":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjMiLCJOaWNrTmFtZSI6IueCkum4oeeuoeeQhuWRmCIsIk5hbWUiOiJhZG1pbiIsIlVzZXJUeXBlIjoiMCIsImV4cCI6MTcwNDI1MjIzOSwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0In0.0u1k2LRW3By8itqkGNRs87jj8cocyJYhXlA0S6YDdus","Msg":null}', CAST(N'2024-01-03T11:14:00.067' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1742386106567102464, N'登录', 3, N'GET', N'admin', N'127.0.0.1', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":true,"Result":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjMiLCJOaWNrTmFtZSI6IueCkum4oeeuoeeQhuWRmCIsIk5hbWUiOiJhZG1pbiIsIlVzZXJUeXBlIjoiMCIsImV4cCI6MTcwNDI1Mjc5MywiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0In0.BMydw2kBR9oObs6Eg2S037MfFegw42VILipFvhVFOwQ","Msg":null}', CAST(N'2024-01-03T11:23:14.433' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1742387535037992960, N'登录', 3, N'GET', N'admin', N'127.0.0.1', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":true,"Result":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjMiLCJOaWNrTmFtZSI6IueCkum4oeeuoeeQhuWRmCIsIk5hbWUiOiJhZG1pbiIsIlVzZXJUeXBlIjoiMCIsImV4cCI6MTcwNDI1MzEzNCwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0In0.IK1sT33GlW9uHxu87Duc5E4pAYdEmB-oKdCo4Q7nKi8","Msg":null}', CAST(N'2024-01-03T11:28:55.007' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1742389364740198400, N'登录', 3, N'GET', N'admin', N'127.0.0.1', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":true,"Result":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjMiLCJOaWNrTmFtZSI6IueCkum4oeeuoeeQhuWRmCIsIk5hbWUiOiJhZG1pbiIsIlVzZXJUeXBlIjoiMCIsImV4cCI6MTcwNDI1MzU3MCwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0In0.ar1DDIIEcLUq8D_brjkkUuwOlwD3TP9haVFUQ3eXRBQ","Msg":null}', CAST(N'2024-01-03T11:36:11.243' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1742389692416004096, N'登录', 3, N'GET', N'admin', N'127.0.0.1', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":true,"Result":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjMiLCJOaWNrTmFtZSI6IueCkum4oeeuoeeQhuWRmCIsIk5hbWUiOiJhZG1pbiIsIlVzZXJUeXBlIjoiMCIsImV4cCI6MTcwNDI1MzY0OCwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0In0.weU-wnjYGzqtb4zvt2TM31tqYX8PJS_T9-Jxt5U_SVA","Msg":null}', CAST(N'2024-01-03T11:37:29.367' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1742391868924235776, N'登录', 3, N'GET', N'admin', N'127.0.0.1', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":true,"Result":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjMiLCJOaWNrTmFtZSI6IueCkum4oeeuoeeQhuWRmCIsIk5hbWUiOiJhZG1pbiIsIlVzZXJUeXBlIjoiMCIsImV4cCI6MTcwNDI1NDE2NywiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0In0.py2D4WmfFWt25IWNnHhvSWL5G9FHrARMYFT5UNPT44I","Msg":null}', CAST(N'2024-01-03T11:46:08.287' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1742392609135005696, N'登录', 3, N'GET', N'admin', N'127.0.0.1', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":true,"Result":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjMiLCJOaWNrTmFtZSI6IueCkum4oeeuoeeQhuWRmCIsIk5hbWUiOiJhZG1pbiIsIlVzZXJUeXBlIjoiMCIsImV4cCI6MTcwNDI1NDM0NCwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0In0.pywFWhdkbsxBS7eo0m8UHfCOrAxKPfuK02vAJWREpoE","Msg":null}', CAST(N'2024-01-03T11:49:04.767' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1742394395266781184, N'登录', 3, N'GET', N'admin', N'127.0.0.1', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":true,"Result":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjMiLCJOaWNrTmFtZSI6IueCkum4oeeuoeeQhuWRmCIsIk5hbWUiOiJhZG1pbiIsIlVzZXJUeXBlIjoiMCIsImV4cCI6MTcwNDI1NDc3MCwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0In0._bWujfKHKw9xWeoz459ISldpPrs_o8rmKXGnO8omfXg","Msg":null}', CAST(N'2024-01-03T11:56:10.613' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1742394697239891968, N'获取角色', 9, N'GET', N'admin', N'127.0.0.1', N'', N'/api/Role/GetRole', N'1', N'{"IsSuccess":true,"Result":{"Id":1,"Name":"QAadmin","Order":99,"IsEnable":true,"Description":"权限管理","CreateUserId":"3","CreateDate":"2023-11-27T14:50:37.98","ModifyUserId":"0","ModifyDate":null,"IsDeleted":0},"Msg":null}', CAST(N'2024-01-03T11:57:22.607' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1742395549358886912, N'登录', 3, N'GET', N'admin1', N'127.0.0.1', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":true,"Result":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjQiLCJOaWNrTmFtZSI6IkxZSyIsIk5hbWUiOiJhZG1pbjEiLCJVc2VyVHlwZSI6IjEiLCJleHAiOjE3MDQyNTUwNDUsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTI5NCIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTI5NCJ9.v_sbBT0eJWDsiSjjPjx9zYUpRmzbikeiunwv6J1JRgA","Msg":null}', CAST(N'2024-01-03T12:00:45.767' AS DateTime), 4)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1742395815969820672, N'登录', 3, N'GET', N'admin1', N'127.0.0.1', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":true,"Result":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjQiLCJOaWNrTmFtZSI6IkxZSyIsIk5hbWUiOiJhZG1pbjEiLCJVc2VyVHlwZSI6IjEiLCJleHAiOjE3MDQyNTUxMDksImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTI5NCIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTI5NCJ9.zLcseVflx2nx8jR0aZmqkVshK8cl54FND3FvkCqogiQ","Msg":null}', CAST(N'2024-01-03T12:01:49.333' AS DateTime), 4)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1742396093112651776, N'登录', 3, N'GET', N'admin1', N'127.0.0.1', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":true,"Result":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjQiLCJOaWNrTmFtZSI6IkxZSyIsIk5hbWUiOiJhZG1pbjEiLCJVc2VyVHlwZSI6IjEiLCJleHAiOjE3MDQyNTUxNTIsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTI5NCIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTI5NCJ9.EzSDLh03cqKM9apqfUrQWxSJGlkTrRynNZR76xKeFzg","Msg":null}', CAST(N'2024-01-03T12:03:15.860' AS DateTime), 4)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1743092248188424192, N'登录', 3, N'GET', N'admin', N'127.0.0.1', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":true,"Result":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjMiLCJOaWNrTmFtZSI6IueCkum4oeeuoeeQhuWRmCIsIk5hbWUiOiJhZG1pbiIsIlVzZXJUeXBlIjoiMCIsImV4cCI6MTcwNDQyMTE1MSwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0In0.YUP7p5sS53jTywn4tY063YlT2QUNAm_2UChs4fTrNdc","Msg":null}', CAST(N'2024-01-05T10:09:11.713' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1743092842642935808, N'获取角色', 9, N'GET', N'admin', N'127.0.0.1', N'', N'/api/Role/GetRole', N'1', N'{"IsSuccess":true,"Result":{"Id":1,"Name":"QAadmin","Order":99,"IsEnable":true,"Description":"权限管理","CreateUserId":"3","CreateDate":"2023-11-27T14:50:37.98","ModifyUserId":"0","ModifyDate":null,"IsDeleted":0},"Msg":null}', CAST(N'2024-01-05T10:11:33.443' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1743104722438590464, N'登录', 3, N'GET', N'admin', N'127.0.0.1', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":true,"Result":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjMiLCJOaWNrTmFtZSI6IueCkum4oeeuoeeQhuWRmCIsIk5hbWUiOiJhZG1pbiIsIlVzZXJUeXBlIjoiMCIsImV4cCI6MTcwNDQyNDEyNSwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0In0.fMcefIgLivlUhWaKHgF1J2zhMMU_BZoPBbZga_hHWRc","Msg":null}', CAST(N'2024-01-05T10:58:45.807' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1743104796581302272, N'登录', 3, N'GET', N'admin', N'127.0.0.1', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":true,"Result":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjMiLCJOaWNrTmFtZSI6IueCkum4oeeuoeeQhuWRmCIsIk5hbWUiOiJhZG1pbiIsIlVzZXJUeXBlIjoiMCIsImV4cCI6MTcwNDQyNDE0MywiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0In0.A5arZhou-hDcpqRZPWrTPHwjDHliek9J70ZVYDG8_dQ","Msg":null}', CAST(N'2024-01-05T10:59:03.483' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1743105536569774080, N'登录', 3, N'GET', N'admin', N'127.0.0.1', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":true,"Result":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjMiLCJOaWNrTmFtZSI6IueCkum4oeeuoeeQhuWRmCIsIk5hbWUiOiJhZG1pbiIsIlVzZXJUeXBlIjoiMCIsImV4cCI6MTcwNDQyNDMxOSwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0In0.wc7dpHAe1OGPeg8l9P7tFoytEvLnxADZrcZhvcTZ0CM","Msg":null}', CAST(N'2024-01-05T11:01:59.910' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1743105815805562880, N'登录', 3, N'GET', N'admin', N'127.0.0.1', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":true,"Result":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjMiLCJOaWNrTmFtZSI6IueCkum4oeeuoeeQhuWRmCIsIk5hbWUiOiJhZG1pbiIsIlVzZXJUeXBlIjoiMCIsImV4cCI6MTcwNDQyNDM4NiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0In0.moxqk1NqhAtcCzOsK_uN5HmqQmyhaO93qYnEu4YHXkI","Msg":null}', CAST(N'2024-01-05T11:03:06.487' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1743106020743450624, N'登录', 3, N'GET', N'admin', N'127.0.0.1', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":true,"Result":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjMiLCJOaWNrTmFtZSI6IueCkum4oeeuoeeQhuWRmCIsIk5hbWUiOiJhZG1pbiIsIlVzZXJUeXBlIjoiMCIsImV4cCI6MTcwNDQyNDQzNCwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0In0.5XfDaj2ecGVoRfZMrOycOb8tJZFFYjipyI6MSPD66so","Msg":null}', CAST(N'2024-01-05T11:03:55.347' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1743106259516788736, N'登录', 3, N'GET', N'admin', N'127.0.0.1', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":true,"Result":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjMiLCJOaWNrTmFtZSI6IueCkum4oeeuoeeQhuWRmCIsIk5hbWUiOiJhZG1pbiIsIlVzZXJUeXBlIjoiMCIsImV4cCI6MTcwNDQyNDQ5MSwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0In0._puJKdt0FVraYOmnbzkxD8ll_HirUU4tSQd7h9dFtBA","Msg":null}', CAST(N'2024-01-05T11:04:52.277' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1743112506441863168, N'登录', 3, N'GET', N'admin', N'192.168.1.102', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":true,"Result":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjMiLCJOaWNrTmFtZSI6IueCkum4oeeuoeeQhuWRmCIsIk5hbWUiOiJhZG1pbiIsIlVzZXJUeXBlIjoiMCIsImV4cCI6MTcwNDQyNTk4MSwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0In0.h3JSpAT9Hadzh9D0IX6qIWWmKvQW09pfJHVYy9NOvt8","Msg":null}', CAST(N'2024-01-05T11:29:41.657' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1743125476945301504, N'登录', 3, N'GET', N'admin', N'192.168.1.102', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":true,"Result":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjMiLCJOaWNrTmFtZSI6IueCkum4oeeuoeeQhuWRmCIsIk5hbWUiOiJhZG1pbiIsIlVzZXJUeXBlIjoiMCIsImV4cCI6MTcwNDQyOTA3MywiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0In0.7CmF7HbtxlfxO3wUsAfkVgT37VI0sJtOeUZ9BhbLSXY","Msg":null}', CAST(N'2024-01-05T12:21:14.067' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1743125765765074944, N'登录', 3, N'GET', N'admin', N'192.168.1.102', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":false,"Result":null,"Msg":"账号不存在，用户名或密码错误！"}', CAST(N'2024-01-05T12:22:22.927' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1743125773037998080, N'登录', 3, N'GET', N'admin', N'192.168.1.102', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":true,"Result":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjMiLCJOaWNrTmFtZSI6IueCkum4oeeuoeeQhuWRmCIsIk5hbWUiOiJhZG1pbiIsIlVzZXJUeXBlIjoiMCIsImV4cCI6MTcwNDQyOTE0NCwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0In0.t57M4u5oLrfxImgu-yuE6_9_IvJENg9GMPql4OwNkxc","Msg":null}', CAST(N'2024-01-05T12:22:24.660' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1743126090458730496, N'登录', 3, N'GET', N'admin', N'192.168.1.102', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":false,"Result":null,"Msg":"账号不存在，用户名或密码错误！"}', CAST(N'2024-01-05T12:23:40.340' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1743126091570221056, N'登录', 3, N'GET', N'admin', N'192.168.1.102', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":false,"Result":null,"Msg":"账号不存在，用户名或密码错误！"}', CAST(N'2024-01-05T12:23:40.603' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1743126094682394624, N'登录', 3, N'GET', N'admin', N'192.168.1.102', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":false,"Result":null,"Msg":"账号不存在，用户名或密码错误！"}', CAST(N'2024-01-05T12:23:41.347' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1743126119995019264, N'登录', 3, N'GET', N'admin', N'192.168.1.102', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":true,"Result":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjMiLCJOaWNrTmFtZSI6IueCkum4oeeuoeeQhuWRmCIsIk5hbWUiOiJhZG1pbiIsIlVzZXJUeXBlIjoiMCIsImV4cCI6MTcwNDQyOTIyNywiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0In0.rcBSHUFU2GZiJgQx5fVNTsBp1xBeq_auPr2M7_7XzsI","Msg":null}', CAST(N'2024-01-05T12:23:47.383' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1747870032228126720, N'登录', 3, N'GET', N'admin', N'42.80.86.76', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":true,"Result":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjMiLCJOaWNrTmFtZSI6IueCkum4oeeuoeeQhuWRmCIsIk5hbWUiOiJhZG1pbiIsIlVzZXJUeXBlIjoiMCIsImV4cCI6MTcwNTU2MDI2NCwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0In0.ZK1Dhy4efrMR5cAa1Klzrd5fwjN6gTVqsVKJYq-8GZ0","Msg":null}', CAST(N'2024-01-18T14:34:24.197' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1747870675076517888, N'登录', 3, N'GET', N'admin', N'61.221.110.46', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":true,"Result":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjMiLCJOaWNrTmFtZSI6IueCkum4oeeuoeeQhuWRmCIsIk5hbWUiOiJhZG1pbiIsIlVzZXJUeXBlIjoiMCIsImV4cCI6MTcwNTU2MDQxNywiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0In0.MB5PUPoMRSnpquvcnd-oNznIzSEJSaKaL9NdRGQ8A0c","Msg":null}', CAST(N'2024-01-18T14:36:57.463' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1747873852660256768, N'登录', 3, N'GET', N'admin', N'61.221.110.46', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":true,"Result":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjMiLCJOaWNrTmFtZSI6IueCkum4oeeuoeeQhuWRmCIsIk5hbWUiOiJhZG1pbiIsIlVzZXJUeXBlIjoiMCIsImV4cCI6MTcwNTU2MTE3NSwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0In0.VinGLI7KFa9nNZuUbguT0vXaNrmPGfkQgVgCqGCYgxY","Msg":null}', CAST(N'2024-01-18T14:49:35.057' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1747874785544769536, N'登录', 3, N'GET', N'admin', N'192.168.1.102', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":false,"Result":null,"Msg":"账号不存在，用户名或密码错误！"}', CAST(N'2024-01-18T14:53:17.473' AS DateTime), 3)
INSERT [dbo].[OperationLog] ([Id], [Title], [OperType], [RequestMethod], [OperUser], [OperIp], [OperLocation], [Method], [RequestParam], [RequestResult], [CreationTime], [CreatorId]) VALUES (1747874799465664512, N'登录', 3, N'GET', N'admin', N'192.168.1.102', N'', N'/api/Login/GetToken', N'1', N'{"IsSuccess":true,"Result":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjMiLCJOaWNrTmFtZSI6IueCkum4oeeuoeeQhuWRmCIsIk5hbWUiOiJhZG1pbiIsIlVzZXJUeXBlIjoiMCIsImV4cCI6MTcwNTU2MTQwMCwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1Mjk0In0.a0GaiqxEWLLc5wePiIFxQ9hTH83RsPcn118e0_SObPw","Msg":null}', CAST(N'2024-01-18T14:53:20.793' AS DateTime), 3)
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([Id], [Name], [Order], [IsEnable], [Description], [CreateUserId], [CreateDate], [ModifyUserId], [ModifyDate], [IsDeleted]) VALUES (1, N'QAadmin', 99, 1, N'权限管理', 3, CAST(N'2023-11-27T14:50:37.980' AS DateTime), 0, NULL, 0)
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[UserRoleRelation] ON 

INSERT [dbo].[UserRoleRelation] ([Id], [UserId], [RoleId]) VALUES (1, 2, 1)
SET IDENTITY_INSERT [dbo].[UserRoleRelation] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [Name], [NickName], [Password], [UserType], [IsEnable], [Description], [CreateUserId], [CreateDate], [ModifyUserId], [ModifyDate], [IsDeleted]) VALUES (2, N'system', N'Ava', N'123', 1, 1, N'1', 0, CAST(N'2023-11-16T00:00:00.000' AS DateTime), 1, NULL, 0)
INSERT [dbo].[Users] ([Id], [Name], [NickName], [Password], [UserType], [IsEnable], [Description], [CreateUserId], [CreateDate], [ModifyUserId], [ModifyDate], [IsDeleted]) VALUES (3, N'admin', N'炒鸡管理员', N'eVB8PVW6F+i+fPuWh3juLVRT9NkvZBXGUw4/BSXx/wM=,vtQvyaWmTT8HbTU22yJO5P55o9ZhKLk6yquoXBXMb9A=', 0, 1, N'数据库初始化时默认添加的炒鸡管理员', 0, CAST(N'2023-11-27T10:12:14.303' AS DateTime), 4, CAST(N'2024-01-03T09:42:33.710' AS DateTime), 0)
INSERT [dbo].[Users] ([Id], [Name], [NickName], [Password], [UserType], [IsEnable], [Description], [CreateUserId], [CreateDate], [ModifyUserId], [ModifyDate], [IsDeleted]) VALUES (4, N'admin1', N'LYK', N'QicFk8tFtl0rIMbcUGyFTP3CN1EQxUJzm/3Hv6f1fcE=,xwiYonEKgk+PTrkn8djDDDqwlIknSw5BGE4u8MER6/4=', 1, 1, N'222222', 3, CAST(N'2024-01-02T11:25:13.877' AS DateTime), 4, CAST(N'2024-01-02T12:03:18.040' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
USE [master]
GO
ALTER DATABASE [AdminDb] SET  READ_WRITE 
GO
