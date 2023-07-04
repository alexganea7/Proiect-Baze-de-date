/*
drop table locatie cascade constraints;
drop table biblioteca cascade constraints;
drop table abonament cascade constraints;
drop table carte cascade constraints;
drop table carte_autor cascade constraints;
drop table carte_biblioteca cascade constraints;
drop table domeniu cascade constraints;
drop table imprumut cascade constraints;
drop table cititor cascade constraints;
drop table angajat cascade constraints;
drop table editura cascade constraints;
drop table autor cascade constraints;
drop sequence seq_carte;
drop sequence seq_cititor;
drop sequence seq_angajat;
drop sequence seq_autor;
*/


	


create table locatie(
    id_locatie number(6),
    oras varchar2(20) not null,
    strada varchar2(30),
    primary key (id_locatie)
);

create table biblioteca(
    id_biblioteca number(6),
    denumire varchar2(40) not null,
    id_locatie number(6),
    primary key (id_biblioteca),
    constraint fk_biblioteca foreign key (id_locatie) references locatie(id_locatie)
);

create table angajat(
    id_angajat number(6),
    nume varchar2(20) not null,
    prenume varchar2(20) not null,
    nr_tel varchar2(10),
    functie varchar2(20) not null,
    salariu number(5),
    data_angajarii date not null,
    id_biblioteca number(6),
    primary key (id_angajat),
    constraint fk_angajat foreign key (id_biblioteca) references biblioteca(id_biblioteca)
);

create table cititor(
    id_cititor number(6),
    nume varchar2(20) not null,
    prenume varchar2(20) not null,
    nr_tel varchar2(10),
    data_nasterii date,
    primary key (id_cititor)
);

create table abonament(
    id_abonament number(6),
    pret number(5) not null, 
    data_obtinerii date not null,
    data_expirare date not null,
    id_cititor number(6),
    primary key (id_abonament),
    constraint fk_abonament foreign key (id_cititor) references cititor(id_cititor)
);

create table domeniu(
    id_domeniu number(6),
    denumire varchar2(20) not null,
    primary key (id_domeniu)
);

create table editura(
    id_editura number(6),
    denumire varchar2(20) not null,
    sediu varchar2(20),
    an_aparitie number(4),
    primary key (id_editura)
);

create table carte(
    id_carte number(6),
    denumire varchar2(40) not null,
    nr_pagini number(5),
    an_aparitie number(4),
    pret number(5) not null,
    id_editura number(6),
    id_domeniu number(6),
    primary key (id_carte),
    constraint fk_carte_editura foreign key (id_editura) references editura(id_editura),
    constraint fk_carte_domeniu foreign key (id_domeniu) references domeniu(id_domeniu)
);

create table autor(
    id_autor number(6),
    nume varchar2(20) not null,
    prenume varchar2(20),
    data_nasterii date,
    primary key (id_autor)
);

create table carte_autor(
    id_autor number(6),
    id_carte number(6),
    primary key (id_autor, id_carte),
    constraint fk_carte_autor_id_autor foreign key (id_autor) references autor(id_autor),
    constraint fk_carte_autor_id_carte foreign key (id_carte) references carte(id_carte)
);

create table carte_biblioteca(
    id_carte number(6),
    id_biblioteca number(6),
    nr_exemplare number(5) not null,
    primary key (id_carte, id_biblioteca),
    constraint fk_carte_biblioteca_id_carte foreign key (id_carte) references carte(id_carte),
    constraint fk_carte_biblioteca_id_biblioteca foreign key (id_biblioteca) references biblioteca(id_biblioteca)
);

create table imprumut(
    id_imprumut number(6),
    id_biblioteca number(6),
    id_cititor number(6),
    id_carte number(6),
    data_imprumut date not null,
    data_restituire date not null,
    primary key (id_imprumut),
    constraint fk_imprumut_id_biblioteca foreign key(id_biblioteca) references biblioteca(id_biblioteca),
    constraint fk_imprumut_id_cititor foreign key(id_cititor) references cititor(id_cititor),
    constraint fk_imprumut_id_carte foreign key(id_carte) references carte(id_carte)
);



-----------------------------------------------------------------------------------------------------------------








----locatie

insert into locatie values(1, 'Bucuresti', 'Bulevardul unirii 22');
insert into locatie values(2, 'Bucuresti', 'Strada veteranilor 7-9');
insert into locatie values(3, 'Bucuresti', 'Str. Boteanu nr. 1');
insert into locatie values(4, 'Cluj', 'Str. Clinicilor 2');
insert into locatie values(5, 'Cluj', 'Mihail Kogălniceanu 12-14');
insert into locatie values(6, 'Ploiesti', 'Erou Călin Cătălin 1');
insert into locatie values(7, 'Pitesti', 'Victoriei 18');


----biblioteca

insert into biblioteca values(1, 'Biblioteca Nationala a Romaniei', 1);
insert into biblioteca values(2, 'Biblioteca Metropolitana Bucuresti', 2);
insert into biblioteca values(3, 'Biblioteca Centrala Universitara', 3);
insert into biblioteca values(4, 'Biblioteca Lucian Blaga', 4);
insert into biblioteca values(5, 'Biblioteca Judeteana Octavian Goga', 5);
insert into biblioteca values(6, 'Biblioteca Judeteana Nicolae Iorga', 6);
insert into biblioteca values(7, 'Biblioteca Judeteana Dinicu Golescu', 7);


----autor

CREATE SEQUENCE SEQ_AUTOR
MAXVALUE 9999
START WITH 1
INCREMENT BY 1;

insert into autor values (seq_autor.nextval, 'Mihai' , 'Eminescu', to_date('15/01/1850','dd/mm/yyyy'));
insert into autor values (seq_autor.nextval, 'Stephen' , 'King', to_date('21/09/1947','dd/mm/yyyy'));
insert into autor values (seq_autor.nextval, 'William' , 'Shakespeare', to_date('23/04/1564','dd/mm/yyyy'));
insert into autor values (seq_autor.nextval, 'George' , 'Orwell', to_date('25/06/1903','dd/mm/yyyy'));
insert into autor values (seq_autor.nextval, 'Ioan' , 'Slavici', to_date('18/01/1848','dd/mm/yyyy'));
insert into autor values (seq_autor.nextval, 'Ion' , 'Creangă', to_date('01/03/1837','dd/mm/yyyy'));
insert into autor values (seq_autor.nextval, 'Sarah' , 'Mass', to_date('05/03/1986','dd/mm/yyyy'));
insert into autor values (seq_autor.nextval, 'Clare' , 'Cassandra', to_date('27/07/1973','dd/mm/yyyy'));
insert into autor values (seq_autor.nextval, 'Dostoyevsky' , 'Fyodor', to_date('11/11/1821','dd/mm/yyyy'));
insert into autor values (seq_autor.nextval, 'Camil' , 'Petrescu', to_date('22/04/1894','dd/mm/yyyy'));


----domeniu

insert into domeniu values (1,'Literatura romana');
insert into domeniu values (2,'Literatura straina');
insert into domeniu values (3,'Fictiune');
insert into domeniu values (4,'Filosofie');
insert into domeniu values (5,'Diverse');


----editura

insert into editura values (1, 'Litera', 'Bucuresti', 1989);
insert into editura values (2, 'Humanitas', 'Bucuresti', 1990);
insert into editura values (3, 'Trei', 'Bucuresti', 1995);
insert into editura values (4, 'Corint', 'Bucuresti', 1994);
insert into editura values (5, 'Paralela 45', 'Bucuresti', 1994);


----carte

CREATE SEQUENCE SEQ_CARTE
MAXVALUE 9999
START WITH 1
INCREMENT BY 1;

insert into carte values(seq_carte.nextval, 'Furtuna',32,1611,20,1,2);
insert into carte values(seq_carte.nextval, 'Hamlet',104,1603,35,1,2);
insert into carte values(seq_carte.nextval, 'Macbeth',122,1606,20,2,2);
insert into carte values(seq_carte.nextval, 'Romeo si Julieta',136,1595,25,3,2);
insert into carte values(seq_carte.nextval, '11/22/63',849,2011,50,4,2);
insert into carte values(seq_carte.nextval, 'Cimitirul animalelor',496,1983,35,4,2);
insert into carte values(seq_carte.nextval, 'Luceafarul',60,1883,10,3,1);
insert into carte values(seq_carte.nextval, 'Poesii',307,1883,35,3,1);
insert into carte values(seq_carte.nextval, '1984',320,1949,35,5,2);
insert into carte values(seq_carte.nextval, 'Ferma animalelor',86,1945,25,5,2);
insert into carte values(seq_carte.nextval, 'Amintiri din copilarie',332,1892,15,2,1);
insert into carte values(seq_carte.nextval, 'Povestea lui Harap-Alb',168,1877,10,2,1);
insert into carte values(seq_carte.nextval, 'Moara cu noroc',160,1881,12,1,1);
insert into carte values(seq_carte.nextval, 'Tronul de clestar',512,2012,30,4,3);
insert into carte values(seq_carte.nextval, 'Taramul de cenusa',992,2018,45,4,3);
insert into carte values(seq_carte.nextval, 'Mostenitoarea Focului',656,2014,30,4,3);
insert into carte values(seq_carte.nextval, 'Stapanul umbrelor',656,2017,35,2,3);
insert into carte values(seq_carte.nextval, 'Instrumente mortale',432,2011,45,2,3);
insert into carte values(seq_carte.nextval, 'Crima si pedeapsa',720,1866,50,1,4);
insert into carte values(seq_carte.nextval, 'Fratii Karamazov',840,1880,50,1,4);
insert into carte values(seq_carte.nextval, 'Jocul ielelor',169,1916,38,5,1);
insert into carte values(seq_carte.nextval, 'Patul lui Procust',336,1933,45,5,1);


----carte autor

insert into carte_autor values(3,1);
insert into carte_autor values(3,2);
insert into carte_autor values(3,3);
insert into carte_autor values(3,4);
insert into carte_autor values(2,5);
insert into carte_autor values(2,6);
insert into carte_autor values(1,7);
insert into carte_autor values(1,8);
insert into carte_autor values(4,9);
insert into carte_autor values(4,10);
insert into carte_autor values(6,11);
insert into carte_autor values(6,12);
insert into carte_autor values(5,13);
insert into carte_autor values(7,14);
insert into carte_autor values(7,15);
insert into carte_autor values(7,16);
insert into carte_autor values(8,17);
insert into carte_autor values(8,18);
insert into carte_autor values(9,19);
insert into carte_autor values(9,20);
insert into carte_autor values(10,21);
insert into carte_autor values(10,22);


----carte biblioteca

insert into carte_biblioteca values(1,1,6);
insert into carte_biblioteca values(2,1,3);
insert into carte_biblioteca values(3,1,7);
insert into carte_biblioteca values(4,1,5);
insert into carte_biblioteca values(5,1,4);
insert into carte_biblioteca values(6,1,7);
insert into carte_biblioteca values(7,1,4);
insert into carte_biblioteca values(8,1,5);
insert into carte_biblioteca values(9,1,3);
insert into carte_biblioteca values(10,1,7);
insert into carte_biblioteca values(11,1,3);
insert into carte_biblioteca values(12,1,2);
insert into carte_biblioteca values(13,1,5);
insert into carte_biblioteca values(14,1,1);
insert into carte_biblioteca values(15,1,3);
insert into carte_biblioteca values(16,1,4);
insert into carte_biblioteca values(17,1,2);
insert into carte_biblioteca values(18,1,6);
insert into carte_biblioteca values(19,1,5);
insert into carte_biblioteca values(20,1,3);
insert into carte_biblioteca values(21,1,1);
insert into carte_biblioteca values(22,1,4);
insert into carte_biblioteca values(1,2,12);
insert into carte_biblioteca values(3,2,2);
insert into carte_biblioteca values(5,2,1);
insert into carte_biblioteca values(7,2,4);
insert into carte_biblioteca values(9,2,7);
insert into carte_biblioteca values(11,2,9);
insert into carte_biblioteca values(13,2,10);
insert into carte_biblioteca values(2,3,21);
insert into carte_biblioteca values(4,3,2);
insert into carte_biblioteca values(6,3,2);
insert into carte_biblioteca values(8,3,3);
insert into carte_biblioteca values(10,3,5);
insert into carte_biblioteca values(12,3,2);
insert into carte_biblioteca values(14,3,4);
insert into carte_biblioteca values(20,4,1);
insert into carte_biblioteca values(13,4,5);
insert into carte_biblioteca values(14,4,6);
insert into carte_biblioteca values(2,4,8);
insert into carte_biblioteca values(4,4,9);
insert into carte_biblioteca values(7,4,2);
insert into carte_biblioteca values(19,4,11);
insert into carte_biblioteca values(22,5,3);
insert into carte_biblioteca values(21,5,2);
insert into carte_biblioteca values(15,5,4);
insert into carte_biblioteca values(17,5,2);
insert into carte_biblioteca values(19,5,5);
insert into carte_biblioteca values(3,5,9);
insert into carte_biblioteca values(2,5,12);
insert into carte_biblioteca values(14,6,2);
insert into carte_biblioteca values(5,6,2);
insert into carte_biblioteca values(13,6,3);
insert into carte_biblioteca values(12,6,6);
insert into carte_biblioteca values(10,6,4);
insert into carte_biblioteca values(21,6,6);
insert into carte_biblioteca values(1,6,12);
insert into carte_biblioteca values(1,7,10);
insert into carte_biblioteca values(2,7,5);
insert into carte_biblioteca values(22,7,3);
insert into carte_biblioteca values(21,7,4);
insert into carte_biblioteca values(13,7,2);
insert into carte_biblioteca values(15,7,1);
insert into carte_biblioteca values(9,7,5);


---- angajat

CREATE SEQUENCE SEQ_ANGAJAT
MAXVALUE 9999
START WITH 1
INCREMENT BY 1;

insert into angajat values(seq_angajat.nextval, 'Tomescu', 'Pavel', '0724322453', 'Bibliotecar Sef', 4500 ,to_date('30/01/2022','dd/mm/yyyy'), 1);
insert into angajat values(seq_angajat.nextval, 'Popescu', 'Maria', '0755123456', 'Asistent Bibliotecar', 3000, to_date('10/03/2018', 'dd/mm/yyyy'), 1);
insert into angajat values(seq_angajat.nextval, 'Ionescu', 'Andrei', '0766789123', 'Receptie', 3200, to_date('05/07/2017', 'dd/mm/yyyy'), 1);
insert into angajat values(seq_angajat.nextval, 'Georgescu', 'Ana', '0727567890', 'Asistent Bibliotecar', 2800, to_date('18/09/2015', 'dd/mm/yyyy'), 1);
insert into angajat values(seq_angajat.nextval, 'Constantinescu', 'Alexandru', '0746234501', 'Arhivar', 3100, to_date('22/11/2020', 'dd/mm/yyyy'), 1);
insert into angajat values(seq_angajat.nextval, 'Mihai', 'Cristina', '0737987654', 'Asistent Bibliotecar', 2900, to_date('14/02/2023', 'dd/mm/yyyy'), 1);
insert into angajat values(seq_angajat.nextval, 'Chirita', 'Madalina', '0773243192', 'Bibliotecar Sef', 4500 ,to_date('15/04/2021','dd/mm/yyyy'), 2);
insert into angajat values(seq_angajat.nextval, 'Dumitrescu', 'Ion', '0745123401', 'Asistent Bibliotecar', 3000, to_date('10/03/2018', 'dd/mm/yyyy'), 2);
insert into angajat values(seq_angajat.nextval, 'Stanescu', 'Mirela', '0736789567', 'Receptie', 3200, to_date('05/07/2017', 'dd/mm/yyyy'), 2);
insert into angajat values(seq_angajat.nextval, 'Munteanu', 'Lucian', '0727567123', 'Asistent Bibliotecar', 2800, to_date('18/09/2015', 'dd/mm/yyyy'), 2);
insert into angajat values(seq_angajat.nextval, 'Gheorghe', 'Andreea', '0756234123', 'Arhivar', 3100, to_date('22/11/2020', 'dd/mm/yyyy'), 2);
insert into angajat values(seq_angajat.nextval, 'Popa', 'Mariana', '0737987465', 'Asistent Bibliotecar', 2900, to_date('14/02/2023', 'dd/mm/yyyy'), 2);
insert into angajat values(seq_angajat.nextval, 'Popa', 'Emilian', '0743228551', 'Bibliotecar Sef', 4500 ,to_date('12/05/2023','dd/mm/yyyy'), 3);
insert into angajat values(seq_angajat.nextval, 'Popescu', 'Cristian', '0745123433', 'Asistent Bibliotecar', 3000, to_date('10/03/2018', 'dd/mm/yyyy'), 3);
insert into angajat values(seq_angajat.nextval, 'Mihnea', 'Cristina', '0736789563', 'Arhivar', 3200, to_date('05/07/2017', 'dd/mm/yyyy'), 3);
insert into angajat values(seq_angajat.nextval, 'Georgescu', 'Ana', '0747567123', 'Asistent Bibliotecar', 2800, to_date('18/09/2015', 'dd/mm/yyyy'), 3);
insert into angajat values(seq_angajat.nextval, 'Constantin', 'Alexandru', '0756234563', 'Arhivar', 3100, to_date('22/11/2020', 'dd/mm/yyyy'), 3);
insert into angajat values(seq_angajat.nextval, 'Mihai', 'Ionel', '0727987653', 'Asistent Bibliotecar', 2900, to_date('14/02/2023', 'dd/mm/yyyy'), 3);
insert into angajat values(seq_angajat.nextval, 'Mocanu', 'Victor', '0733123643', 'Bibliotecar Sef', 4500 ,to_date('14/12/2022','dd/mm/yyyy'), 4);
insert into angajat values(seq_angajat.nextval, 'Dumitrescu', 'Ana', '0735123444', 'Asistent Bibliotecar', 3000, to_date('10/03/2018', 'dd/mm/yyyy'), 4);
insert into angajat values(seq_angajat.nextval, 'Stanescu', 'Andreea', '0756789124', 'Arhivar', 3200, to_date('05/07/2017', 'dd/mm/yyyy'), 4);
insert into angajat values(seq_angajat.nextval, 'Munteanu', 'Radu', '0747567344', 'Asistent Bibliotecar', 2800, to_date('18/09/2015', 'dd/mm/yyyy'), 4);
insert into angajat values(seq_angajat.nextval, 'Gheorghe', 'Elena', '0726234544', 'Receptie', 3100, to_date('22/11/2020', 'dd/mm/yyyy'), 4);
insert into angajat values(seq_angajat.nextval, 'Popa', 'Catalin', '0737987644', 'Asistent Bibliotecar', 2900, to_date('14/02/2023', 'dd/mm/yyyy'), 4);
insert into angajat values(seq_angajat.nextval, 'Vasilica', 'Denisa', '0741278831', 'Bibliotecar Sef', 4500 ,to_date('20/10/2021','dd/mm/yyyy'), 5);
insert into angajat values(seq_angajat.nextval, 'Vasilescu', 'Mihai', '0725123455', 'Asistent Bibliotecar', 3000, to_date('02/06/2019', 'dd/mm/yyyy'), 5);
insert into angajat values(seq_angajat.nextval, 'Popovici', 'Andreea', '0736789565', 'R eceptie', 3200, to_date('07/09/2020', 'dd/mm/yyyy'), 5);
insert into angajat values(seq_angajat.nextval, 'Radulescu', 'Cristina', '0747567155', 'Asistent Bibliotecar', 2800, to_date('14/03/2017', 'dd/mm/yyyy'), 5);
insert into angajat values(seq_angajat.nextval, 'Diaconu', 'Alexandru', '0756234575', 'Arhivar', 3100, to_date('28/05/2018', 'dd/mm/yyyy'), 5);
insert into angajat values(seq_angajat.nextval, 'Gheorghiu', 'Elena', '0737987655', 'Asistent Bibliotecar', 2900, to_date('19/11/2022', 'dd/mm/yyyy'), 5);
insert into angajat values(seq_angajat.nextval, 'Calinescu', 'Valentin', '0724172642', 'Bibliotecar Sef', 4500 ,to_date('13/05/2020','dd/mm/yyyy'), 6);
insert into angajat values(seq_angajat.nextval, 'Popescu', 'Adrian', '0725123466', 'Asistent Bibliotecar', 3000, to_date('12/04/2022', 'dd/mm/yyyy'), 6);
insert into angajat values(seq_angajat.nextval, 'Ivanov', 'Maria', '0736789566', 'Receptie', 3200, to_date('25/08/2019', 'dd/mm/yyyy'), 6);
insert into angajat values(seq_angajat.nextval, 'Dragoi', 'Ion', '0747567166', 'Asistent Bibliotecar', 2800, to_date('07/06/2016', 'dd/mm/yyyy'), 6);
insert into angajat values(seq_angajat.nextval, 'Moraru', 'Gabriela', '0756234576', 'Arhivar', 3100, to_date('19/09/2021', 'dd/mm/yyyy'), 6);
insert into angajat values(seq_angajat.nextval, 'Popoviciu', 'Alexandra', '0737987656', 'Asistent Bibliotecar', 2900, to_date('02/02/2017', 'dd/mm/yyyy'), 6);
insert into angajat values(seq_angajat.nextval, 'Muresan', 'Sebastian', '0720658521', 'Bibliotecar Sef', 4500 ,to_date('05/03/2020','dd/mm/yyyy'), 7);
insert into angajat values(seq_angajat.nextval, 'Mihai', 'Roxana', '0725123477', 'Asistent Bibliotecar', 3000, to_date('14/09/2022', 'dd/mm/yyyy'), 7);
insert into angajat values(seq_angajat.nextval, 'Stanescu', 'Cristian', '0736789577', 'Receptie', 3200, to_date('27/12/2020', 'dd/mm/yyyy'), 7);
insert into angajat values(seq_angajat.nextval, 'Alexandrescu', 'Mihaela', '0747567177', 'Asistent Bibliotecar', 2800, to_date('09/02/2019', 'dd/mm/yyyy'), 7);
insert into angajat values(seq_angajat.nextval, 'Popov', 'Adina', '0756234577', 'Arhivar', 3100, to_date('21/05/2017', 'dd/mm/yyyy'), 7);
insert into angajat values(seq_angajat.nextval, 'Radulescu', 'Marius', '0737987657', 'Asistent Bibliotecar', 2900, to_date('05/11/2023', 'dd/mm/yyyy'), 7);


----cititor

CREATE SEQUENCE SEQ_CITITOR
MAXVALUE 9999
START WITH 1
INCREMENT BY 1;

insert into cititor values (seq_cititor.nextval, 'Nae', 'Valentin', '0720930442', to_date('20/05/2002', 'dd/mm/yyyy'));
insert into cititor values(seq_cititor.nextval, 'Popescu', 'Ana', '0738123456', to_date('17/01/2003', 'dd/mm/yyyy'));
insert into cititor values(seq_cititor.nextval, 'Ionescu', 'Andrei', '0756789123', to_date('13/11/2004', 'dd/mm/yyyy'));
insert into cititor values(seq_cititor.nextval, 'Georgescu', 'Maria', '0729876543', to_date('07/12/2005', 'dd/mm/yyyy'));
insert into cititor values(seq_cititor.nextval, 'Constantinescu', 'Cristina', '0732567891', to_date('06/02/1987', 'dd/mm/yyyy'));
insert into cititor values(seq_cititor.nextval, 'Mihai', 'Alexandru', '0745123789', to_date('12/03/1995', 'dd/mm/yyyy'));
insert into cititor values(seq_cititor.nextval, 'Popa', 'Ioana', '0723489567', to_date('28/06/1993', 'dd/mm/yyyy'));
insert into cititor values(seq_cititor.nextval, 'Radu', 'Mihnea', '0736745123', to_date('11/05/2002', 'dd/mm/yyyy'));
insert into cititor values(seq_cititor.nextval, 'Gheorghe', 'Elena', '0742789561', to_date('15/12/1988', 'dd/mm/yyyy'));
insert into cititor values(seq_cititor.nextval, 'Stancu', 'Dragos', '0758912345', to_date('20/10/2007', 'dd/mm/yyyy'));


----abonament

insert into abonament values(1, 20, to_date('26/05/2023', 'dd/mm/yyyy'), to_date('10/12/2023', 'dd/mm/yyyy')+60, 1);
insert into abonament values(2, 100, to_date('27/05/2022', 'dd/mm/yyyy'), to_date('27/05/2022', 'dd/mm/yyyy')+365, 2);
insert into abonament values(7, 40, to_date('20/04/2023', 'dd/mm/yyyy'), to_date('20/04/2023', 'dd/mm/yyyy')+60, 3);
insert into abonament values(3, 100, to_date('15/03/2022', 'dd/mm/yyyy'), to_date('15/03/2022', 'dd/mm/yyyy')+365, 4);
insert into abonament values(4, 60, to_date('07/05/2023', 'dd/mm/yyyy'), to_date('07/07/2023', 'dd/mm/yyyy')+180, 5);
insert into abonament values(8, 60, to_date('07/05/2023', 'dd/mm/yyyy'), to_date('07/07/2023', 'dd/mm/yyyy')+180, 6);
insert into abonament values(5, 100, to_date('24/11/2022', 'dd/mm/yyyy'), to_date('24/11/2022', 'dd/mm/yyyy')+365, 9);
insert into abonament values(6, 60, to_date('06/10/2022', 'dd/mm/yyyy'), to_date('06/10/2022', 'dd/mm/yyyy')+180, 7);


--imprumut

insert into imprumut values(1, 1, 1, 1, to_date('26/05/2023', 'dd/mm/yyyy'), to_date('26/05/2023', 'dd/mm/yyyy')+7); 
insert into imprumut values(2, 1, 1, 20, to_date('26/05/2023', 'dd/mm/yyyy'), to_date('26/05/2023', 'dd/mm/yyyy')+7); 
insert into imprumut values(3, 1, 1, 14, to_date('26/05/2023', 'dd/mm/yyyy'), to_date('26/05/2023', 'dd/mm/yyyy')+7); 
insert into imprumut values(4, 1, 1, 17, to_date('26/05/2023', 'dd/mm/yyyy'), to_date('26/05/2023', 'dd/mm/yyyy')+7); 
insert into imprumut values(5, 1, 1, 15, to_date('26/05/2023', 'dd/mm/yyyy'), to_date('26/05/2023', 'dd/mm/yyyy')+7); 
insert into imprumut values(6, 2, 3, 2, to_date('20/04/2023', 'dd/mm/yyyy'), to_date('20/04/2023', 'dd/mm/yyyy')+14);
insert into imprumut values(7, 2, 3, 3, to_date('20/04/2023', 'dd/mm/yyyy'), to_date('20/04/2023', 'dd/mm/yyyy')+14); 
insert into imprumut values(8, 2, 3, 4, to_date('20/04/2023', 'dd/mm/yyyy'), to_date('20/04/2023', 'dd/mm/yyyy')+14); 
insert into imprumut values(9, 2, 3, 4, to_date('20/04/2023', 'dd/mm/yyyy'), to_date('20/04/2023', 'dd/mm/yyyy')+14); 
insert into imprumut values(10, 2, 3, 21, to_date('20/04/2023', 'dd/mm/yyyy'), to_date('20/04/2023', 'dd/mm/yyyy')+14); 
insert into imprumut values(11, 2, 3, 22, to_date('20/04/2023', 'dd/mm/yyyy'), to_date('20/04/2023', 'dd/mm/yyyy')+14); 
insert into imprumut values(12, 3, 5, 12, to_date('07/05/2023', 'dd/mm/yyyy'), to_date('07/05/2023', 'dd/mm/yyyy')+7); 
insert into imprumut values(13, 3, 5, 16, to_date('10/05/2023', 'dd/mm/yyyy'), to_date('10/04/2023', 'dd/mm/yyyy')+7); 
insert into imprumut values(14, 3, 5, 5, to_date('12/05/2023', 'dd/mm/yyyy'), to_date('12/04/2023', 'dd/mm/yyyy')+10); 
insert into imprumut values(15, 3, 5, 9, to_date('13/05/2023', 'dd/mm/yyyy'), to_date('13/04/2023', 'dd/mm/yyyy')+10); 
insert into imprumut values(16, 1, 9, 5, to_date('24/11/2022', 'dd/mm/yyyy'), to_date('24/11/2022', 'dd/mm/yyyy')+14); 
insert into imprumut values(17, 1, 9, 6, to_date('24/11/2022', 'dd/mm/yyyy'), to_date('24/11/2022', 'dd/mm/yyyy')+14); 
insert into imprumut values(18, 5, 9, 8, to_date('04/03/2023', 'dd/mm/yyyy'), to_date('04/03/2023', 'dd/mm/yyyy')+7); 
insert into imprumut values(19, 5, 9, 9, to_date('04/03/2023', 'dd/mm/yyyy'), to_date('04/03/2023', 'dd/mm/yyyy')+7); 
insert into imprumut values(20, 5, 9, 13, to_date('04/03/2023', 'dd/mm/yyyy'), to_date('04/03/2023', 'dd/mm/yyyy')+7); 
insert into imprumut values(21, 7, 9, 14, to_date('24/05/2023', 'dd/mm/yyyy'), to_date('24/05/2023', 'dd/mm/yyyy')+14); 
insert into imprumut values(22, 4, 6, 10, to_date('07/05/2023', 'dd/mm/yyyy'),to_date('07/05/2023', 'dd/mm/yyyy')+7); 
insert into imprumut values(23, 4, 6, 11, to_date('07/05/2023', 'dd/mm/yyyy'),to_date('07/05/2023', 'dd/mm/yyyy')+7); 
insert into imprumut values(24, 4, 6, 12, to_date('07/05/2023', 'dd/mm/yyyy'),to_date('07/05/2023', 'dd/mm/yyyy')+7); 
insert into imprumut values(25, 4, 6, 15, to_date('07/05/2023', 'dd/mm/yyyy'),to_date('07/05/2023', 'dd/mm/yyyy')+7); 
insert into imprumut values(26, 6, 6, 17, to_date('15/05/2023', 'dd/mm/yyyy'),to_date('15/05/2023', 'dd/mm/yyyy')+14); 
insert into imprumut values(27, 6, 6, 7, to_date('15/05/2023', 'dd/mm/yyyy'),to_date('15/05/2023', 'dd/mm/yyyy')+14); 
insert into imprumut values(28, 6, 6, 5, to_date('15/05/2023', 'dd/mm/yyyy'),to_date('15/05/2023', 'dd/mm/yyyy')+14); 
insert into imprumut values(29, 6, 6, 13, to_date('15/05/2023', 'dd/mm/yyyy'),to_date('15/05/2023', 'dd/mm/yyyy')+14);

commit;





