CREATE TABLE LOCATIONS
(
    LOCATION_ID    NUMBER(3) GENERATED ALWAYS AS IDENTITY NOT NULL,
    LOCATION_CITY  VARCHAR2(50)                           NOT NULL,
    LOCATION_STATE VARCHAR2(50)                           NOT NULL,
    CONSTRAINT LOCATIONS_PK PRIMARY KEY (LOCATION_ID),
    CONSTRAINT LOCATIONS_UK UNIQUE (LOCATION_CITY, LOCATION_STATE)
        ENABLE
);

CREATE TABLE ARENAS
(
    ARENA_ID       NUMBER(3) GENERATED ALWAYS AS IDENTITY NOT NULL,
    ARENA_NAME     VARCHAR2(50)                           NOT NULL,
    ARENA_LOCATION NUMBER(3)                              NOT NULL,
    CONSTRAINT ARENAS_PK PRIMARY KEY (ARENA_ID),

    CONSTRAINT ARENAS_UK UNIQUE (ARENA_NAME, ARENA_LOCATION),

    CONSTRAINT ARENAS_FK1 FOREIGN KEY (ARENA_LOCATION)
        REFERENCES LOCATIONS (LOCATION_ID)
            ENABLE
);

CREATE TABLE TEAMS
(
    TEAM_ID       NUMBER(3) GENERATED ALWAYS AS IDENTITY NOT NULL,
    TEAM_ACRONYM  CHAR(3)                                NOT NULL,
    TEAM_NAME     VARCHAR2(50)                           NOT NULL,
    TEAM_LOCATION NUMBER(3)                              NOT NULL,
    TEAM_ARENA    NUMBER(3)                              NOT NULL,
    CONSTRAINT TEAMS_PK PRIMARY KEY (TEAM_ID),
    CONSTRAINT TEAMS_UK1 UNIQUE (TEAM_ACRONYM),
    CONSTRAINT TEAMS_UK2 UNIQUE (TEAM_NAME),

    CONSTRAINT TEAMS_FK1 FOREIGN KEY (TEAM_LOCATION)
        REFERENCES LOCATIONS (LOCATION_ID),

    CONSTRAINT TEAMS_FK2 FOREIGN KEY (TEAM_ARENA)
        REFERENCES ARENAS (ARENA_ID)
            ENABLE
);

CREATE TABLE PLAYERS
(
    PLAYER_ID   NUMBER(4) GENERATED ALWAYS AS IDENTITY NOT NULL,
    PLAYER_NAME VARCHAR2(50)                           NOT NULL,
    PLAYER_AGE  NUMBER(2)                              NOT NULL,
    CONSTRAINT PLAYERS_PK PRIMARY KEY (PLAYER_ID)
        ENABLE
);

CREATE TABLE PLAYER_POSITIONS
(
    PLAYER_ID      NUMBER(4) NOT NULL,
    PLAYER_TEAM_ID NUMBER(3) NOT NULL,
    POSITION       CHAR(2)   NOT NULL,

    CONSTRAINT PLAYER_POSITIONS_PK
        PRIMARY KEY (PLAYER_ID, PLAYER_TEAM_ID, POSITION),

    CONSTRAINT PLAYER_POSITIONS_FK1 FOREIGN KEY (PLAYER_ID)
        REFERENCES PLAYERS (PLAYER_ID),

    CONSTRAINT PLAYER_POSITIONS_FK2 FOREIGN KEY (PLAYER_TEAM_ID)
        REFERENCES TEAMS (TEAM_ID)
            ENABLE
);

CREATE TABLE GAMES
(
    GAME_ID   NUMBER(5) GENERATED ALWAYS AS IDENTITY NOT NULL,
    GAME_DATE DATE                                   NOT NULL,
    HOME_TEAM NUMBER(3)                              NOT NULL,
    AWAY_TEAM NUMBER(3)                              NOT NULL,

    CONSTRAINT GAME_PK PRIMARY KEY (GAME_ID),

    CONSTRAINT GAMES_FK1 FOREIGN KEY (HOME_TEAM)
        REFERENCES TEAMS (TEAM_ID),

    CONSTRAINT GAMES_FK2 FOREIGN KEY (AWAY_TEAM)
        REFERENCES TEAMS (TEAM_ID),

    CONSTRAINT GAMES_UK UNIQUE (HOME_TEAM, AWAY_TEAM, GAME_DATE)
);

CREATE TABLE GAME_STATISTICS
(
    STATS_ID                NUMBER(6) GENERATED ALWAYS AS IDENTITY NOT NULL,
    GAME_NUMBER             NUMBER(2)                              NOT NULL,
    TEAM_RESULT             CHAR(1)                                NOT NULL,
    POINTS                  NUMBER(3)                              NOT NULL,
    FIELD_GOALS             NUMBER(3)                              NOT NULL,
    FIELD_GOALS_ATTEMPTED   NUMBER(3)                              NOT NULL,
    FIELD_GOALS_PERCENTAGE  NUMBER(16, 15)                         NOT NULL,
    X3POINTSHOTS            NUMBER(3)                              NOT NULL,
    X3POINTSHOTS_ATTEMPTED  NUMBER(3)                              NOT NULL,
    X3POINTSHOTS_PERCENTAGE NUMBER(16, 15)                         NOT NULL,
    FREETHROWS              NUMBER(3)                              NOT NULL,
    FREETHROWS_ATTEMPTED    NUMBER(3)                              NOT NULL,
    FREETHROWS_PERCENTAGE   NUMBER(16, 15)                         NOT NULL,
    OFFREBOUNDS             NUMBER(3)                              NOT NULL,
    TOTALREBOUNDS           NUMBER(3)                              NOT NULL,
    ASSISTS                 NUMBER(3)                              NOT NULL,
    STEALS                  NUMBER(3)                              NOT NULL,
    BLOCKS                  NUMBER(3)                              NOT NULL,
    TURNOVERS               NUMBER(3)                              NOT NULL,
    TOTALFOULS              NUMBER(3)                              NOT NULL,

    CONSTRAINT GAME_STATISTICS_PK PRIMARY KEY (STATS_ID),

    CONSTRAINT GAME_STATISTICS_CHK1 CHECK (TEAM_RESULT IN ('W', 'L'))
        ENABLE
);

CREATE TABLE GAMES_TEAMS_STATISTICS
(
    GAME_ID  NUMBER(5) NOT NULL,
    TEAM_ID  NUMBER(3) NOT NULL,
    STATS_ID NUMBER(6) NOT NULL,

    CONSTRAINT GAMES_TEAMS_STATISTICS_PK
        PRIMARY KEY (GAME_ID, TEAM_ID, STATS_ID),

    CONSTRAINT GAMES_TEAMS_STATISTICS_FK1
        FOREIGN KEY (GAME_ID) REFERENCES GAMES (GAME_ID),

    CONSTRAINT GAMES_TEAMS_STATISTICS_FK2
        FOREIGN KEY (TEAM_ID)
            REFERENCES TEAMS (TEAM_ID),

    CONSTRAINT GAMES_TEAMS_STATISTICS_FK3
        FOREIGN KEY (STATS_ID)
            REFERENCES GAME_STATISTICS (STATS_ID)
                ENABLE
);

CREATE TABLE PLAYER_STATISTICS
(
    STATS_ID        NUMBER(6) GENERATED ALWAYS AS IDENTITY NOT NULL,
    G               NUMBER(3)                              NOT NULL,
    GS              NUMBER(3)                              NOT NULL,
    MP              NUMBER(5)                              NOT NULL,
    PTS             NUMBER(5)                              NOT NULL,
    TS_PERCENTAGE   NUMBER(16, 15),
    FTM             NUMBER(4)                              NOT NULL,
    FTA             NUMBER(4)                              NOT NULL,
    FT_PERCENTAGE   NUMBER(16, 15),
    FGM             NUMBER(4)                              NOT NULL,
    FGA             NUMBER(4)                              NOT NULL,
    FG_PERCENTAGE   NUMBER(16, 15),
    PM3             NUMBER(4)                              NOT NULL,
    PA3             NUMBER(4)                              NOT NULL,
    P3_PERCENTAGE   NUMBER(16, 15),
    PM2             NUMBER(4)                              NOT NULL,
    PA2             NUMBER(4)                              NOT NULL,
    P2_PERCENTAGE   NUMBER(16, 15),
    OREB            NUMBER(3)                              NOT NULL,
    OREB_PERCENTAGE NUMBER(4, 1),
    DREB            NUMBER(3)                              NOT NULL,
    DREB_PERCENTAGE NUMBER(4, 1),
    TREB            NUMBER(4)                              NOT NULL,
    TREB_PERCENTAGE NUMBER(4, 1),
    AST             NUMBER(4)                              NOT NULL,
    AST_PERCENTAGE  NUMBER(4, 1),
    STL             NUMBER(4)                              NOT NULL,
    STL_PERCENTAGE  NUMBER(4, 1),
    BLK             NUMBER(3)                              NOT NULL,
    BLK_PERCENTAGE  NUMBER(4, 1),
    TOV             NUMBER(3)                              NOT NULL,
    TOV_PERCENTAGE  NUMBER(4, 1),
    USG_PERCENTAGE  NUMBER(4, 1),
    OFFWS           NUMBER(3, 1)                           NOT NULL,
    DEFWS           NUMBER(3, 1)                           NOT NULL,
    WS              NUMBER(4, 1)                           NOT NULL,
    WS_48           NUMBER(16, 15)                         NOT NULL,
    BPM             NUMBER(16, 14)                         NOT NULL,
    VORP            NUMBER(2, 1)                           NOT NULL,
    EFG_PERCENTAGE  NUMBER(16, 15),
    PF              NUMBER(4)                              NOT NULL,

    CONSTRAINT PLAYER_STATISTICS_PK PRIMARY KEY (STATS_ID)
        ENABLE
);

CREATE TABLE PLAYERS_TEAMS_STATISTICS
(
    PLAYER_ID     NUMBER(3) NOT NULL,
    TEAM_ID       NUMBER(3) NOT NULL,
    STATISTICS_ID NUMBER(6) NOT NULL,

    CONSTRAINT PLAYERS_TEAMS_STATISTICS_PK
        PRIMARY KEY (PLAYER_ID, TEAM_ID, STATISTICS_ID),

    CONSTRAINT PLAYERS_TEAMS_STATISTICS_FK1
        FOREIGN KEY (PLAYER_ID) REFERENCES PLAYERS (PLAYER_ID),

    CONSTRAINT PLAYERS_TEAMS_STATISTICS_FK2
        FOREIGN KEY (TEAM_ID)
            REFERENCES TEAMS (TEAM_ID),

    CONSTRAINT PLAYERS_TEAMS_STATISTICS_FK3
        FOREIGN KEY (STATISTICS_ID)
            REFERENCES PLAYER_STATISTICS (STATS_ID)
                ENABLE
);
