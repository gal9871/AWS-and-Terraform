CREATE TABLE instances_shutdown (
    instance_id character varying(32) PRIMARY key NOT NULL,
    shutdown_time TIMESTAMP
);

CREATE TABLE instances_shutdown_log (
    run_id integer PRIMARY key NOT NULL,
    time TIMESTAMP,
    instance_name character varying(256),
);

ALTER TABLE students_answares
ADD CONSTRAINT fk_students_student_id
FOREIGN KEY (student_id)
REFERENCES students(student_id);
