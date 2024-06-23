-- ===== CURSORES =====
SET SERVEROUTPUT ON;

--> ENUNCIADO 1
DECLARE
    -- Declaración del cursor
    CURSOR c_empleados IS
        SELECT EMPLOYEE_ID, LAST_NAME, SALARY
        FROM EMPLOYEES;
    
    -- Variables para almacenar datos del cursor
    v_employee_id employees.employee_id%TYPE;
    v_last_name employees.last_name%TYPE;
    v_salary employees.salary%TYPE;
BEGIN
    -- Habilitar la salida de DBMS_OUTPUT
    DBMS_OUTPUT.ENABLE;
    
    OPEN c_empleados;
    
    -- Recorrer el cursor
    LOOP
        FETCH c_empleados INTO v_employee_id, v_last_name, v_salary;
        EXIT WHEN c_empleados%NOTFOUND;
        
        IF v_last_name = 'King' THEN
            RAISE_APPLICATION_ERROR(-20001, 'El salario del jefe (' || v_last_name || ') no se puede ver.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Empleado: ' || v_last_name || ', Salario: ' || v_salary);
        END IF;
    END LOOP;
    
    CLOSE c_empleados;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron más registros.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

--> ENUNCIADO 2
DECLARE
    CURSOR c_empleados IS
        SELECT EMPLOYEE_ID, FIRST_NAME || ' ' || LAST_NAME AS EMPLOYEE_NAME
        FROM EMPLOYEES;
    
    CURSOR c_departamentos(p_employee_id NUMBER) IS
        SELECT D.DEPARTMENT_NAME, E.FIRST_NAME || ' ' || E.LAST_NAME AS MANAGER_NAME
        FROM DEPARTMENTS D, EMPLOYEES E
        WHERE D.MANAGER_ID = p_employee_id
        AND E.EMPLOYEE_ID = p_employee_id;
    
    v_department_name DEPARTMENTS.DEPARTMENT_NAME%TYPE;
    v_manager_name EMPLOYEES.FIRST_NAME%TYPE;
    v_employee_name EMPLOYEES.FIRST_NAME%TYPE;
BEGIN
    FOR emp_rec IN c_empleados LOOP
        v_employee_name := emp_rec.EMPLOYEE_NAME;
        
        OPEN c_departamentos(emp_rec.EMPLOYEE_ID);
        FETCH c_departamentos INTO v_department_name, v_manager_name;
        
        IF c_departamentos%FOUND THEN
            DBMS_OUTPUT.PUT_LINE(v_employee_name || ' es jefe del departamento ' || v_department_name ||
                                 ' (Manager: ' || v_manager_name || ')');
        ELSE
            DBMS_OUTPUT.PUT_LINE(v_employee_name || ' no es jefe de nada');
        END IF;
        
        CLOSE c_departamentos;
    END LOOP;
END;
/

--> ENUNCIADO 3
DECLARE
    v_department_id DEPARTMENTS.DEPARTMENT_ID%TYPE := &department_id;
    v_employee_count NUMBER;
    
    CURSOR c_employee_count(p_department_id DEPARTMENTS.DEPARTMENT_ID%TYPE) IS
        SELECT COUNT(*)
        FROM EMPLOYEES
        WHERE DEPARTMENT_ID = p_department_id;
BEGIN
    OPEN c_employee_count(v_department_id);
    
    FETCH c_employee_count INTO v_employee_count;
    
    IF c_employee_count%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Número de empleados en el departamento ' || v_department_id || ': ' || v_employee_count);
    ELSE
        DBMS_OUTPUT.PUT_LINE('No se encontraron empleados para el departamento ' || v_department_id);
    END IF;
    
    CLOSE c_employee_count;
END;
/

--> ENUNCIADO 4
BEGIN
    FOR emp_rec IN (SELECT FIRST_NAME || ' ' || LAST_NAME AS EMPLOYEE_NAME
                    FROM EMPLOYEES
                    WHERE JOB_ID = 'ST_CLERK')
    LOOP
        DBMS_OUTPUT.PUT_LINE('Empleado: ' || emp_rec.EMPLOYEE_NAME);
    END LOOP;
END;
/

--> ENUNCIADO 5
DECLARE
    CURSOR c_empleados IS
        SELECT EMPLOYEE_ID, SALARY
        FROM EMPLOYEES
        FOR UPDATE OF SALARY;
        
    v_employee_id EMPLOYEES.EMPLOYEE_ID%TYPE;
    v_salary EMPLOYEES.SALARY%TYPE;
BEGIN
    OPEN c_empleados;
    
    LOOP
        FETCH c_empleados INTO v_employee_id, v_salary;
        EXIT WHEN c_empleados%NOTFOUND;
        
        IF v_salary > 8000 THEN
            UPDATE EMPLOYEES
            SET SALARY = SALARY * 1.02
            WHERE CURRENT OF c_empleados;
        ELSIF v_salary < 8000 THEN
            UPDATE EMPLOYEES
            SET SALARY = SALARY * 1.03
            WHERE CURRENT OF c_empleados;
        END IF;
    END LOOP;
    
    CLOSE c_empleados;
    
    FOR emp_rec IN (SELECT EMPLOYEE_ID, SALARY FROM EMPLOYEES)
    LOOP
        DBMS_OUTPUT.PUT_LINE('Empleado ' || emp_rec.EMPLOYEE_ID || ': Nuevo salario = ' || emp_rec.SALARY);
    END LOOP;
END;
/













