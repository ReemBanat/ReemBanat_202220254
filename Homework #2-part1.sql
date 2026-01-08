--Q1) PL/SQL Anonymous Blocks and Dates 
--Parts 1 & 2: Basic Declarations and Expressions

DECLARE
   
   TODAY DATE := SYSDATE; 
   
   TOMORROW TODAY%TYPE; 
BEGIN
   
   TOMORROW := TODAY + 1; 
   
   DBMS_OUTPUT.PUT_LINE('Hello World'); [cite: 6]
   DBMS_OUTPUT.PUT_LINE('Today is: ' || TODAY); [cite: 12]
   DBMS_OUTPUT.PUT_LINE('Tomorrow is: ' || TOMORROW); [cite: 12]
END;

--Part 3: Date Formatting and Month Functions------->

DECLARE
   my_date DATE := SYSDATE;
   v_last_day DATE; 
BEGIN
   
   DBMS_OUTPUT.PUT_LINE(TO_CHAR(my_date, 'Month dd, yyyy'));
  
   v_last_day := LAST_DAY(my_date); 
   DBMS_OUTPUT.PUT_LINE('Last day of the month: ' || v_last_day);
END;

--Part 4: Date Arithmetic and Intervals ----->

DECLARE
   my_date DATE := SYSDATE;
   future_date DATE;
   v_months_between NUMBER;
BEGIN
   future_date := my_date + 45;
   
   
   v_months_between := MONTHS_BETWEEN(future_date, my_date);
   
   DBMS_OUTPUT.PUT_LINE('Today: ' || my_date);
   DBMS_OUTPUT.PUT_LINE('Future Date: ' || future_date);
   DBMS_OUTPUT.PUT_LINE('Months between: ' || v_months_between);
END;


--Q2) Tables, %TYPE, and Explicit Cursors----->

Table Setup


CREATE TABLE countries (
   country_name VARCHAR2(50),
   median_age NUMBER(6, 2)
);

INSERT INTO countries VALUES ('Japan', 48.4);
INSERT INTO countries VALUES ('Jordan', 23.8);


Refactored Code (Using %TYPE and Explicit Cursor)----->


DECLARE
   
   v_country_name countries.country_name%TYPE; 
   v_median_age   countries.median_age%TYPE;
   
   CURSOR c_country IS
      SELECT country_name, median_age 
      FROM countries
      WHERE country_name = 'Japan'; [cite: 25, 26]
BEGIN
   OPEN c_country;
   FETCH c_country INTO v_country_name, v_median_age;
   
   IF c_country%FOUND THEN
      DBMS_OUTPUT.PUT_LINE('The median age in ' || v_country_name || ' is ' || v_median_age || '.'); [cite: 27]
   END IF;
   
   CLOSE c_country;
END;
