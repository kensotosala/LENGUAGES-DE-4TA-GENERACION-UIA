--- ===== ENUNCIADOS PRODECIMIENTOS ALMACENADOS =====


--> ENUNCIAD0 1
CREATE OR REPLACE PROCEDURE visualizar IS
BEGIN
    FOR emp IN (SELECT FIRST_NAME, LAST_NAME, SALARY FROM EMPLOYEES) LOOP
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || emp.FIRST_NAME || ' ' || emp.LAST_NAME || ', Salario: ' || emp.SALARY);
    END LOOP;
END;
/

BEGIN
    visualizar;
END;
/

--> ENUNCIAD0 2
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE visualizar (
    p_departamento_id IN NUMBER,
    p_num_empleados OUT NUMBER
) IS
BEGIN
    p_num_empleados := 0;

    FOR emp IN (SELECT FIRST_NAME, LAST_NAME, SALARY 
                FROM EMPLOYEES 
                WHERE DEPARTMENT_ID = p_departamento_id) LOOP
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || emp.FIRST_NAME || ' ' || emp.LAST_NAME || ', Salario: ' || emp.SALARY);
        p_num_empleados := p_num_empleados + 1;
    END LOOP;
END;
/

DECLARE
    num_empleados NUMBER;
BEGIN
    visualizar(100, num_empleados);
END;
/

--> ENUNCIAD0 3
CREATE OR REPLACE PROCEDURE spFormatearNumCuenta (
    p_numero_cuenta IN OUT VARCHAR2
) IS
BEGIN
    p_numero_cuenta := SUBSTR(p_numero_cuenta, 1, 4) || '-' ||
                       SUBSTR(p_numero_cuenta, 5, 4) || '-' ||
                       SUBSTR(p_numero_cuenta, 9, 2) || '-' ||
                       SUBSTR(p_numero_cuenta, 11);
END;
/

DECLARE
    v_numero_cuenta VARCHAR2(24) := '11111111111111111111';
BEGIN
    spFormatearNumCuenta(v_numero_cuenta);
    DBMS_OUTPUT.PUT_LINE('Número de cuenta formateado: ' || v_numero_cuenta);
END;
/





