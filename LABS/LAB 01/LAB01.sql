-- ======= 1. Comando IF - Enunciado 1 =======
DECLARE
  num NUMBER := 89; 
BEGIN
  IF MOD(num, 2) = 0 THEN
    DBMS_OUTPUT.PUT_LINE('El número ' || num || ' es PAR.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('El número ' || num || ' es IMPAR.');
  END IF;
END;

-- ======= 2. Comando IF - Enunciado 2 =======
DECLARE 
    TIPO_PRODUCTO CHAR(1) := 'R';
BEGIN 
    IF TIPO_PRODUCTO = 'A' 
        THEN DBMS_OUTPUT.PUT_LINE ('Electrónica');
    ELSIF TIPO_PRODUCTO = 'B' 
        THEN DBMS_OUTPUT.PUT_LINE ('Informática');
    ELSIF TIPO_PRODUCTO = 'C' 
        THEN DBMS_OUTPUT.PUT_LINE ('Ropa');
    ELSIF TIPO_PRODUCTO = 'D' 
        THEN DBMS_OUTPUT.PUT_LINE ('Música');
    ELSIF TIPO_PRODUCTO = 'E' 
        THEN DBMS_OUTPUT.PUT_LINE ('Libros');
    ELSE 
        DBMS_OUTPUT.PUT_LINE ('El código es incorrecto');
    END IF;
END;
/

-- ======= 3. Enunciado Comando CASE =======
DECLARE 
    usuario VARCHAR2(40) := 'SYS';
BEGIN 
    CASE usuario
        WHEN 'SYS' THEN DBMS_OUTPUT.PUT_LINE('Eres superadministrador');
        WHEN 'SYSTEM' THEN DBMS_OUTPUT.PUT_LINE('Eres un administrador normal');
        WHEN 'HR' THEN DBMS_OUTPUT.PUT_LINE('Eres de Recursos Humanos');
        ELSE 
            DBMS_OUTPUT.PUT_LINE ('Usuario no autorizado');
    END CASE;
END;
/

-- ======= 4. Enunciados BUCLES =======

-- 1. Bucles enunciado 1

-- LOOP
DECLARE
  i NUMBER := 1;
  j NUMBER;
BEGIN
  LOOP
    j := 1;
    LOOP
      DBMS_OUTPUT.PUT_LINE(i || ' x ' || j || ' = ' || (i * j));
      j := j + 1;
      EXIT WHEN j > 10;
    END LOOP;
    i := i + 1;
    EXIT WHEN i > 10;
  END LOOP;
END;
/

-- WHILE
DECLARE
  i NUMBER := 1;
  j NUMBER;
BEGIN
  WHILE i <= 10 LOOP
    j := 1;
    WHILE j <= 10 LOOP
      DBMS_OUTPUT.PUT_LINE(i || ' x ' || j || ' = ' || (i * j));
      j := j + 1;
    END LOOP;
    i := i + 1;
  END LOOP;
END;
/

-- FOR
BEGIN
  FOR i IN 1..10 LOOP
    FOR j IN 1..10 LOOP
      DBMS_OUTPUT.PUT_LINE(i || ' x ' || j || ' = ' || (i * j));
    END LOOP;
  END LOOP;
END;
/

-- 2. Bucles enunciado 2
DECLARE
  TEXTO VARCHAR2(100) := 'Soy del cuso de lenguages de 4ta generacion';
  TEXTO_INVERTIDO VARCHAR2(100) := '';
  LEN NUMBER;
  I NUMBER;
BEGIN
  LEN := LENGTH(TEXTO);
  I := LEN;

  WHILE I > 0 LOOP
    TEXTO_INVERTIDO := TEXTO_INVERTIDO || SUBSTR(TEXTO, I, 1);
    I := I - 1;
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('Texto original: ' || TEXTO);
  DBMS_OUTPUT.PUT_LINE('Texto invertido: ' || TEXTO_INVERTIDO);
END;
/

-- 3. Bucles enunciado 3
DECLARE
  TEXTO VARCHAR2(100) := 'Este es el laboratorio "x" del curso';
  TEXTO_INVERTIDO VARCHAR2(100) := '';
  LEN NUMBER;
  I NUMBER;
  CARACTER VARCHAR2(1);
BEGIN
  LEN := LENGTH(TEXTO);
  I := LEN;

  WHILE I > 0 LOOP
    CARACTER := SUBSTR(TEXTO, I, 1);
    IF UPPER(CARACTER) = 'X' THEN
      EXIT;
    END IF;
    TEXTO_INVERTIDO := TEXTO_INVERTIDO || CARACTER;
    I := I - 1;
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('Texto original: ' || TEXTO);
  DBMS_OUTPUT.PUT_LINE('Texto invertido hasta "x": ' || TEXTO_INVERTIDO);
END;
/

-- 4. Bucles enunciado 4
DECLARE
  NOMBRE VARCHAR2(100) := 'Kendall'; 
  i NUMBER;
BEGIN
  FOR i IN 1..LENGTH(NOMBRE) LOOP
    DBMS_OUTPUT.PUT('*');
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('');
END;
/












