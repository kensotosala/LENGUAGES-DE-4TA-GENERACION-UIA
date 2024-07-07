
--   _______  _______  _______  _______  _______  _______  _______ 
--  |_     _||    ___||     __||_     _||_     _||    |  ||     __|
--    |   |  |    ___||__     |  |   |   _|   |_ |       ||    |  |
--    |___|  |_______||_______|  |___|  |_______||__|____||_______|
--                                                                 
                                                                                                          
--    _____  _  _   ___   ___  ___   ___  ___  ___  ___  ___  ___    _    _     ___  ___    _    ___   ___  ___ 
--   |_   _|| || | / _ \ / __|| _ \ | __|/ __|| _ \| __|/ __||_ _|  /_\  | |   |_ _||   \  /_\  |   \ | __|/ __|
--     | |  | __ || (_) |\__ \|  _/ | _| \__ \|  _/| _|| (__  | |  / _ \ | |__  | | | |) |/ _ \ | |) || _| \__ \
--     |_|  |_||_| \___/ |___/|_|___|___||___/|_|  |___|\___||___|/_/ \_\|____||___||___//_/ \_\|___/ |___||___/
--                              |___|                                                                           
                                                                                                        
SET SERVEROUTPUT ON;


-- Agregar
BEGIN
    PA_AgregarEspecialidad('Urología');
    PA_AgregarEspecialidad('Cardiología');
END;
/

-- Actualizar
BEGIN
    PA_ActualizarEspecialidad(1, 'Pediatría');
END;
/

-- Listar
DECLARE
    lista_especialidades SYS_REFCURSOR;
    v_id_especialidad THOSP_ESPECIALIDADES.TN_IdEspecialidad%TYPE;
    v_dsc_especialidad THOSP_ESPECIALIDADES.TC_DscEspecialidad%TYPE;
BEGIN
    PA_ListarEspecialidades(lista_especialidades);
    
    LOOP
        FETCH lista_especialidades INTO v_id_especialidad, v_dsc_especialidad;
        EXIT WHEN lista_especialidades%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Especialidad ID: ' || v_id_especialidad || ', Descripción: ' || v_dsc_especialidad);
    END LOOP;
    
    CLOSE lista_especialidades;
END;
/

-- Eliminar
BEGIN
    PA_EliminarEspecialidad(1);
END;
/

--    _____  _  _   ___   ___  ___   ___  _     ___  ___  _  _  _____  ___  ___ 
--   |_   _|| || | / _ \ / __|| _ \ / __|| |   |_ _|| __|| \| ||_   _|| __|/ __|
--     | |  | __ || (_) |\__ \|  _/| (__ | |__  | | | _| | .` |  | |  | _| \__ \
--     |_|  |_||_| \___/ |___/|_|___\___||____||___||___||_|\_|  |_|  |___||___/
--  
SET SERVEROUTPUT ON;

-- Agregar
DECLARE
    v_nombre THOSP_CLIENTES.TC_Nombre%TYPE := 'John';
    v_apellido1 THOSP_CLIENTES.TC_Ap1%TYPE := 'Doe';
    v_apellido2 THOSP_CLIENTES.TC_Ap2%TYPE := 'Smith';
    v_num_telefono THOSP_CLIENTES.TC_NumTelefono%TYPE := '1234567890';
    v_correo_electronico THOSP_CLIENTES.TC_CorreoElectronico%TYPE := 'john.doe@example.com';
BEGIN
    PA_InsertarCliente(v_nombre, v_apellido1, v_apellido2, v_num_telefono, v_correo_electronico);
END;
/

-- Actualizar
DECLARE
    v_id_cliente THOSP_CLIENTES.TN_IdCliente%TYPE := 1;
    v_nombre THOSP_CLIENTES.TC_Nombre%TYPE := 'John';
    v_apellido1 THOSP_CLIENTES.TC_Ap1%TYPE := 'Doe';
    v_apellido2 THOSP_CLIENTES.TC_Ap2%TYPE := 'Smith';
    v_num_telefono THOSP_CLIENTES.TC_NumTelefono%TYPE := '0987654321';
    v_correo_electronico THOSP_CLIENTES.TC_CorreoElectronico%TYPE := 'john.updated@example.com';
BEGIN
    PA_ActualizarCliente(v_id_cliente, v_nombre, v_apellido1, v_apellido2, v_num_telefono, v_correo_electronico);
END;
/

-- Listar
DECLARE
    v_lista_clientes SYS_REFCURSOR;
    v_id_cliente THOSP_CLIENTES.TN_IdCliente%TYPE;
    v_nombre THOSP_CLIENTES.TC_Nombre%TYPE;
    v_apellido1 THOSP_CLIENTES.TC_Ap1%TYPE;
    v_apellido2 THOSP_CLIENTES.TC_Ap2%TYPE;
    v_num_telefono THOSP_CLIENTES.TC_NumTelefono%TYPE;
    v_correo_electronico THOSP_CLIENTES.TC_CorreoElectronico%TYPE;
BEGIN
    PA_ListarClientes(v_lista_clientes);

    LOOP
        FETCH v_lista_clientes INTO v_id_cliente,v_nombre, v_apellido1, v_apellido2, v_num_telefono, v_correo_electronico;
        EXIT WHEN v_lista_clientes%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_id_cliente || ', Nombre: ' || v_nombre || ', Apellido1: ' || v_apellido1 || ', Apellido2: ' || v_apellido2 || 
                             ', Teléfono: ' || v_num_telefono || ', Correo: ' || v_correo_electronico);
    END LOOP;

    CLOSE v_lista_clientes;
END;
/

-- Eliminar
DECLARE
    v_id_cliente THOSP_CLIENTES.TN_IdCliente%TYPE := 1;
BEGIN
    PA_EliminarCliente(v_id_cliente);
END;
/

--    _____  _  _   ___   ___  ___   __  __  ___  ___  ___  ___  ___   ___ 
--   |_   _|| || | / _ \ / __|| _ \ |  \/  || __||   \|_ _|/ __|/ _ \ / __|
--     | |  | __ || (_) |\__ \|  _/ | |\/| || _| | |) || || (__| (_) |\__ \
--     |_|  |_||_| \___/ |___/|_|___|_|  |_||___||___/|___|\___|\___/ |___/
--                              |___|
SET SERVEROUTPUT ON;

-- Añadir
DECLARE
    v_nombre_medico THOSP_MEDICOS.TC_NombreMedico%TYPE := 'Dr. Smith';
    v_id_especialidad THOSP_MEDICOS.TN_IdEspecialidad%TYPE := 2;
BEGIN
    PA_AgregarMedico(v_nombre_medico, v_id_especialidad);
END;
/

-- Eliminar
DECLARE
    v_id_medico THOSP_MEDICOS.TN_IdMedico%TYPE := 1;
BEGIN
    PA_EliminarDoctor(v_id_medico);
END;
/

-- Listar
DECLARE
    v_lista_medicos SYS_REFCURSOR;
    v_id_medico THOSP_MEDICOS.TN_IdMedico%TYPE;
    v_nombre_medico THOSP_MEDICOS.TC_NombreMedico%TYPE;
    v_id_especialidad THOSP_MEDICOS.TN_IdEspecialidad%TYPE;
BEGIN
    PA_ListarMedicos(v_lista_medicos);

    LOOP
        FETCH v_lista_medicos INTO v_id_medico, v_nombre_medico, v_id_especialidad;
        EXIT WHEN v_lista_medicos%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('ID Médico: ' || v_id_medico || ', Nombre: ' || v_nombre_medico || ', ID Especialidad: ' || v_id_especialidad);
    END LOOP;

    CLOSE v_lista_medicos;
END;
/

-- Actualizar
DECLARE
    v_id_medico THOSP_MEDICOS.TN_IdMedico%TYPE := 3;
    v_nombre_medico THOSP_MEDICOS.TC_NombreMedico%TYPE := 'Dr. Tyron López con la 10 en su camiseta';
    v_id_especialidad THOSP_MEDICOS.TN_IdEspecialidad%TYPE := 3;
BEGIN
    PA_ActualizarMedico(v_id_medico, v_nombre_medico, v_id_especialidad);
END;
/

--    _____  _  _   ___   ___  ___   ___  ___  _____  _    ___ 
--   |_   _|| || | / _ \ / __|| _ \ / __||_ _||_   _|/_\  / __|
--     | |  | __ || (_) |\__ \|  _/| (__  | |   | | / _ \ \__ \
--     |_|  |_||_| \___/ |___/|_|___\___||___|  |_|/_/ \_\|___/
--                              |___|                          

SET SERVEROUTPUT ON;

-- Agregar
DECLARE
    v_id_cliente THOSP_CITAS.TN_IdCliente%TYPE := 2;
    v_id_medico THOSP_CITAS.TN_IdMedico%TYPE := 3;
    v_id_especialidad THOSP_CITAS.TN_IdEspecialidad%TYPE := 2;
    v_fecha_cita THOSP_CITAS.TF_FecCita%TYPE := SYSTIMESTAMP;
BEGIN
    PA_AgendarCita(v_id_cliente, v_id_medico, v_id_especialidad, v_fecha_cita);
END;
/

-- Actualizar
DECLARE
    v_id_cita THOSP_CITAS.TN_IdCita%TYPE := 1;
    v_id_cliente THOSP_CITAS.TN_IdCliente%TYPE := 2;
    v_id_medico THOSP_CITAS.TN_IdMedico%TYPE := 2;
    v_id_especialidad THOSP_CITAS.TN_IdEspecialidad%TYPE := 2;
    v_fecha_cita THOSP_CITAS.TF_FecCita%TYPE := SYSTIMESTAMP;
BEGIN
    PA_ActualizarCita(v_id_cita, v_id_cliente, v_id_medico, v_id_especialidad, v_fecha_cita);
END;
/

-- Listar
DECLARE
    v_lista_citas SYS_REFCURSOR;
    v_id_cita THOSP_CITAS.TN_IdCita%TYPE;
    v_id_cliente THOSP_CITAS.TN_IdCliente%TYPE;
    v_id_medico THOSP_CITAS.TN_IdMedico%TYPE;
    v_id_especialidad THOSP_CITAS.TN_IdEspecialidad%TYPE;
    v_fecha_cita THOSP_CITAS.TF_FecCita%TYPE;
BEGIN
    PA_ListarCitas(v_lista_citas);

    LOOP
        FETCH v_lista_citas INTO v_id_cita, v_id_cliente, v_id_medico, v_id_especialidad, v_fecha_cita;
        EXIT WHEN v_lista_citas%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('ID Cita: ' || v_id_cita || ', ID Cliente: ' || v_id_cliente || ', ID Médico: ' || v_id_medico || 
                             ', ID Especialidad: ' || v_id_especialidad || ', Fecha Cita: ' || TO_CHAR(v_fecha_cita, 'YYYY-MM-DD HH24:MI:SS'));
    END LOOP;

    CLOSE v_lista_citas;
END;
/

-- Eliminar
DECLARE
    v_id_cita THOSP_CITAS.TN_IdCita%TYPE := 7;
BEGIN
    PA_EliminarCita(v_id_cita);
END;
/

--    _____  _  _   ___   ___  ___   ___  ___    _    ___  _  _   ___   ___  _____  ___  ___  ___  
--   |_   _|| || | / _ \ / __|| _ \ |   \|_ _|  /_\  / __|| \| | / _ \ / __||_   _||_ _|/ __|/ _ \ 
--     | |  | __ || (_) |\__ \|  _/ | |) || |  / _ \| (_ || .` || (_) |\__ \  | |   | || (__| (_) |
--     |_|  |_||_| \___/ |___/|_|___|___/|___|/_/ \_\\___||_|\_| \___/ |___/  |_|  |___|\___|\___/ 
--                              |___|                                                                                                                                              
SET SERVEROUTPUT ON;

-- Agregar
DECLARE
    v_id_cita THOSP_DIAGNOSTICO.TN_IdCita%TYPE := 1;
    v_dsc_diagnostico THOSP_DIAGNOSTICO.TC_DscDiagnostico%TYPE := 'Dolor abdominal';
BEGIN
    PA_AgregarDiagnostico(v_id_cita, v_dsc_diagnostico);
END;
/

-- Listar
DECLARE
    v_lista_diagnosticos SYS_REFCURSOR;
    v_id_diagnostico THOSP_DIAGNOSTICO.TN_IdDiagnostico%TYPE;
    v_id_cita THOSP_DIAGNOSTICO.TN_IdCita%TYPE;
    v_dsc_diagnostico THOSP_DIAGNOSTICO.TC_DscDiagnostico%TYPE;
BEGIN
    PA_ListarDiagnostico(v_lista_diagnosticos);

    LOOP
        FETCH v_lista_diagnosticos INTO v_id_diagnostico, v_id_cita, v_dsc_diagnostico;
        EXIT WHEN v_lista_diagnosticos%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('ID Diagnóstico: ' || v_id_diagnostico || ', ID Cita: ' || v_id_cita || ', Descripción: ' || v_dsc_diagnostico);
    END LOOP;

    CLOSE v_lista_diagnosticos;
END;
/

-- Eliminar
DECLARE
    v_id_diagnostico THOSP_DIAGNOSTICO.TN_IdDiagnostico%TYPE := 1;
BEGIN
    PA_EliminarDiagnostico(v_id_diagnostico);
END;
/

-- Actualizar
DECLARE
    v_id_diagnostico THOSP_DIAGNOSTICO.TN_IdDiagnostico%TYPE := 1;
    v_id_cita THOSP_DIAGNOSTICO.TN_IdCita%TYPE := 2;
    v_dsc_diagnostico THOSP_DIAGNOSTICO.TC_DscDiagnostico%TYPE := 'Fiebre alta';
BEGIN
    PA_ActualizarDiagnostico(v_id_diagnostico, v_id_cita, v_dsc_diagnostico);
END;
/







