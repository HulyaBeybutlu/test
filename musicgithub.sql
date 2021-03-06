USE [Music_Store]
GO
/****** Object:  Table [dbo].[Usernames]    Script Date: 9/23/2020 3:54:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usernames](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[BirthDate] [date] NULL,
	[Email] [nvarchar](50) NULL,
	[CountryId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Musics]    Script Date: 9/23/2020 3:54:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Musics](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](40) NOT NULL,
	[LaunchDate] [date] NULL,
	[Length] [decimal](18, 0) NULL,
	[GenreId] [int] NULL,
	[SingerId] [int] NULL,
	[LikedText] [nvarchar](40) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Likes]    Script Date: 9/23/2020 3:54:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Likes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UsernamesId] [int] NULL,
	[MusicsId] [int] NULL,
	[GenresId] [int] NULL,
	[Count] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ShowUserFavorites]    Script Date: 9/23/2020 3:54:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ShowUserFavorites] As
select uns.Name[Usernames],ms.Name[Musics_Name] from Likes li
Join Usernames uns
on li.UsernamesId = uns.Id
Join Musics ms
on li.MusicsId=ms.Id
GO
/****** Object:  Table [dbo].[Listenings]    Script Date: 9/23/2020 3:54:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Listenings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UsernamesId] [int] NULL,
	[MusicsId] [int] NULL,
	[ListeningDate] [date] NULL,
	[Count] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ShowlisteningsMusics]    Script Date: 9/23/2020 3:54:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ShowlisteningsMusics] As
select uns.Name[Usernames], ms.Name[Musics_name] from Listenings lns
 Join Musics ms
 on lns.MusicsId = ms.Id
 Join Usernames uns
 on lns.UsernamesId = uns.Id
GO
/****** Object:  Table [dbo].[Genres]    Script Date: 9/23/2020 3:54:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genres](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](40) NOT NULL,
	[Count] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[GenresCount]    Script Date: 9/23/2020 3:54:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[GenresCount] AS
select  gs.Name[Genres_name], Count(ms.Id)[Music_count] from Musics ms
Join Genres gs
on ms.GenreId=gs.Id
Group by gs.Name
GO
/****** Object:  View [dbo].[ShowListenings]    Script Date: 9/23/2020 3:54:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ShowListenings] As
select ms.Name[Musics_name], Count(ls.MusicsId)[Listenings_Count] from Listenings ls
Join Musics ms
On ls.MusicsId = ms.Id
Group by ms.Name
GO
/****** Object:  View [dbo].[ShowFavorites]    Script Date: 9/23/2020 3:54:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ShowFavorites] AS
select ms.Name[Musics_name], Count(ls.MusicsId)[Likes_Count] from Likes ls
Join Musics ms
on ls.MusicsId = ms.Id
Group by ms.Name
GO
/****** Object:  View [dbo].[ShowGenres]    Script Date: 9/23/2020 3:54:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[ShowGenres] As
select gs.Name[Genres_name],Count(ls.GenresId)[Likes_count] from Likes ls
Join Genres gs
on ls.GenresId = gs.Id
Group by gs.Name
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 9/23/2020 3:54:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Singers]    Script Date: 9/23/2020 3:54:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Singers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[BirthDate] [date] NULL,
	[Image] [varchar](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Countries] ON 

INSERT [dbo].[Countries] ([Id], [Name]) VALUES (1, N'Azerbaijan')
INSERT [dbo].[Countries] ([Id], [Name]) VALUES (2, N'Turkey')
INSERT [dbo].[Countries] ([Id], [Name]) VALUES (3, N'Russian')
INSERT [dbo].[Countries] ([Id], [Name]) VALUES (4, N'Norway')
INSERT [dbo].[Countries] ([Id], [Name]) VALUES (5, N'Estonia')
INSERT [dbo].[Countries] ([Id], [Name]) VALUES (6, N'Tailand')
SET IDENTITY_INSERT [dbo].[Countries] OFF
GO
SET IDENTITY_INSERT [dbo].[Genres] ON 

INSERT [dbo].[Genres] ([Id], [Name], [Count]) VALUES (1, N'Rock', NULL)
INSERT [dbo].[Genres] ([Id], [Name], [Count]) VALUES (2, N'Hit', NULL)
INSERT [dbo].[Genres] ([Id], [Name], [Count]) VALUES (3, N'Jazz', NULL)
INSERT [dbo].[Genres] ([Id], [Name], [Count]) VALUES (4, N'Rap', NULL)
INSERT [dbo].[Genres] ([Id], [Name], [Count]) VALUES (5, N'Pop', NULL)
SET IDENTITY_INSERT [dbo].[Genres] OFF
GO
SET IDENTITY_INSERT [dbo].[Likes] ON 

INSERT [dbo].[Likes] ([Id], [UsernamesId], [MusicsId], [GenresId], [Count]) VALUES (1, 1, 1, 1, NULL)
INSERT [dbo].[Likes] ([Id], [UsernamesId], [MusicsId], [GenresId], [Count]) VALUES (2, 1, 9, 3, NULL)
INSERT [dbo].[Likes] ([Id], [UsernamesId], [MusicsId], [GenresId], [Count]) VALUES (3, 2, 3, 1, NULL)
INSERT [dbo].[Likes] ([Id], [UsernamesId], [MusicsId], [GenresId], [Count]) VALUES (4, 2, 4, 5, NULL)
INSERT [dbo].[Likes] ([Id], [UsernamesId], [MusicsId], [GenresId], [Count]) VALUES (5, 2, 1, 1, NULL)
INSERT [dbo].[Likes] ([Id], [UsernamesId], [MusicsId], [GenresId], [Count]) VALUES (6, 3, 6, 5, NULL)
INSERT [dbo].[Likes] ([Id], [UsernamesId], [MusicsId], [GenresId], [Count]) VALUES (7, 4, 6, 5, NULL)
INSERT [dbo].[Likes] ([Id], [UsernamesId], [MusicsId], [GenresId], [Count]) VALUES (8, 5, 6, 5, NULL)
INSERT [dbo].[Likes] ([Id], [UsernamesId], [MusicsId], [GenresId], [Count]) VALUES (9, 6, 8, 3, NULL)
INSERT [dbo].[Likes] ([Id], [UsernamesId], [MusicsId], [GenresId], [Count]) VALUES (10, 6, 3, 1, NULL)
INSERT [dbo].[Likes] ([Id], [UsernamesId], [MusicsId], [GenresId], [Count]) VALUES (11, 5, 7, 4, NULL)
INSERT [dbo].[Likes] ([Id], [UsernamesId], [MusicsId], [GenresId], [Count]) VALUES (12, 3, 2, 1, NULL)
INSERT [dbo].[Likes] ([Id], [UsernamesId], [MusicsId], [GenresId], [Count]) VALUES (13, 4, 5, 5, NULL)
INSERT [dbo].[Likes] ([Id], [UsernamesId], [MusicsId], [GenresId], [Count]) VALUES (14, 4, 1, 1, NULL)
INSERT [dbo].[Likes] ([Id], [UsernamesId], [MusicsId], [GenresId], [Count]) VALUES (15, 2, 11, 4, NULL)
INSERT [dbo].[Likes] ([Id], [UsernamesId], [MusicsId], [GenresId], [Count]) VALUES (16, 3, 12, 1, NULL)
INSERT [dbo].[Likes] ([Id], [UsernamesId], [MusicsId], [GenresId], [Count]) VALUES (17, 1, 11, 4, NULL)
INSERT [dbo].[Likes] ([Id], [UsernamesId], [MusicsId], [GenresId], [Count]) VALUES (18, 6, 11, 4, NULL)
INSERT [dbo].[Likes] ([Id], [UsernamesId], [MusicsId], [GenresId], [Count]) VALUES (19, 4, 12, 1, NULL)
INSERT [dbo].[Likes] ([Id], [UsernamesId], [MusicsId], [GenresId], [Count]) VALUES (20, 1, 10, 1, NULL)
INSERT [dbo].[Likes] ([Id], [UsernamesId], [MusicsId], [GenresId], [Count]) VALUES (21, 2, 10, 1, NULL)
INSERT [dbo].[Likes] ([Id], [UsernamesId], [MusicsId], [GenresId], [Count]) VALUES (22, 3, 10, 1, NULL)
INSERT [dbo].[Likes] ([Id], [UsernamesId], [MusicsId], [GenresId], [Count]) VALUES (23, 5, 10, 1, NULL)
INSERT [dbo].[Likes] ([Id], [UsernamesId], [MusicsId], [GenresId], [Count]) VALUES (24, 6, 10, 1, NULL)
INSERT [dbo].[Likes] ([Id], [UsernamesId], [MusicsId], [GenresId], [Count]) VALUES (25, 5, 11, 4, NULL)
SET IDENTITY_INSERT [dbo].[Likes] OFF
GO
SET IDENTITY_INSERT [dbo].[Listenings] ON 

INSERT [dbo].[Listenings] ([Id], [UsernamesId], [MusicsId], [ListeningDate], [Count]) VALUES (1, 1, 2, CAST(N'2020-12-11' AS Date), NULL)
INSERT [dbo].[Listenings] ([Id], [UsernamesId], [MusicsId], [ListeningDate], [Count]) VALUES (2, 1, 5, CAST(N'2020-09-19' AS Date), NULL)
INSERT [dbo].[Listenings] ([Id], [UsernamesId], [MusicsId], [ListeningDate], [Count]) VALUES (3, 2, 4, CAST(N'2020-03-19' AS Date), NULL)
INSERT [dbo].[Listenings] ([Id], [UsernamesId], [MusicsId], [ListeningDate], [Count]) VALUES (4, 2, 2, CAST(N'2020-04-23' AS Date), NULL)
INSERT [dbo].[Listenings] ([Id], [UsernamesId], [MusicsId], [ListeningDate], [Count]) VALUES (5, 3, 5, CAST(N'2019-05-12' AS Date), NULL)
INSERT [dbo].[Listenings] ([Id], [UsernamesId], [MusicsId], [ListeningDate], [Count]) VALUES (6, 3, 1, CAST(N'2019-03-13' AS Date), NULL)
INSERT [dbo].[Listenings] ([Id], [UsernamesId], [MusicsId], [ListeningDate], [Count]) VALUES (7, 1, 1, CAST(N'2020-11-10' AS Date), NULL)
INSERT [dbo].[Listenings] ([Id], [UsernamesId], [MusicsId], [ListeningDate], [Count]) VALUES (8, 5, 4, CAST(N'2020-01-03' AS Date), NULL)
INSERT [dbo].[Listenings] ([Id], [UsernamesId], [MusicsId], [ListeningDate], [Count]) VALUES (9, 6, 9, CAST(N'2020-08-09' AS Date), NULL)
INSERT [dbo].[Listenings] ([Id], [UsernamesId], [MusicsId], [ListeningDate], [Count]) VALUES (10, 4, 8, CAST(N'2020-09-22' AS Date), NULL)
INSERT [dbo].[Listenings] ([Id], [UsernamesId], [MusicsId], [ListeningDate], [Count]) VALUES (11, 4, 7, CAST(N'2020-09-22' AS Date), NULL)
INSERT [dbo].[Listenings] ([Id], [UsernamesId], [MusicsId], [ListeningDate], [Count]) VALUES (12, 4, 2, CAST(N'2020-10-11' AS Date), NULL)
INSERT [dbo].[Listenings] ([Id], [UsernamesId], [MusicsId], [ListeningDate], [Count]) VALUES (13, 1, 3, CAST(N'2020-09-09' AS Date), NULL)
INSERT [dbo].[Listenings] ([Id], [UsernamesId], [MusicsId], [ListeningDate], [Count]) VALUES (14, 2, 9, CAST(N'2019-08-06' AS Date), NULL)
INSERT [dbo].[Listenings] ([Id], [UsernamesId], [MusicsId], [ListeningDate], [Count]) VALUES (15, 6, 8, CAST(N'2019-03-09' AS Date), NULL)
INSERT [dbo].[Listenings] ([Id], [UsernamesId], [MusicsId], [ListeningDate], [Count]) VALUES (16, 5, 9, CAST(N'2019-07-06' AS Date), NULL)
INSERT [dbo].[Listenings] ([Id], [UsernamesId], [MusicsId], [ListeningDate], [Count]) VALUES (17, 1, 10, CAST(N'2020-03-09' AS Date), NULL)
INSERT [dbo].[Listenings] ([Id], [UsernamesId], [MusicsId], [ListeningDate], [Count]) VALUES (18, 2, 10, CAST(N'2019-09-10' AS Date), NULL)
INSERT [dbo].[Listenings] ([Id], [UsernamesId], [MusicsId], [ListeningDate], [Count]) VALUES (19, 3, 11, CAST(N'2020-08-25' AS Date), NULL)
INSERT [dbo].[Listenings] ([Id], [UsernamesId], [MusicsId], [ListeningDate], [Count]) VALUES (20, 4, 11, CAST(N'2018-12-30' AS Date), NULL)
INSERT [dbo].[Listenings] ([Id], [UsernamesId], [MusicsId], [ListeningDate], [Count]) VALUES (21, 3, 10, CAST(N'2018-11-29' AS Date), NULL)
INSERT [dbo].[Listenings] ([Id], [UsernamesId], [MusicsId], [ListeningDate], [Count]) VALUES (22, 4, 10, CAST(N'2017-12-27' AS Date), NULL)
INSERT [dbo].[Listenings] ([Id], [UsernamesId], [MusicsId], [ListeningDate], [Count]) VALUES (23, 1, 12, CAST(N'2018-12-13' AS Date), NULL)
INSERT [dbo].[Listenings] ([Id], [UsernamesId], [MusicsId], [ListeningDate], [Count]) VALUES (24, 6, 12, CAST(N'2017-12-17' AS Date), NULL)
INSERT [dbo].[Listenings] ([Id], [UsernamesId], [MusicsId], [ListeningDate], [Count]) VALUES (26, 7, 12, CAST(N'2017-12-19' AS Date), NULL)
SET IDENTITY_INSERT [dbo].[Listenings] OFF
GO
SET IDENTITY_INSERT [dbo].[Musics] ON 

INSERT [dbo].[Musics] ([Id], [Name], [LaunchDate], [Length], [GenreId], [SingerId], [LikedText]) VALUES (1, N'Love of my life', CAST(N'1975-11-21' AS Date), CAST(339 AS Decimal(18, 0)), 1, 1, NULL)
INSERT [dbo].[Musics] ([Id], [Name], [LaunchDate], [Length], [GenreId], [SingerId], [LikedText]) VALUES (2, N'Locked out of heaven', CAST(N'2012-10-01' AS Date), CAST(351 AS Decimal(18, 0)), 1, 2, NULL)
INSERT [dbo].[Musics] ([Id], [Name], [LaunchDate], [Length], [GenreId], [SingerId], [LikedText]) VALUES (3, N'Grenade', CAST(N'2010-11-02' AS Date), CAST(321 AS Decimal(18, 0)), 1, 2, NULL)
INSERT [dbo].[Musics] ([Id], [Name], [LaunchDate], [Length], [GenreId], [SingerId], [LikedText]) VALUES (4, N'Cold', CAST(N'2015-10-04' AS Date), CAST(402 AS Decimal(18, 0)), 5, 3, NULL)
INSERT [dbo].[Musics] ([Id], [Name], [LaunchDate], [Length], [GenreId], [SingerId], [LikedText]) VALUES (5, N'Bonfire Heart', CAST(N'2018-11-08' AS Date), CAST(258 AS Decimal(18, 0)), 5, 3, NULL)
INSERT [dbo].[Musics] ([Id], [Name], [LaunchDate], [Length], [GenreId], [SingerId], [LikedText]) VALUES (6, N'Goodbye my lover', CAST(N'2019-10-02' AS Date), CAST(309 AS Decimal(18, 0)), 5, 3, NULL)
INSERT [dbo].[Musics] ([Id], [Name], [LaunchDate], [Length], [GenreId], [SingerId], [LikedText]) VALUES (7, N'Rap God', CAST(N'2014-09-04' AS Date), CAST(518 AS Decimal(18, 0)), 4, 4, NULL)
INSERT [dbo].[Musics] ([Id], [Name], [LaunchDate], [Length], [GenreId], [SingerId], [LikedText]) VALUES (8, N'Senin birce tebessumun', CAST(N'1990-02-04' AS Date), CAST(310 AS Decimal(18, 0)), 3, 5, NULL)
INSERT [dbo].[Musics] ([Id], [Name], [LaunchDate], [Length], [GenreId], [SingerId], [LikedText]) VALUES (9, N'Seher qatari', CAST(N'1988-09-07' AS Date), CAST(245 AS Decimal(18, 0)), 3, 5, NULL)
INSERT [dbo].[Musics] ([Id], [Name], [LaunchDate], [Length], [GenreId], [SingerId], [LikedText]) VALUES (10, N'Mother Love', CAST(N'1975-11-21' AS Date), CAST(457 AS Decimal(18, 0)), 1, 1, NULL)
INSERT [dbo].[Musics] ([Id], [Name], [LaunchDate], [Length], [GenreId], [SingerId], [LikedText]) VALUES (11, N'Candy shop', CAST(N'2009-10-01' AS Date), CAST(354 AS Decimal(18, 0)), 4, 6, NULL)
INSERT [dbo].[Musics] ([Id], [Name], [LaunchDate], [Length], [GenreId], [SingerId], [LikedText]) VALUES (12, N'Living of my own', CAST(N'1989-12-12' AS Date), CAST(356 AS Decimal(18, 0)), 1, 1, NULL)
SET IDENTITY_INSERT [dbo].[Musics] OFF
GO
SET IDENTITY_INSERT [dbo].[Singers] ON 

INSERT [dbo].[Singers] ([Id], [Name], [BirthDate], [Image]) VALUES (1, N'Freddie Mercury', CAST(N'1946-05-09' AS Date), NULL)
INSERT [dbo].[Singers] ([Id], [Name], [BirthDate], [Image]) VALUES (2, N'Bruno Mars', CAST(N'1985-08-10' AS Date), NULL)
INSERT [dbo].[Singers] ([Id], [Name], [BirthDate], [Image]) VALUES (3, N'James Blunt', CAST(N'1980-07-12' AS Date), NULL)
INSERT [dbo].[Singers] ([Id], [Name], [BirthDate], [Image]) VALUES (4, N'Eminem', CAST(N'1986-08-10' AS Date), NULL)
INSERT [dbo].[Singers] ([Id], [Name], [BirthDate], [Image]) VALUES (5, N'Oqtay Agayev', CAST(N'1934-07-11' AS Date), NULL)
INSERT [dbo].[Singers] ([Id], [Name], [BirthDate], [Image]) VALUES (6, N'50 cent', CAST(N'1980-09-12' AS Date), NULL)
SET IDENTITY_INSERT [dbo].[Singers] OFF
GO
SET IDENTITY_INSERT [dbo].[Usernames] ON 

INSERT [dbo].[Usernames] ([Id], [Name], [BirthDate], [Email], [CountryId]) VALUES (1, N'Aytac Esgerova', CAST(N'1998-02-27' AS Date), N'asgarova98@list.ru', 1)
INSERT [dbo].[Usernames] ([Id], [Name], [BirthDate], [Email], [CountryId]) VALUES (2, N'Mutellim Esgerov', CAST(N'1997-02-12' AS Date), N'mutasgar@mail.ru', 1)
INSERT [dbo].[Usernames] ([Id], [Name], [BirthDate], [Email], [CountryId]) VALUES (3, N'Stewen Jakcson', CAST(N'1992-03-09' AS Date), N'jack@mail.ru', 3)
INSERT [dbo].[Usernames] ([Id], [Name], [BirthDate], [Email], [CountryId]) VALUES (4, N'Busra Ertul', CAST(N'1990-07-09' AS Date), N'ertulbus@mail.ru', 2)
INSERT [dbo].[Usernames] ([Id], [Name], [BirthDate], [Email], [CountryId]) VALUES (5, N'Avril Bieber', CAST(N'1985-09-06' AS Date), N'avrilbiever@mail.ru', 5)
INSERT [dbo].[Usernames] ([Id], [Name], [BirthDate], [Email], [CountryId]) VALUES (6, N'Muhammed Ibn', CAST(N'1989-09-07' AS Date), N'moho@mail.ru', 4)
INSERT [dbo].[Usernames] ([Id], [Name], [BirthDate], [Email], [CountryId]) VALUES (7, N'John Weigth', CAST(N'1999-11-12' AS Date), N'johon@mail.ru', 6)
SET IDENTITY_INSERT [dbo].[Usernames] OFF
GO
ALTER TABLE [dbo].[Likes]  WITH CHECK ADD FOREIGN KEY([GenresId])
REFERENCES [dbo].[Genres] ([Id])
GO
ALTER TABLE [dbo].[Likes]  WITH CHECK ADD FOREIGN KEY([MusicsId])
REFERENCES [dbo].[Musics] ([Id])
GO
ALTER TABLE [dbo].[Likes]  WITH CHECK ADD FOREIGN KEY([UsernamesId])
REFERENCES [dbo].[Usernames] ([Id])
GO
ALTER TABLE [dbo].[Listenings]  WITH CHECK ADD FOREIGN KEY([MusicsId])
REFERENCES [dbo].[Musics] ([Id])
GO
ALTER TABLE [dbo].[Listenings]  WITH CHECK ADD FOREIGN KEY([UsernamesId])
REFERENCES [dbo].[Usernames] ([Id])
GO
ALTER TABLE [dbo].[Musics]  WITH CHECK ADD FOREIGN KEY([GenreId])
REFERENCES [dbo].[Genres] ([Id])
GO
ALTER TABLE [dbo].[Musics]  WITH CHECK ADD FOREIGN KEY([SingerId])
REFERENCES [dbo].[Singers] ([Id])
GO
ALTER TABLE [dbo].[Usernames]  WITH CHECK ADD FOREIGN KEY([CountryId])
REFERENCES [dbo].[Countries] ([Id])
GO
