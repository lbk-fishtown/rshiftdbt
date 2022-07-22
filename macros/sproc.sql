{% macro run_my_stored_proced( name ) %}

    {% set sp_sql %}
        CALL {{ name }};
    {% endset %}

    {% do run_query( sp_sql ) %}

{% endmacro %}


{% macro create_proc() %}
{% set sproc %}
    CREATE OR REPLACE PROCEDURE test_sp1()
    AS $$
    BEGIN
        CREATE TABLE IF NOT EXISTS audit_tbl(dt timestamp, model varchar(256));
    END;
    $$ LANGUAGE plpgsql;
    
    call test_sp1();
{% endset %}

{% do run_query( sproc ) %}

{% endmacro %}

{% macro audit_proc( dt, model ) %}
{% set sproc %}
    INSERT INTO audit_tbl VALUES( {{ dt }}, {{ model }} )
{% endset %}

{% do run_query( sproc ) %}

{% endmacro %}