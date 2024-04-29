-- SCHEMA: tracker

-- DROP SCHEMA IF EXISTS tracker ;

CREATE SCHEMA IF NOT EXISTS tracker
    AUTHORIZATION psadmin;

-- Table: tracker.migrinventory

-- DROP TABLE IF EXISTS tracker.migrinventory;

CREATE TABLE IF NOT EXISTS tracker.migrinventory
(
    objid bigserial NOT NULL PRIMARY KEY,
    dbname character varying(38) COLLATE pg_catalog."default" NOT NULL,
    schname character varying(138) COLLATE pg_catalog."default" NOT NULL,
    objtype character varying(138) COLLATE pg_catalog."default" NOT NULL,
    srtorder integer,
    objname character varying(138) COLLATE pg_catalog."default" NOT NULL,
    ostatus character varying(12) COLLATE pg_catalog."default",
    extractdate timestamp(0) without time zone,
    inpostgres character(1) COLLATE pg_catalog."default",
    snapdate timestamp(0) without time zone,
    pg_name character varying(138) COLLATE pg_catalog."default",
    pg_type character varying(138) COLLATE pg_catalog."default",
    migrdate timestamp(0) without time zone
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS tracker.migrinventory
    OWNER to psadmin;