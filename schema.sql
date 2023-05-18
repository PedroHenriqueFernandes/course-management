CREATE TABLE location
(
  caixa_postal VARCHAR2(9) NOT NULL,
  address VARCHAR2(50) NOT NULL,
  country VARCHAR2(20) NOT NULL,
  PRIMARY KEY (caixa_postal)
);

CREATE TABLE grade
(
  id_grade INT NOT NULL,
  grade FLOAT NOT NULL,
  PRIMARY KEY (id_grade)
);

CREATE TABLE person
(
  id_person INT NOT NULL,
  first_name VARCHAR2(25) NOT NULL,
  date_birth DATE NOT NULL,
  last_name VARCHAR2(50) NOT NULL,
  sex VARCHAR2(1) NOT NULL,
  NIF INT,
  caixa_postal VARCHAR2(9) NOT NULL,
  person_type VARCHAR2(10) NOT NULL,
  PRIMARY KEY (id_person, person_type),
  CHECK (person_type IN ('instructor', 'student')),
  FOREIGN KEY (caixa_postal) REFERENCES location(caixa_postal) ON DELETE CASCADE
);

CREATE TABLE instructor
(
  id_instructor INT NOT NULL,
  employment_status VARCHAR2(20) NOT NULL,
  hire_date DATE NOT NULL,
  person_type VARCHAR2(10) NOT NULL,
  PRIMARY KEY (id_instructor),
  FOREIGN KEY (id_instructor, person_type) REFERENCES person(id_person, person_type) ON DELETE CASCADE
);

CREATE TABLE student
(
  id_student INT NOT NULL,
  status VARCHAR2(20) NOT NULL,
  person_type VARCHAR2(10) NOT NULL,
  PRIMARY KEY (id_student),
  FOREIGN KEY (id_student, person_type) REFERENCES person(id_person, person_type) ON DELETE CASCADE
);

CREATE TABLE contact
(
  id_contact INT NOT NULL,
  contact_type VARCHAR2(10) NOT NULL,
  contact_info VARCHAR2(100) NOT NULL,
  id_person INT NOT NULL,
  person_type VARCHAR2(10) NOT NULL,
  PRIMARY KEY (id_contact),
  FOREIGN KEY (id_person, person_type) REFERENCES person(id_person, person_type) ON DELETE CASCADE
);

CREATE TABLE department (
  id_department INT NOT NULL,
  name VARCHAR2(25) NOT NULL,
  status VARCHAR2(20) NOT NULL,
  caixa_postal VARCHAR2(9) NOT NULL,
  PRIMARY KEY (id_department),
  FOREIGN KEY (caixa_postal) REFERENCES location(caixa_postal) ON DELETE CASCADE
);


CREATE TABLE instructor_department (
  id_instructor INT,
  id_department INT,
  PRIMARY KEY (id_instructor, id_department),
  FOREIGN KEY (id_instructor) REFERENCES instructor(id_instructor),
  FOREIGN KEY (id_department) REFERENCES department(id_department)
);


CREATE TABLE student_grade
(
  id_student INT NOT NULL,
  id_grade INT NOT NULL,
  PRIMARY KEY (id_student, id_grade),
  FOREIGN KEY (id_student) REFERENCES student(id_student) ON DELETE CASCADE,
  FOREIGN KEY (id_grade) REFERENCES grade(id_grade) ON DELETE CASCADE
);

CREATE TABLE course
(
  id_course INT NOT NULL,
  credits INT NOT NULL,
  name VARCHAR2(50) NOT NULL,
  description VARCHAR2(250) NOT NULL,
  id_department INT NOT NULL,
  id_instructor INT NOT NULL,
  PRIMARY KEY (id_course),
  FOREIGN KEY (id_department) REFERENCES department(id_department),
  FOREIGN KEY (id_instructor) REFERENCES instructor(id_instructor)
); -- Essa alteração permite que as notas dos alunos em cada curso sejam armazenadas na mesma tabela que as informações de matrícula. No entanto, é importante lembrar que isso pode resultar em uma tabela maior e mais lenta de ser consultada, caso haja muitas matrículas e notas para armazenar.

CREATE TABLE student_enrollment (
  enrollment_status VARCHAR2(20) NOT NULL,
  enrollment_date DATE NOT NULL,
  id_student INT NOT NULL,
  id_course INT NOT NULL,
  PRIMARY KEY (id_student, id_course),
  FOREIGN KEY (id_student) REFERENCES student(id_student),
  FOREIGN KEY (id_course) REFERENCES course(id_course)
);

CREATE TABLE student_grade_in_course (
  id_student INT NOT NULL,
  id_course INT NOT NULL,
  id_grade INT NOT NULL,
  PRIMARY KEY (id_student, id_course, id_grade),
  FOREIGN KEY (id_student) REFERENCES student(id_student),
  FOREIGN KEY (id_course) REFERENCES course(id_course),
  FOREIGN KEY (id_grade) REFERENCES grade(id_grade)
);

-- Inserir registros na tabela location
INSERT INTO location (caixa_postal, address, country)
VALUES ('123456789', 'Rua A, 123', 'Brasil');

INSERT INTO location (caixa_postal, address, country)
VALUES ('987654321', 'Avenue B, 456', 'Estados Unidos');

INSERT INTO location (caixa_postal, address, country)
VALUES ('543216789', 'Calle C, 789', 'Espanha');

COMMIT;

-- Inserir registros na tabela grade
INSERT INTO grade (id_grade, grade)
VALUES (1, 7.5);

INSERT INTO grade (id_grade, grade)
VALUES (2, 9.2);

INSERT INTO grade (id_grade, grade)
VALUES (3, 6.8);

COMMIT;

-- Inserir registros na tabela person
INSERT INTO person (id_person, first_name, date_birth, last_name, sex, NIF, caixa_postal, person_type)
VALUES (1, 'John', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 'Doe', 'M', 123456789, '123456789', 'instructor');

INSERT INTO person (id_person, first_name, date_birth, last_name, sex, NIF, caixa_postal, person_type)
VALUES (2, 'Jane', TO_DATE('1995-05-10', 'YYYY-MM-DD'), 'Smith', 'F', 987654321, '987654321', 'student');

INSERT INTO person (id_person, first_name, date_birth, last_name, sex, NIF, caixa_postal, person_type)
VALUES (3, 'Robert', TO_DATE('1988-11-15', 'YYYY-MM-DD'), 'Johnson', 'M', NULL, '543216789', 'instructor');

INSERT INTO person (id_person, first_name, date_birth, last_name, sex, NIF, caixa_postal, person_type)
VALUES (4, 'Pedro', TO_DATE('1988-11-15', 'YYYY-MM-DD'), 'Johnson', 'M', NULL, '543216789', 'instructor');

INSERT INTO person (id_person, first_name, date_birth, last_name, sex, NIF, caixa_postal, person_type)
VALUES (5, 'Mario', TO_DATE('1995-05-10', 'YYYY-MM-DD'), 'Smith', 'F', 987654321, '987654321', 'student');

INSERT INTO person (id_person, first_name, date_birth, last_name, sex, NIF, caixa_postal, person_type)
VALUES (6, 'Robert', TO_DATE('1995-05-10', 'YYYY-MM-DD'), 'Smith', 'F', 987654321, '987654321', 'student');

COMMIT;


-- Inserir registros na tabela instructor
INSERT INTO instructor (id_instructor, employment_status, hire_date, person_type)
VALUES (1, 'Full-time', TO_DATE('2022-01-01', 'YYYY-MM-DD'), 'instructor');

INSERT INTO instructor (id_instructor, employment_status, hire_date, person_type)
VALUES (3, 'Part-time', TO_DATE('2022-02-15', 'YYYY-MM-DD'), 'instructor');

INSERT INTO instructor (id_instructor, employment_status, hire_date, person_type)
VALUES (4, 'Full-time', TO_DATE('2022-03-10', 'YYYY-MM-DD'), 'instructor');

COMMIT;


-- Inserir registros na tabela student
INSERT INTO student (id_student, status, person_type)
VALUES (2, 'Enrolled', 'student');

INSERT INTO student (id_student, status, person_type)
VALUES (5, 'Enrolled', 'student');

INSERT INTO student (id_student, status, person_type)
VALUES (6, 'Graduated', 'student');

COMMIT;


-- Inserir registros na tabela contact
INSERT INTO contact (id_contact, contact_type, contact_info, id_person, person_type)
VALUES (1, 'email', 'john@example.com', 1, 'instructor');

INSERT INTO contact (id_contact, contact_type, contact_info, id_person, person_type)
VALUES (2, 'phone', '123-456-7890', 2, 'student');

INSERT INTO contact (id_contact, contact_type, contact_info, id_person, person_type)
VALUES (3, 'email', 'jane@example.com', 3, 'instructor');

COMMIT;


-- Inserir registros na tabela department
INSERT INTO department (id_department, name, status, caixa_postal)
VALUES (1, 'IT', 'Active', '123456789');

INSERT INTO department (id_department, name, status, caixa_postal)
VALUES (2, 'Finance', 'Active', '987654321');

INSERT INTO department (id_department, name, status, caixa_postal)
VALUES (3, 'Marketing', 'Inactive', '543216789');

COMMIT;


-- Inserir registros na tabela instructor_department
INSERT INTO instructor_department (id_instructor, id_department)
VALUES (1, 1);

INSERT INTO instructor_department (id_instructor, id_department)
VALUES (3, 2);

INSERT INTO instructor_department (id_instructor, id_department)
VALUES (4, 1);

COMMIT;


-- Inserir registros na tabela student_grade
INSERT INTO student_grade (id_student, id_grade)
VALUES (2, 3);

INSERT INTO student_grade (id_student, id_grade)
VALUES (5, 2);

INSERT INTO student_grade (id_student, id_grade)
VALUES (6, 1);

COMMIT;


-- Inserir registros na tabela course
INSERT INTO course (id_course, credits, name, description, id_department, id_instructor)
VALUES (1, 4, 'Mathematics', 'Introduction to Mathematics', 1, 1);

INSERT INTO course (id_course, credits, name, description, id_department, id_instructor)
VALUES (2, 3, 'Physics', 'Fundamentals of Physics', 1, 3);

INSERT INTO course (id_course, credits, name, description, id_department, id_instructor)
VALUES (3, 3, 'Chemistry', 'Basic Chemistry Principles', 2, 4);

COMMIT;


-- Inserir registros na tabela student_enrollment
INSERT INTO student_enrollment (enrollment_status, enrollment_date, id_student, id_course)
VALUES ('Enrolled', TO_DATE('2023-01-15', 'YYYY-MM-DD'), 2, 1);

INSERT INTO student_enrollment (enrollment_status, enrollment_date, id_student, id_course)
VALUES ('Enrolled', TO_DATE('2023-02-01', 'YYYY-MM-DD'), 5, 2);

INSERT INTO student_enrollment (enrollment_status, enrollment_date, id_student, id_course)
VALUES ('Enrolled', TO_DATE('2023-01-20', 'YYYY-MM-DD'), 6, 1);

COMMIT;


-- Inserir registros na tabela student_grade_in_course
INSERT INTO student_grade_in_course (id_student, id_course, id_grade)
VALUES (2, 1, 1);

INSERT INTO student_grade_in_course (id_student, id_course, id_grade)
VALUES (5, 2, 2);

INSERT INTO student_grade_in_course (id_student, id_course, id_grade)
VALUES (6, 1, 3);

COMMIT;
