/* =====================================================================
   CAN 2023 Côte d'Ivoire · schéma de la base source AFCON2023
   ---------------------------------------------------------------------
   Ce script crée UNIQUEMENT la structure attendue par le modèle
   sémantique (11 tables). Il ne contient aucune donnée : chargez vos
   propres lignes avant d'actualiser le rapport dans Power BI Desktop.
   ===================================================================== */

IF DB_ID(N'AFCON2023') IS NULL CREATE DATABASE AFCON2023;
GO
USE AFCON2023;
GO

/* Équipes : bilan global et meilleur parcours atteint (Highest_Finish) */
CREATE TABLE dbo.Teams (
    Team_ID                  FLOAT,
    Team_Name                NVARCHAR(255),
    Wins                     FLOAT,
    Losses                   FLOAT,
    Draws                    FLOAT,
    Goals_Scored             FLOAT,
    Goals_Conceded           FLOAT,
    Clean_Sheets             FLOAT,
    Penalty_Kicks_Made       FLOAT,
    Penalty_Kicks_Attempted  FLOAT,
    Yellow_Cards             FLOAT,
    Red_Cards                FLOAT,
    Highest_Finish           NVARCHAR(255),  -- Group Stage, Round of 16, Quarter Final, Semi Final, Third Place Play Off, Vice Champion, Champion
    Group_ID                 NVARCHAR(255)
);

/* Groupes : classement final de la phase de poules */
CREATE TABLE dbo.Groups (
    Group_ID       NVARCHAR(255),
    Team_Name      NVARCHAR(255),
    Points_Gained  FLOAT,
    Position       FLOAT,
    Status         NVARCHAR(255),
    Team_ID        FLOAT
);

/* Matchs : affiche, score, arbitre, homme du match, stade */
CREATE TABLE dbo.Matches (
    Match_ID      FLOAT,
    [Date]        DATETIME,
    Round         NVARCHAR(255),
    Home_Team     NVARCHAR(255),
    Away_Team     NVARCHAR(255),
    Result        NVARCHAR(255),
    Referee       NVARCHAR(255),
    Ref_Country   NVARCHAR(255),
    Moth          NVARCHAR(255),   -- homme du match
    Stadium_Name  NVARCHAR(255),
    Stadium_ID    NVARCHAR(255)
);

/* Affluence par match */
CREATE TABLE dbo.Stadiums (
    Stadium_ID    NVARCHAR(255),
    Stadium_Name  NVARCHAR(255),
    Round         NVARCHAR(255),
    Location      NVARCHAR(255),
    Attendance    FLOAT,
    Match_ID      FLOAT
);

/* Buts : buteur, minute, type, passeur */
CREATE TABLE dbo.Goals (
    Goal_ID         FLOAT,
    Goal_Scorer     NVARCHAR(255),
    Scored_Against  NVARCHAR(255),
    Round           NVARCHAR(255),
    Goal_Minute     FLOAT,
    Minute_Format   NVARCHAR(255),  -- Regular Time, Additional Time, Extra Time, Additional In Extra Time
    Team_ID         FLOAT,
    Match_ID        FLOAT,
    Position        NVARCHAR(255),
    Numero          FLOAT,
    Assist          NVARCHAR(255),
    Type_Goal       NVARCHAR(255)
);

/* Cartons jaunes et rouges (même structure) */
CREATE TABLE dbo.YellowCards (
    Card_ID        FLOAT,
    Match_ID       FLOAT,
    Team_ID        FLOAT,
    Player         NVARCHAR(255),
    Position       NVARCHAR(255),
    Numero         FLOAT,
    Minute_Card    FLOAT,
    Minute_Format  NVARCHAR(255)
);
CREATE TABLE dbo.RedCards (
    Card_ID        FLOAT,
    Match_ID       FLOAT,
    Team_ID        FLOAT,
    Player         NVARCHAR(255),
    Position       NVARCHAR(255),
    Numero         FLOAT,
    Minute_Card    FLOAT,
    Minute_Format  NVARCHAR(255)
);

/* Remplacements */
CREATE TABLE dbo.Substitutions (
    Substitution_ID      FLOAT,
    Match_ID             FLOAT,
    Team_ID              FLOAT,
    [Exit]               NVARCHAR(255),
    Entry                NVARCHAR(255),
    Position_Exit        NVARCHAR(255),
    Position_Entry       NVARCHAR(255),
    Numero_Exit          FLOAT,
    Numero_Entry         FLOAT,
    Minute_Substitution  FLOAT,
    Minute_Format        NVARCHAR(255)
);

/* Interventions de l'arbitrage vidéo */
CREATE TABLE dbo.Vars (
    Var_ID             FLOAT,
    Match_ID           FLOAT,
    Type_Intervention  NVARCHAR(255),
    Minute_Var         FLOAT,
    Minute_Format      NVARCHAR(255),
    Team_ID            FLOAT
);

/* Statistiques de match, format large : suffixe 1 = domicile, 2 = extérieur */
CREATE TABLE dbo.StatisticsKeys (
    Match_ID            FLOAT,
    Shots1 FLOAT, Shots_Target1 FLOAT, Possession1 FLOAT, Passes1 FLOAT, Passings_Accuracy1 FLOAT,
    Fouls1 FLOAT, Yellow_Cards1 FLOAT, Red_Cards1 FLOAT, Offsides1 FLOAT, Corners1 FLOAT,
    Shots2 FLOAT, Shots_Target2 FLOAT, Possession2 FLOAT, Passes2 FLOAT, Passings_Accuracy2 FLOAT,
    Fouls2 FLOAT, Yellow_Cards2 FLOAT, Red_Cards2 FLOAT, Offsides2 FLOAT, Corners2 FLOAT
);
CREATE TABLE dbo.Defenses (
    Match_ID FLOAT,
    Tackles_Won1 FLOAT, Goalkeeper_Saves1 FLOAT, Clearances1 FLOAT, Interceptions1 FLOAT, Counter_Attacks1 FLOAT,
    Tackles_Won2 FLOAT, Goalkeeper_Saves2 FLOAT, Clearances2 FLOAT, Interceptions2 FLOAT, Counter_Attacks2 FLOAT
);
GO
