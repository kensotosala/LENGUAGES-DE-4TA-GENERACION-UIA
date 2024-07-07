-- ===== PROCEDIMIENTOS ALMACENDAOS =====

--    _____  _  _   ___   ___  ___   ___  _     ___  ___  _  _  _____  ___  ___ 
--   |_   _|| || | / _ \ / __|| _ \ / __|| |   |_ _|| __|| \| ||_   _|| __|/ __|
--     | |  | __ || (_) |\__ \|  _/| (__ | |__  | | | _| | .` |  | |  | _| \__ \
--     |_|  |_||_| \___/ |___/|_|___\___||____||___||___||_|\_|  |_|  |___||___/
--                              |___|                                           

-- >>>>>>> THOSP_CLIENTES <<<<<<<
CREATE OR REPLACE PROCEDURE PA_InsertarCliente(
    p_id_cliente IN THOSP_CLIENTES.TN_IdCliente%TYPE,
    p_nombre IN THOSP_CLIENTES.TC_Nombre%TYPE,
    p_apellido1 IN THOSP_CLIENTES.TC_Ap1%TYPE,
    p_apellido2 IN THOSP_CLIENTES.TC_Ap2%TYPE,
    p_num_telefono IN THOSP_CLIENTES.TC_NumTelefono%TYPE,
    p_correo_electronico IN THOSP_CLIENTES.TC_CorreoElectronico%TYPE
)
AS
BEGIN
    INSERT INTO THOSP_CLIENTES (TN_IdCliente, TC_Nombre, TC_Ap1, TC_Ap2, TC_NumTelefono, TC_CorreoElectronico)
    VALUES (p_id_cliente, p_nombre, p_apellido1, p_apellido2, p_num_telefono, p_correo_electronico);
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Cliente: ' || p_id_cliente || '. Agregado correctamente!');
EXCEPTION
    WHEN others THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/

CREATE OR REPLACE PROCEDURE PA_ActualizarCliente(
    p_id_cliente IN THOSP_CLIENTES.TN_IdCliente%TYPE,
    p_nombre IN THOSP_CLIENTES.TC_Nombre%TYPE,
    p_apellido1 IN THOSP_CLIENTES.TC_Ap1%TYPE,
    p_apellido2 IN THOSP_CLIENTES.TC_Ap2%TYPE,
    p_num_telefono IN THOSP_CLIENTES.TC_NumTelefono%TYPE,
    p_correo_electronico IN THOSP_CLIENTES.TC_CorreoElectronico%TYPE
)
AS
BEGIN
    UPDATE THOSP_CLIENTES
    SET TC_Nombre = p_nombre,
        TC_Ap1 = p_apellido1,
        TC_Ap2 = p_apellido2,
        TC_NumTelefono = p_num_telefono,
        TC_CorreoElectronico = p_correo_electronico
    WHERE TN_IdCliente = p_id_cliente;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Cliente: ' || p_id_cliente || '. Actualizado correctamente.');
EXCEPTION
    WHEN others THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/

CREATE OR REPLACE PROCEDURE PA_EliminarCliente(
    p_id_cliente IN THOSP_CLIENTES.TN_IdCliente%TYPE
)
AS
BEGIN
    DELETE FROM THOSP_CLIENTES
    WHERE TN_IdCliente = p_id_cliente;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Cliente: ' || p_id_cliente || ' Eliminado correctamente.');
EXCEPTION
    WHEN others THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/

CREATE OR REPLACE PROCEDURE PA_ListarClientes(
    p_lista_clientes OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_lista_clientes FOR
        SELECT TN_IdCliente, TC_Nombre, TC_Ap1, TC_Ap2, TC_NumTelefono, TC_CorreoElectronico
        FROM THOSP_CLIENTES;
END;
/

--    _____  _  _   ___   ___  ___   ___  ___  _____  _    ___ 
--   |_   _|| || | / _ \ / __|| _ \ / __||_ _||_   _|/_\  / __|
--     | |  | __ || (_) |\__ \|  _/| (__  | |   | | / _ \ \__ \
--     |_|  |_||_| \___/ |___/|_|___\___||___|  |_|/_/ \_\|___/
--                              |___|                          

-- >>>>>>> THOSP_CITAS <<<<<<<

CREATE SEQUENCE seq_cita_id
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE OR REPLACE PROCEDURE PA_AgendarCita(
    p_id_cliente IN THOSP_CITAS.TN_IdCliente%TYPE,
    p_id_medico IN THOSP_CITAS.TN_IdMedico%TYPE,
    p_id_especialidad IN THOSP_CITAS.TN_IdEspecialidad%TYPE,
    p_fecha_cita IN THOSP_CITAS.TF_FecCita%TYPE
)
AS
    v_id_cita THOSP_CITAS.TN_IdCita%TYPE;
BEGIN
    SELECT seq_cita_id.NEXTVAL INTO v_id_cita FROM dual;
    
    INSERT INTO THOSP_CITAS (TN_IdCita, TN_IdCliente, TN_IdMedico, TN_IdEspecialidad, TF_FecCita)
    VALUES (v_id_cita, p_id_cliente, p_id_medico, p_id_especialidad, p_fecha_cita);
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Cita: ' || v_id_cita || '. Agendada Correctamente!');
EXCEPTION
    WHEN others THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/

CREATE OR REPLACE PROCEDURE PA_ActualizarCita(
    p_id_cita IN THOSP_CITAS.TN_IdCita%TYPE,
    p_id_cliente IN THOSP_CITAS.TN_IdCliente%TYPE,
    p_id_medico IN THOSP_CITAS.TN_IdMedico%TYPE,
    p_id_especialidad IN THOSP_CITAS.TN_IdEspecialidad%TYPE,
    p_fecha_cita IN THOSP_CITAS.TF_FecCita%TYPE
)
AS
BEGIN
    UPDATE THOSP_CITAS
    SET TN_IdCliente = p_id_cliente,
        TN_IdMedico = p_id_medico,
        TN_IdEspecialidad = p_id_especialidad,
        TF_FecCita = p_fecha_cita
    WHERE TN_IdCita = p_id_cita;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Cita: ' || p_id_cita || '. Actualizada Correctamente!');
EXCEPTION
    WHEN others THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/

CREATE OR REPLACE PROCEDURE PA_EliminarCita(
    p_id_cita IN THOSP_CITAS.TN_IdCita%TYPE
)
AS
BEGIN
    DELETE FROM THOSP_CITAS
    WHERE TN_IdCita = p_id_cita;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Cita: ' || p_id_cita || '. Eliminada Correctamente!');
EXCEPTION
    WHEN others THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/

CREATE OR REPLACE PROCEDURE PA_ListarCitas(
    p_lista_citas OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_lista_citas FOR
        SELECT TN_IdCita, TN_IdCliente, TN_IdMedico, TN_IdEspecialidad, TF_FecCita
        FROM THOSP_CITAS;
END;
/

--    _____  _  _   ___   ___  ___   ___  ___    _    ___  _  _   ___   ___  _____  ___  ___  ___  
--   |_   _|| || | / _ \ / __|| _ \ |   \|_ _|  /_\  / __|| \| | / _ \ / __||_   _||_ _|/ __|/ _ \ 
--     | |  | __ || (_) |\__ \|  _/ | |) || |  / _ \| (_ || .` || (_) |\__ \  | |   | || (__| (_) |
--     |_|  |_||_| \___/ |___/|_|___|___/|___|/_/ \_\\___||_|\_| \___/ |___/  |_|  |___|\___|\___/ 
--                              |___|                                                                                                                                              

CREATE SEQUENCE seq_diagnostico_id
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE OR REPLACE PROCEDURE PA_AgregarDiagnostico(
    p_id_cita IN THOSP_DIAGNOSTICO.TN_IdCita%TYPE,
    p_dsc_diagnostico IN THOSP_DIAGNOSTICO.TC_DscDiagnostico%TYPE
)
AS
    v_id_diagnostico THOSP_DIAGNOSTICO.TN_IdDiagnostico%TYPE;
BEGIN
    SELECT seq_diagnostico_id.NEXTVAL INTO v_id_diagnostico FROM dual;
    
    INSERT INTO THOSP_DIAGNOSTICO (TN_IdDiagnostico, TN_IdCita, TC_DscDiagnostico)
    VALUES (v_id_diagnostico, p_id_cita, p_dsc_diagnostico);
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Diagnóstico ' || v_id_diagnostico || ' agregado correctamente.');
EXCEPTION
    WHEN others THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/

CREATE OR REPLACE PROCEDURE PA_EliminarDiagnostico(
    p_id_diagnostico IN THOSP_DIAGNOSTICO.TN_IdDiagnostico%TYPE
)
AS
BEGIN
    DELETE FROM THOSP_DIAGNOSTICO
    WHERE TN_IdDiagnostico = p_id_diagnostico;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Daignóstico ' || p_id_diagnostico || ' eliminado correctamente.');
EXCEPTION
    WHEN others THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/

CREATE OR REPLACE PROCEDURE PA_ActualizarDiagnostico(
    p_id_diagnostico IN THOSP_DIAGNOSTICO.TN_IdDiagnostico%TYPE,
    p_id_cita IN THOSP_DIAGNOSTICO.TN_IdCita%TYPE,
    p_dsc_diagnostico IN THOSP_DIAGNOSTICO.TC_DscDiagnostico%TYPE
)
AS
BEGIN
    UPDATE THOSP_DIAGNOSTICO
    SET TN_IdCita = p_id_cita,
        TC_DscDiagnostico = p_dsc_diagnostico
    WHERE TN_IdDiagnostico = p_id_diagnostico;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Daignóstico ' || p_id_diagnostico || ' actualizado correctamente.');
EXCEPTION
    WHEN others THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/

CREATE OR REPLACE PROCEDURE PA_ListarDiagnostico(
    p_lista_diagnosticos OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_lista_diagnosticos FOR
        SELECT TN_IdDiagnostico, TN_IdCita, TC_DscDiagnostico
        FROM THOSP_DIAGNOSTICO;
END;
/

--    _____  _  _   ___   ___  ___   ___  ___  ___  ___  ___  ___    _    _     ___  ___    _    ___   ___  ___ 
--   |_   _|| || | / _ \ / __|| _ \ | __|/ __|| _ \| __|/ __||_ _|  /_\  | |   |_ _||   \  /_\  |   \ | __|/ __|
--     | |  | __ || (_) |\__ \|  _/ | _| \__ \|  _/| _|| (__  | |  / _ \ | |__  | | | |) |/ _ \ | |) || _| \__ \
--     |_|  |_||_| \___/ |___/|_|___|___||___/|_|  |___|\___||___|/_/ \_\|____||___||___//_/ \_\|___/ |___||___/
--                              |___|                                                                           

CREATE SEQUENCE SEQ_ESPECIALIDAD_ID
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
/

CREATE OR REPLACE PROCEDURE PA_AgregarEspecialidad(
    p_dsc_especialidad IN THOSP_ESPECIALIDADES.TC_DscEspecialidad%TYPE
)
AS
    v_id_especialidad THOSP_ESPECIALIDADES.TN_IdEspecialidad%TYPE;
BEGIN
    v_id_especialidad := SEQ_ESPECIALIDAD_ID.NEXTVAL;
    
    INSERT INTO THOSP_ESPECIALIDADES (TN_IdEspecialidad, TC_DscEspecialidad)
    VALUES (v_id_especialidad, p_dsc_especialidad);
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Especialidad ' || v_id_especialidad || ' agregada correctamente.');
EXCEPTION
    WHEN others THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/

CREATE OR REPLACE PROCEDURE PA_EliminarEspecialidad(
    p_id_especialidad IN THOSP_ESPECIALIDADES.TN_IdEspecialidad%TYPE
)
AS
BEGIN
    DELETE FROM THOSP_ESPECIALIDADES
    WHERE TN_IdEspecialidad = p_id_especialidad;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Especialidad ' || p_id_especialidad || ' eliminada correctamente.');
EXCEPTION
    WHEN others THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/

CREATE OR REPLACE PROCEDURE PA_ActualizarEspecialidad(
    p_id_especialidad IN THOSP_ESPECIALIDADES.TN_IdEspecialidad%TYPE,
    p_dsc_especialidad IN THOSP_ESPECIALIDADES.TC_DscEspecialidad%TYPE
)
AS
BEGIN
    UPDATE THOSP_ESPECIALIDADES
    SET TC_DscEspecialidad = p_dsc_especialidad
    WHERE TN_IdEspecialidad = p_id_especialidad;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Especialidad ' || p_id_especialidad || ' actualizada correctamente.');
EXCEPTION
    WHEN others THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/

CREATE OR REPLACE PROCEDURE PA_ListarEspecialidades(
    p_lista_especialidades OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_lista_especialidades FOR
        SELECT TN_IdEspecialidad, TC_DscEspecialidad
        FROM THOSP_ESPECIALIDADES;
END;
/

--    _____  _  _   ___   ___  ___   __  __  ___  ___  ___  ___  ___   ___ 
--   |_   _|| || | / _ \ / __|| _ \ |  \/  || __||   \|_ _|/ __|/ _ \ / __|
--     | |  | __ || (_) |\__ \|  _/ | |\/| || _| | |) || || (__| (_) |\__ \
--     |_|  |_||_| \___/ |___/|_|___|_|  |_||___||___/|___|\___|\___/ |___/
--                              |___|                                      

CREATE SEQUENCE sequencia_medico_id
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE OR REPLACE PROCEDURE PA_AgregarMedico(
    p_nombre_medico IN THOSP_MEDICOS.TC_NombreMedico%TYPE,
    p_id_especialidad IN THOSP_MEDICOS.TN_IdEspecialidad%TYPE
)
AS
    v_id_medico THOSP_MEDICOS.TN_IdMedico%TYPE;
BEGIN
    SELECT sequencia_medico_id.NEXTVAL INTO v_id_medico FROM dual;
    
    INSERT INTO THOSP_MEDICOS (TN_IdMedico, TC_NombreMedico, TN_IdEspecialidad)
    VALUES (v_id_medico, p_nombre_medico, p_id_especialidad);
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Médico ' || v_id_medico || ' agregado correctamente.');
EXCEPTION
    WHEN others THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/

CREATE OR REPLACE PROCEDURE PA_EliminarDoctor(
    p_id_medico IN THOSP_MEDICOS.TN_IdMedico%TYPE
)
AS
BEGIN
    DELETE FROM THOSP_MEDICOS
    WHERE TN_IdMedico = p_id_medico;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Médico ' || p_id_medico || ' eliminado correctamente.');
EXCEPTION
    WHEN others THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/

CREATE OR REPLACE PROCEDURE PA_ActualizarMedico(
    p_id_medico IN THOSP_MEDICOS.TN_IdMedico%TYPE,
    p_nombre_medico IN THOSP_MEDICOS.TC_NombreMedico%TYPE,
    p_id_especialidad IN THOSP_MEDICOS.TN_IdEspecialidad%TYPE
)
AS
BEGIN
    UPDATE THOSP_MEDICOS
    SET TC_NombreMedico = p_nombre_medico,
        TN_IdEspecialidad = p_id_especialidad
    WHERE TN_IdMedico = p_id_medico;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Médico ' || p_id_medico || ' actualizado correctamente.');
EXCEPTION
    WHEN others THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/

CREATE OR REPLACE PROCEDURE PA_ListarMedicos(
    p_lista_medicos OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_lista_medicos FOR
        SELECT TN_IdMedico, TC_NombreMedico, TN_IdEspecialidad
        FROM THOSP_MEDICOS;
END;
/












