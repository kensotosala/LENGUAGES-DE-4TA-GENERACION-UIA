-- ===== PROCEDIMIENTOS ALMACENDAOS =====

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

-- >>>>>>> THOSP_CITAS <<<<<<<
CREATE OR REPLACE PROCEDURE PA_AgendarCita(
    p_id_cita IN THOSP_CITAS.TN_IdCita%TYPE,
    p_id_cliente IN THOSP_CITAS.TN_IdCliente%TYPE,
    p_id_medico IN THOSP_CITAS.TN_IdMedico%TYPE,
    p_id_especialidad IN THOSP_CITAS.TN_IdEspecialidad%TYPE,
    p_fecha_cita IN THOSP_CITAS.TF_FecCita%TYPE
)
AS
BEGIN
    INSERT INTO THOSP_CITAS (TN_IdCita, TN_IdCliente, TN_IdMedico, TN_IdEspecialidad, TF_FecCita)
    VALUES (p_id_cita, p_id_cliente, p_id_medico, p_id_especialidad, p_fecha_cita);
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Cita: ' || p_id_cita || '. Agendada Correctamente!');
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



