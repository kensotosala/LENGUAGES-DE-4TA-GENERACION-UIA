-- =========== QUIZ 1 ===========

SET SERVEROUTPUT ON

-- 1. Crear una SELECT que devuelva el nombre de un empleado pasándole el EMPLOYEE_ID en el WHERE.
DECLARE
    nombreEmpleado VARCHAR2(100);
BEGIN
    SELECT FIRST_NAME || ' ' || LAST_NAME 
    INTO nombreEmpleado
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 10;

    DBMS_OUTPUT.PUT_LINE('Nombre del empleado: ' || nombreEmpleado);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('El empleado no existe');
END;
/

-- 2. Modificar la SELECT para que devuelva más de un empleado, controlando la excepción TOO_MANY_ROWS.
DECLARE
    nombreEmpleado VARCHAR2(100);
BEGIN
    SELECT FIRST_NAME || ' ' || LAST_NAME 
    INTO nombreEmpleado
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID > 10; 

    DBMS_OUTPUT.PUT_LINE('Nombre del empleado: ' || nombreEmpleado);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('El empleado no existe');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Demasiados empleados en la consulta');
END;
/

-- 3. Modificar la consulta para generar un error de división por CERO y capturarlo con WHEN OTHERS.
DECLARE
    valorSalario NUMBER;
BEGIN
    SELECT SALARY / 0 
    INTO valorSalario
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 11; 

    DBMS_OUTPUT.PUT_LINE('Salario del empleado: ' || valorSalario);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
END;
/

-- 4. Crear una excepción no predefinida para manejar la clave primaria duplicada.
DECLARE
    duplicado EXCEPTION;
    PRAGMA EXCEPTION_INIT(duplicado, -00001);
BEGIN
    INSERT INTO REGIONS (REGION_ID, REGION_NAME) VALUES (1, 'Duplicado');

EXCEPTION
    WHEN duplicado THEN
        DBMS_OUTPUT.PUT_LINE('Clave duplicada, intente otra');
END;
/

-- 5. Crear una excepción personalizada CONTROL_REGIONES.
DECLARE
    CONTROL_REGIONES EXCEPTION;
    valorRegionID NUMBER := 201;
BEGIN
    IF valorRegionID > 200 THEN
        RAISE CONTROL_REGIONES;
    END IF;

    INSERT INTO REGIONS (REGION_ID, REGION_NAME) VALUES (1, 'Duplicado');

EXCEPTION
    WHEN CONTROL_REGIONES THEN
        DBMS_OUTPUT.PUT_LINE('Código no permitido. Debe ser inferior a 200');
END;
/


-- 6. Modificar la práctica anterior para usar RAISE_APPLICATION_ERROR.
DECLARE
    valorRegionID NUMBER := 51;
BEGIN
    IF valorRegionID > 50 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Código no permitido. Debe ser inferior a 50');
    END IF;

    INSERT INTO REGIONS (REGION_ID, REGION_NAME) VALUES (valorRegionID, 'Nueva Región');
END;
/




