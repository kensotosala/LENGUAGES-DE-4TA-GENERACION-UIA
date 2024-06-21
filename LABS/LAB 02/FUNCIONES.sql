-- ===== FUNCIONES =====

--> ENUNCIAD0 1
CREATE OR REPLACE FUNCTION fnSumarSalarios (
    p_departamento_id IN NUMBER
) RETURN NUMBER IS
    v_suma_salarios NUMBER;
    v_num_empleados NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_num_empleados
    FROM DEPARTMENTS
    WHERE DEPARTMENT_ID = p_departamento_id;

    IF v_num_empleados = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El departamento no existe.');
    END IF;

    SELECT SUM(SALARY), COUNT(*)
    INTO v_suma_salarios, v_num_empleados
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = p_departamento_id;

    IF v_num_empleados = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'El departamento existe, pero no tiene empleados.');
    END IF;

    RETURN v_suma_salarios;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20003, 'No se encontraron datos.');
END;
/

DECLARE
    v_departamento_id NUMBER := 100;
    v_suma_salarios NUMBER;
BEGIN
    v_suma_salarios := fnSumarSalarios(v_departamento_id);
    DBMS_OUTPUT.PUT_LINE('La suma de los salarios del departamento ' || v_departamento_id || ' es: ' || v_suma_salarios);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

--> ENUNCIAD0 2

CREATE OR REPLACE TYPE salario_info AS OBJECT (
    suma_salarios NUMBER,
    num_empleados NUMBER
);
/

CREATE OR REPLACE FUNCTION fnSumarSalariosByID (
    p_departamento_id IN NUMBER
) RETURN salario_info IS
    v_suma_salarios NUMBER;
    v_num_empleados NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_num_empleados
    FROM DEPARTMENTS
    WHERE DEPARTMENT_ID = p_departamento_id;

    IF v_num_empleados = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El departamento no existe.');
    END IF;

    SELECT NVL(SUM(SALARY), 0), COUNT(*)
    INTO v_suma_salarios, v_num_empleados
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = p_departamento_id;

    IF v_num_empleados = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'El departamento existe, pero no tiene empleados.');
    END IF;

    RETURN salario_info(v_suma_salarios, v_num_empleados);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20003, 'No se encontraron datos.');
END;
/

DECLARE
    v_departamento_id NUMBER := 100;
    v_salario_info salario_info;
BEGIN
    v_salario_info := fnSumarSalariosByID(v_departamento_id);

    DBMS_OUTPUT.PUT_LINE('La suma de los salarios del departamento ' || v_departamento_id || ' es: ' || v_salario_info.suma_salarios);
    DBMS_OUTPUT.PUT_LINE('Número de empleados en el departamento ' || v_departamento_id || ': ' || v_salario_info.num_empleados);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/


--> ENUNCIAD0 3
CREATE OR REPLACE FUNCTION CREAR_REGION (
    p_nombre_region IN VARCHAR2
) RETURN NUMBER IS
    v_codigo_region NUMBER;
BEGIN
    SELECT MAX(REGION_ID) + 1
    INTO v_codigo_region
    FROM REGIONS;

    IF v_codigo_region IS NULL THEN
        v_codigo_region := 1;
    END IF;

    INSERT INTO REGIONS (REGION_ID, REGION_NAME)
    VALUES (v_codigo_region, p_nombre_region);

    COMMIT;

    RETURN v_codigo_region;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'Error al crear la región: ' || SQLERRM);
END;
/

DECLARE
    v_nombre_region VARCHAR2(100) := 'Johto';
    v_codigo_region NUMBER;
BEGIN
    v_codigo_region := CREAR_REGION(v_nombre_region);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al crear la región: ' || SQLERRM);
END;
/

SELECT * FROM REGIONS;






