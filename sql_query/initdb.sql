CREATE TABLE USERS (
    ID INTEGER not null GENERATED ALWAYS AS IDENTITY,
    COOKIE VARCHAR(60),
    USERNAME VARCHAR(30) not null unique, 
    NAME VARCHAR(30) not null ,
    LASTNAME VARCHAR(30),
    EMAIL VARCHAR(30) not null unique, 
    IMAGE VARCHAR(20),
    PASSWORD VARCHAR(60) not null,
    "ADMIN" BOOLEAN,
    CONSTRAINT USER_PK PRIMARY KEY (id)
  );

CREATE TABLE EMAIL(
    IDMAIL INTEGER not null GENERATED ALWAYS AS IDENTITY,
    INFO INTEGER, 
    TEXT  VARCHAR(400),
    SENDER INTEGER not null,
    RECEIVER INTEGER not null,
    CONSTRAINT EMAIL_PK PRIMARY KEY (IDMAIL),
    FOREIGN KEY (SENDER) 
        REFERENCES USERS(ID)
        ON DELETE CASCADE,
    FOREIGN KEY (RECEIVER) 
        REFERENCES USERS(ID)
        ON DELETE CASCADE,
    FOREIGN KEY (IDMAIL) 
        REFERENCES USERS(ID)
        ON DELETE CASCADE
);

CREATE TABLE USERSANONIMOUS (
    COOKIE varchar(30),
    PRIMARY KEY (COOKIE)

);

CREATE TABLE CLIST (
    IDCATEGORY INTEGER not null GENERATED ALWAYS AS IDENTITY,
    "NAME" VARCHAR(30),
    DESCRIPTION VARCHAR(30),
    IMAGE VARCHAR(10),
    CONSTRAINT CLIST_PK PRIMARY KEY (IDCATEGORY)
);


CREATE TABLE LIST (
    IDLIST INTEGER not null GENERATED ALWAYS AS IDENTITY,
    USERCREATOR INTEGER,  
    IDCAT INTEGER,
    "NAME" VARCHAR(30),
    DESCRIPTION VARCHAR(30),
    IMAGE VARCHAR(50),
    FOREIGN KEY (USERCREATOR) 
        REFERENCES USERS(ID)
        ON DELETE CASCADE,
    FOREIGN KEY (IDCAT) 
        REFERENCES CLIST(IDCATEGORY)
        ON DELETE CASCADE,
    CONSTRAINT IDLIST_PK PRIMARY KEY (IDLIST)
);

CREATE TABLE CITEM (
    IDCATEGORY INTEGER not null GENERATED ALWAYS AS IDENTITY,
    "NAME" VARCHAR(30),
    DESCRIPTION VARCHAR(30),
    IMAGE VARCHAR(10),
    CONSTRAINT CITEM_PK PRIMARY KEY (IDCATEGORY)
);


CREATE TABLE ITEM (
    IDDCAT INTEGER not null,
    IDITEM INTEGER not null GENERATED ALWAYS AS IDENTITY,
    FOREIGN KEY (IDDCAT) 
        REFERENCES CITEM(IDCATEGORY)
        ON DELETE CASCADE,
    CALORIE INTEGER,
    "NAME" VARCHAR(30),
    LOGO VARCHAR(50),
    NOTE VARCHAR(30),
    CONSTRAINT ITEM_PK PRIMARY KEY (IDITEM)
);


CREATE TABLE COMPOSE(
    CCLIST INTEGER,
    CCITEM INTEGER ,
    FOREIGN KEY (CCITEM) 
        REFERENCES ITEM(IDITEM)
        ON DELETE CASCADE,
    FOREIGN KEY (CCLIST) 
        REFERENCES LIST(IDLIST)
        ON DELETE CASCADE,
    primary key (CCITEM, CCLIST)  
);

CREATE TABLE ISFRIEND(
    USR1 INTEGER ,
    USR2 INTEGER ,
    FOREIGN KEY (USR1) 
        REFERENCES USERS(ID)
        ON DELETE CASCADE,
    FOREIGN KEY (USR2) 
        REFERENCES USERS(ID)
        ON DELETE CASCADE,
    primary key (USR1, USR2)  
);

CREATE TABLE ACCESS(
    AAUSER INTEGER,
    AALIST INTEGER,
    FOREIGN KEY (AAUSER) 
        REFERENCES USERS(ID)
        ON DELETE CASCADE,
    FOREIGN KEY (AALIST) 
        REFERENCES LIST(IDLIST)
        ON DELETE CASCADE,
    primary key (AAUSER, AALIST)    
);


