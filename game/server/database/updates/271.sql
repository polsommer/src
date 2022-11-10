create or replace view active_resources_data as
SELECT resource_id, resource_name, resource_class, regexp_substr(attributes, '[[:alpha:]_]+', 1, lines.column_value) attribute_name, regexp_substr(attributes, '\d+', 1, lines.column_value) attribute_value FROM resource_types, TABLE (CAST (MULTISET (SELECT LEVEL FROM dual CONNECT BY regexp_substr(attributes, '[^:]+', 1, LEVEL) IS NOT NULL) AS sys.odciNumberList)) lines WHERE depleted_timestamp >= (SELECT last_save_time FROM clock);
update version_number set version_number=271, min_version_number=271;
