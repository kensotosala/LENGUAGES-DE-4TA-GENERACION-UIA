-- 1. Procedimiento PA_Visualizar
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE PA_Visualizar IS
BEGIN
    FOR emp IN (SELECT FIRST_NAME, LAST_NAME, SALARY FROM EMPLOYEES) LOOP
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || emp.FIRST_NAME || ', Apellido: ' || emp.LAST_NAME || ', Salario: ' || emp.SALARY);
    END LOOP;
END PA_Visualizar;
/

BEGIN
    PA_Visualizar;
END;
/

-- 2. Procedimiento PA_Visualizar con parámetro de departamento y variable OUT
CREATE OR REPLACE PROCEDURE PA_Visualizar(
    num_departamento IN employees.department_id%TYPE,
    num_empleados OUT NUMBER
) IS
BEGIN
    num_empleados := 0;
    FOR emp IN (SELECT first_name, salary FROM employees WHERE department_id = num_departamento) LOOP
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || emp.first_name || ', Salario: ' || emp.salary);
        num_empleados := num_empleados + 1;
    END LOOP;
END PA_Visualizar;
/

DECLARE
    v_num_empleados NUMBER;
BEGIN
    PA_Visualizar(10, v_num_empleados); 
    DBMS_OUTPUT.PUT_LINE('Número de empleados: ' || v_num_empleados);
END;
/

-- 3. Bloque para formatear un número de cuenta
CREATE OR REPLACE PROCEDURE FomatearNumerCuenta (
    p_cuenta IN OUT VARCHAR2
) IS
BEGIN
    p_cuenta := SUBSTR(p_cuenta, 1, 4) || '-' || 
                 SUBSTR(p_cuenta, 5, 4) || '-' || 
                 SUBSTR(p_cuenta, 9, 2) || '-' || 
                 SUBSTR(p_cuenta, 11, 10);
END FomatearNumerCuenta;
/

DECLARE
    v_cuenta VARCHAR2(23) := '11111111111111111111';
BEGIN
    FomatearNumerCuenta(v_cuenta);
    DBMS_OUTPUT.PUT_LINE('Cuenta formateada: ' || v_cuenta);
END;
/

-- 4. Función para sumar salarios de un departamento con excepciones
CREATE OR REPLACE FUNCTION FN_SumaSalarios(
    num_departamento IN employees.department_id%TYPE
) RETURN NUMBER IS
    v_suma_salarios NUMBER := 0;
    v_count NUMBER := 0;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM employees
    WHERE department_id = num_departamento;

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'El departamento no existe.');
    END IF;

    SELECT SUM(salary) INTO v_suma_salarios 
    FROM employees 
    WHERE department_id = num_departamento;

    IF v_suma_salarios IS NULL THEN
        RAISE_APPLICATION_ERROR(-20003, 'El departamento existe, pero no tiene empleados.');
    END IF;

    RETURN v_suma_salarios;
END FN_SumaSalarios;
/

DECLARE
    v_suma_salarios NUMBER;
BEGIN
    v_suma_salarios := FN_SumaSalarios(10);
    DBMS_OUTPUT.PUT_LINE('Suma de salarios: ' || v_suma_salarios);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- 5. Modificaciónn de la funciónn anterior con parametro OUT para número de empleados
CREATE OR REPLACE FUNCTION FN_SumaSalarios(
    p_department_id IN EMPLOYEES.DEPARTMENT_ID%TYPE,
    p_num_empleados OUT NUMBER
) RETURN NUMBER IS
    v_suma_salarios NUMBER := 0;
BEGIN
    SELECT SUM(SALARY), COUNT(*) INTO v_suma_salarios, p_num_empleados
    FROM EMPLOYEES 
    WHERE DEPARTMENT_ID = p_department_id;
    
    IF p_num_empleados = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'No hay empleados en el departamento.');
    END IF;
    
    RETURN v_suma_salarios;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'El departamento no existe.');
END FN_SumaSalarios;
/


DECLARE
    v_department_id NUMBER := 10;
    v_total_salary NUMBER;
    v_num_employees NUMBER;
BEGIN
    v_total_salary := FN_SumaSalarios(v_department_id, v_num_employees);
    
    DBMS_OUTPUT.PUT_LINE('Department ID: ' || v_department_id);
    DBMS_OUTPUT.PUT_LINE('Total Salary: $' || v_total_salary);
    DBMS_OUTPUT.PUT_LINE('Number of Employees: ' || v_num_employees);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- 6. Función FN_CREAR_REGION
CREATE OR REPLACE FUNCTION FN_CREAR_REGION(
    p_nombre_region IN VARCHAR2
) RETURN NUMBER IS
    v_codigo_region NUMBER;
BEGIN
    SELECT NVL(MAX(REGION_ID), 0) + 1 INTO v_codigo_region FROM REGIONS;
    
    INSERT INTO REGIONS (REGION_ID, REGION_NAME) 
    VALUES (v_codigo_region, p_nombre_region);
    
    RETURN v_codigo_region;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003, 'Error al crear la nueva región.');
END FN_CREAR_REGION;
/

DECLARE
    v_new_region_id NUMBER;
BEGIN
    v_new_region_id := FN_CREAR_REGION('REGION DE PRUEBA');
    DBMS_OUTPUT.PUT_LINE('Nueva región creada con ID: ' || v_new_region_id);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
