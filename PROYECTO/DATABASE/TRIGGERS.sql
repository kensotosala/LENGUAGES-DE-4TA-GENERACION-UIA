-- Trigger para evitar citas duplicadas para el mismo cliente y médico en la misma fecha y hora:
CREATE OR REPLACE TRIGGER TRG_NO_CITAS_DUPLICADAS
BEFORE INSERT ON THOSP_CITAS
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM THOSP_CITAS 
    WHERE TN_IdCliente = :NEW.TN_IdCliente 
    AND TN_IdMedico = :NEW.TN_IdMedico 
    AND TF_FecCita = :NEW.TF_FecCita;
    
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El cliente ya tiene una cita con este médico en la misma fecha y hora.');
    END IF;
END;
/

-- Trigger para actualizar el número de teléfono de un cliente y asegurarse de que no contenga caracteres no numéricos:
CREATE OR REPLACE TRIGGER TRG_VALIDAR_TELEFONO
BEFORE INSERT OR UPDATE ON THOSP_CLIENTES
FOR EACH ROW
BEGIN
    IF REGEXP_LIKE(:NEW.TC_NumTelefono, '[^0-9]') THEN
        RAISE_APPLICATION_ERROR(-20002, 'El número de teléfono solo debe contener dígitos.');
    END IF;
END;
/

-- Trigger para asegurarse de que los médicos solo se pueden eliminar si no tienen citas pendientes:
CREATE OR REPLACE TRIGGER TRG_CHECAR_CITAS_MEDICOS
BEFORE DELETE ON THOSP_MEDICOS
FOR EACH ROW
DECLARE
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM THOSP_CITAS WHERE TN_IdMedico = :OLD.TN_IdMedico;
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'No se puede eliminar un médico que tiene citas pendientes.');
    END IF;
END;
/

-- Trigger para auditar los cambios en la tabla de diagnósticos:
CREATE TABLE THOSP_DIAGNOSTICO_AUDIT (
    TN_IdAudit NUMBER PRIMARY KEY,
    TN_IdDiagnostico NUMBER,
    TC_DscDiagnostico VARCHAR2(500),
    TF_FecCambio TIMESTAMP,
    TC_Operacion VARCHAR2(10)
);

CREATE OR REPLACE TRIGGER TRG_AUDITAR_DIAGNOSTICOS
AFTER INSERT OR UPDATE OR DELETE ON THOSP_DIAGNOSTICO
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO THOSP_DIAGNOSTICO_AUDIT (
            TN_IdAudit, TN_IdDiagnostico, TC_DscDiagnostico, TF_FecCambio, TC_Operacion
        ) VALUES (
            SEQ_AUDIT.NEXTVAL, :NEW.TN_IdDiagnostico, :NEW.TC_DscDiagnostico, SYSTIMESTAMP, 'INSERT'
        );
    ELSIF UPDATING THEN
        INSERT INTO THOSP_DIAGNOSTICO_AUDIT (
            TN_IdAudit, TN_IdDiagnostico, TC_DscDiagnostico, TF_FecCambio, TC_Operacion
        ) VALUES (
            SEQ_AUDIT.NEXTVAL, :NEW.TN_IdDiagnostico, :NEW.TC_DscDiagnostico, SYSTIMESTAMP, 'UPDATE'
        );
    ELSIF DELETING THEN
        INSERT INTO THOSP_DIAGNOSTICO_AUDIT (
            TN_IdAudit, TN_IdDiagnostico, TC_DscDiagnostico, TF_FecCambio, TC_Operacion
        ) VALUES (
            SEQ_AUDIT.NEXTVAL, :OLD.TN_IdDiagnostico, :OLD.TC_DscDiagnostico, SYSTIMESTAMP, 'DELETE'
        );
    END IF;
END;
/

-- Trigger para evitar que se inserten citas en días no laborables (por ejemplo, sábados y domingos):
CREATE OR REPLACE TRIGGER TRG_NO_CITAS_FINES_DE_SEMANA
BEFORE INSERT ON THOSP_CITAS
FOR EACH ROW
DECLARE
    v_day_of_week NUMBER;
BEGIN
    v_day_of_week := TO_NUMBER(TO_CHAR(:NEW.TF_FecCita, 'D'));
    IF v_day_of_week IN (1, 7) THEN
        RAISE_APPLICATION_ERROR(-20004, 'No se pueden programar citas en fines de semana.');
    END IF;
END;
/

-- Trigger para auditar cambios en la tabla de clientes:
CREATE SEQUENCE SEQ_AUDIT
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE TABLE THOSP_CLIENTES_AUDIT (
    TN_IdAudit NUMBER PRIMARY KEY,
    TN_IdCliente NUMBER,
    TC_Nombre VARCHAR2(60),
    TC_Ap1 VARCHAR2(60),
    TC_Ap2 VARCHAR2(60),
    TC_NumTelefono VARCHAR2(15),
    TC_CorreoElectronico VARCHAR2(100),
    TF_FecCambio TIMESTAMP,
    TC_Operacion VARCHAR2(10)
);

CREATE OR REPLACE TRIGGER TRG_AUDITAR_CLIENTES
AFTER INSERT OR UPDATE OR DELETE ON THOSP_CLIENTES
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO THOSP_CLIENTES_AUDIT (
            TN_IdAudit, TN_IdCliente, TC_Nombre, TC_Ap1, TC_Ap2, TC_NumTelefono, TC_CorreoElectronico, TF_FecCambio, TC_Operacion
        ) VALUES (
            SEQ_AUDIT.NEXTVAL, :NEW.TN_IdCliente, :NEW.TC_Nombre, :NEW.TC_Ap1, :NEW.TC_Ap2, :NEW.TC_NumTelefono, :NEW.TC_CorreoElectronico, SYSTIMESTAMP, 'INSERT'
        );
    ELSIF UPDATING THEN
        INSERT INTO THOSP_CLIENTES_AUDIT (
            TN_IdAudit, TN_IdCliente, TC_Nombre, TC_Ap1, TC_Ap2, TC_NumTelefono, TC_CorreoElectronico, TF_FecCambio, TC_Operacion
        ) VALUES (
            SEQ_AUDIT.NEXTVAL, :NEW.TN_IdCliente, :NEW.TC_Nombre, :NEW.TC_Ap1, :NEW.TC_Ap2, :NEW.TC_NumTelefono, :NEW.TC_CorreoElectronico, SYSTIMESTAMP, 'UPDATE'
        );
    ELSIF DELETING THEN
        INSERT INTO THOSP_CLIENTES_AUDIT (
            TN_IdAudit, TN_IdCliente, TC_Nombre, TC_Ap1, TC_Ap2, TC_NumTelefono, TC_CorreoElectronico, TF_FecCambio, TC_Operacion
        ) VALUES (
            SEQ_AUDIT.NEXTVAL, :OLD.TN_IdCliente, :OLD.TC_Nombre, :OLD.TC_Ap1, :OLD.TC_Ap2, :OLD.TC_NumTelefono, :OLD.TC_CorreoElectronico, SYSTIMESTAMP, 'DELETE'
        );
    END IF;
END;
/

-- Trigger para validar que el correo electrónico de los clientes tenga un formato correcto:
CREATE OR REPLACE TRIGGER TRG_VALIDAR_CORREO
BEFORE INSERT OR UPDATE ON THOSP_CLIENTES
FOR EACH ROW
BEGIN
    IF NOT REGEXP_LIKE(:NEW.TC_CorreoElectronico, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$') THEN
        RAISE_APPLICATION_ERROR(-20005, 'El formato del correo electrónico no es válido.');
    END IF;
END;
/

