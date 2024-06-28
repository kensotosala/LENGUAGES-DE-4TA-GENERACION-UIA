SET SERVEROUTPUT ON
-- 1.Crear un TRIGGER BEFORE DELETE sobre la tabla EMPLOYEES que impida
-- borrar un registro si su JOB_ID es algo relacionado con CLERK.
CREATE OR REPLACE TRIGGER TRG_Impedir_Borrado_Clerk
BEFORE DELETE ON EMPLOYEES
FOR EACH ROW
BEGIN
  IF :OLD.JOB_ID LIKE '%CLERK%' THEN
    RAISE_APPLICATION_ERROR(-20001, 'No se puede eliminar un empleado con un JOB_ID relacionado con CLERK');
  END IF;
END;
/

-- 2. Crear una tabla denominada AUDITORIA con las siguientes columnas:
CREATE TABLE AUDITORIA (
    usuario VARCHAR2(50),
    fecha DATE,
    salario_antiguo NUMBER,
    salario_nuevo NUMBER
);

-- 3. Crear un TRIGGER BEFORE INSERT de tipo STATEMENT, de forma que cada
-- vez que se haga un INSERT en la tabla REGIONS guarde una fila en la tabla
-- AUDITORIA con el usuario y la fecha en la que se ha hecho el INSERT

CREATE OR REPLACE TRIGGER TRG_AUDITAR_INSERT_REGIONES
BEFORE INSERT ON REGIONS
DECLARE
    valorUsuario VARCHAR2(50);
BEGIN
    SELECT USER INTO valorUsuario FROM dual;
    
    INSERT INTO auditoria (usuario, fecha)
    VALUES (valorUsuario, SYSDATE);
    
    DBMS_OUTPUT.PUT_LINE('Se ha registrado un INSERT en la tabla REGIONS en AUDITORIA por el usuario: ' || valorUsuario);
END;
/

-- 4. Realizar otro trigger BEFORE UPDATE de la columna SALARY de tipo EACH ROW.
CREATE OR REPLACE TRIGGER TRG_AUDITAR_SALARIO
BEFORE UPDATE OF SALARY ON EMPLOYEES
FOR EACH ROW
DECLARE
    valorUsuario VARCHAR2(50);
BEGIN
    SELECT USER INTO valorUsuario FROM dual;
    
    IF :NEW.SALARY < :OLD.SALARY THEN
        RAISE_APPLICATION_ERROR(-10001, 'No se puede bajar un salario');
    ELSIF :NEW.SALARY > :OLD.SALARY THEN
        INSERT INTO auditoria (usuario, fecha, salario_antiguo, salario_nuevo)
        VALUES (valorUsuario, SYSDATE, :OLD.salary, :NEW.salary);
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('Se ha registrado un UPDATE en la tabla EMPLOYEES en AUDITORIA por el usuario: ' || valorUsuario);
END;
/

-- 5. Crear un TRIGGER BEFORE INSERT en la tabla DEPARTMENTS que al
-- insertar un departamento compruebe que el código no esté repetido y luego que
-- si el LOCATION_ID es NULL le ponga 1700 y si el MANAGER_ID es NULL
-- le ponga 200

CREATE OR REPLACE TRIGGER TRG_ANTES_DE_INSERT_DEPARTMENTS
BEFORE INSERT ON departments
FOR EACH ROW
DECLARE
    valorLocationID NUMBER := 1700;
    valorManagerID NUMBER := 200;
BEGIN
    IF :NEW.department_id IS NOT NULL THEN
        FOR existing_dept IN (SELECT 1 FROM departments WHERE department_id = :NEW.department_id) LOOP
            RAISE_APPLICATION_ERROR(-20001, 'El código de departamento ya está en uso');
        END LOOP;
    END IF;

    IF :NEW.location_id IS NULL THEN
        :NEW.location_id := valorLocationID;
    END IF;

    IF :NEW.manager_id IS NULL THEN
        :NEW.manager_id := valorManagerID;
    END IF;
END;
/

describe departments;









