
--Configuración Inicial

SET DATEFORMAT dmy
SET DATEFIRST 1
SET LANGUAGE SPANISH 

/*Base de datos destino*/
use BD_MART
GO

/*Creación de la tabla*/
create table DIM_FECHA
(
    Fecha_KEY int not null,
    Fecha date not null, 
    Anio smallint not null,
    Trimestre smallint not null,
    Mes smallint not null,
    Semana smallint not null,
    Dia smallint not null,
    DiaSemana smallint not null,
    NTrimestre char(7) not null,
    NMes char(15) not null,
    NMes3L char(3) not null,
    NSemana char(10) not null,
    NDia char(6) not null,
    NDiaSemana char(10) not null,
	DiaAnio smallint not null,
	Semestre tinyint not null
    constraint PK_DIM_FECHA PRIMARY KEY CLUSTERED
    (
        Fecha asc
    )
)

/*Script de carga*/
DECLARE @FechaDesde as smalldatetime, @FechaHasta as smalldatetime
DECLARE @FechaAAAAMMDD int
DECLARE @Anio as smallint, @Trimestre char(2), @Mes smallint
DECLARE @Semana smallint, @Dia smallint, @DiaSemana smallint
DECLARE @NTrimestre char(7), @NMes char(15)
DECLARE @NMes3l char(3)
DECLARE @NSemana char(10), @NDia char(6), @NDiaSemana char(10)
DECLARE @DiaAnio as smallint
DECLARE @Semestre as tinyint


BEGIN TRANSACTION
    --Borrar datos actuales
    --TRUNCATE TABLE DIM_FECHA
   
    --Rango de fechas a generar: del 01/01/2018 al 31 de dic de dos años siguientes a la fecha actual

    SELECT @FechaDesde = CAST('20180101' AS smalldatetime)
    SELECT @FechaHasta = CAST(CAST(YEAR(GETDATE())+2 AS CHAR(4)) + '1231' AS smalldatetime)
   
    WHILE (@FechaDesde <= @FechaHasta) BEGIN
		SELECT @FechaAAAAMMDD = YEAR(@FechaDesde)*10000+
								MONTH(@FechaDesde)*100+
								DATEPART(dd, @FechaDesde)
		SELECT @Anio = DATEPART(yy, @FechaDesde)                   -- 2017
		SELECT @Trimestre = DATEPART(qq, @FechaDesde)              -- 1
		SELECT @Mes = DATEPART(m, @FechaDesde)                     -- 1
		SELECT @Semana = DATEPART(wk, @FechaDesde)                 -- 1
		SELECT @Dia = RIGHT('0' + DATEPART(dd, @FechaDesde),2)    
		SELECT @DiaSemana = DATEPART(DW, @FechaDesde)
		SELECT @NMes = DATENAME(mm, @FechaDesde)                   -- Enero
		SELECT @NMes3l = LEFT(@NMes, 3)                            -- Ene
		SELECT @NTrimestre = 'T' + CAST(@Trimestre as CHAR(1)) + '/' + RIGHT(@Anio, 2)  -- T1/07
		SELECT @NSemana = 'Sem ' +CAST(@Semana AS CHAR(2)) + '/' + RIGHT(RTRIM(CAST(@Anio as CHAR(4))),2)    
		SELECT @NDia = CAST(@Dia as CHAR(2)) + ' ' + RTRIM(@NMes)                       -- 1 Enero
		SELECT @NDiaSemana = DATENAME(dw, @FechaDesde)                                  -- Lunes
		SELECT @DiaAnio = DATEPART(dy,@FechaDesde)
		SELECT @Semestre = ((DATEPART(month,@FechaDesde)-1)/6)+1
		INSERT INTO BD_MART.dbo.DIM_FECHA
		(
			Fecha_Key,
			Fecha,
			Anio,
			Trimestre,
			Mes,
			Semana,
			Dia,
			DiaSemana,
			NTrimestre,
			NMes,
			NMes3L,
			NSemana,
			NDia,
			NDiaSemana,
			DiaAnio,
			Semestre
		) VALUES
		(
			@FechaAAAAMMDD,
			@FechaDesde,
			@Anio,
			@Trimestre,
			@Mes,
			@Semana,
			@Dia,
			@DiaSemana,
			@NTrimestre,
			@NMes,
			@NMes3l,
			@NSemana,
			@NDia,
			@NDiaSemana,
			@DiaAnio,
			@Semestre
		)
   
		--Incremento del ciclo
		SELECT @FechaDesde = DATEADD(DAY, 1, @FechaDesde)
    END
    COMMIT 