--cod pl/sql care afiseaza pentru fiecare biblioteca cate carti are
set SERVEROUTPUT ON;
DECLARE
  TYPE tab_nume IS TABLE OF biblioteca.denumire%TYPE;
  TYPE tab_nr IS TABLE OF NUMBER(4);
  t_nr tab_nr;
  t_nume tab_nume;
  CURSOR c IS
    SELECT b.denumire AS nume, COUNT(cb.id_carte) AS nr
    FROM biblioteca b
    LEFT JOIN carte_biblioteca cb ON b.id_biblioteca = cb.id_biblioteca
    GROUP BY b.denumire;
BEGIN
  OPEN c;
  FETCH c BULK COLLECT INTO t_nume, t_nr LIMIT 4;
  DBMS_OUTPUT.PUT_LINE('---Fetch 1 --------------');
  FOR i IN t_nume.FIRST..t_nume.LAST LOOP
    IF t_nr(i) = 0 THEN
      DBMS_OUTPUT.PUT_LINE('In biblioteca ' || t_nume(i) || ' nu există cărți');
    ELSIF t_nr(i) = 1 THEN
      DBMS_OUTPUT.PUT_LINE('In biblioteca ' || t_nume(i) || ' exista o carte');
    ELSE
      DBMS_OUTPUT.PUT_LINE('In biblioteca ' || t_nume(i) || ' exista ' || t_nr(i) || ' carti');
    END IF;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('---Fetch 2 --------------');
  FETCH c BULK COLLECT INTO t_nume, t_nr LIMIT 4;
  FOR i IN t_nume.FIRST..t_nume.LAST LOOP
    IF t_nr(i) = 0 THEN
      DBMS_OUTPUT.PUT_LINE('In biblioteca ' || t_nume(i) || ' nu exista carti');
    ELSIF t_nr(i) = 1 THEN
      DBMS_OUTPUT.PUT_LINE('In biblioteca ' || t_nume(i) || ' exista o carte');
    ELSE
      DBMS_OUTPUT.PUT_LINE('In biblioteca ' || t_nume(i) || ' exista ' || t_nr(i) || ' carti');
    END IF;
  END LOOP;
  CLOSE c;
END;
/


-- Trigger pentru a verifica daca cititorul are un abonament activ pentru a face un imprumut
CREATE OR REPLACE TRIGGER trig_verifica_abonament 
BEFORE INSERT OR UPDATE OF id_cititor ON imprumut 
FOR EACH ROW  
DECLARE 
  x NUMBER; 
  expirare_abonament DATE; 
BEGIN  
  SELECT COUNT(*) INTO x 
  FROM abonament 
  WHERE id_cititor = :new.id_cititor; 
  IF x = 0 THEN 
    RAISE_APPLICATION_ERROR(-20000, 'CITITORUL NU ARE UN ABONAMENT ACTIV PENTRU A FACE IMPRUMUTUL'); 
  ELSE 
    SELECT data_expirare INTO expirare_abonament 
    FROM abonament 
    WHERE id_cititor = :new.id_cititor; 
    IF expirare_abonament < SYSDATE THEN 
      RAISE_APPLICATION_ERROR(-20001, 'ABONAMENTUL CITITORULUI A EXPIRAT'); 
    END IF; 
  END IF; 
END; 
/
--insert into imprumut values(1,1,7,1,sysdate, sysdate+14);