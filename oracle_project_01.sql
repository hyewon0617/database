create table job (
j_code number(20) primary key, -- 1 2 3 4
j_name VARCHAR2(20),
skill VARCHAR2(20),
j_type VARCHAR2(20),
j_nanido VARCHAR2(20)

);

insert into job values(1, 'Warrior', 'Fast cut', 'ANGEL', 'easy');
insert into job values(2, 'Magician', 'Magical fire', 'ANGEL', 'normal');
insert into job values(3, 'Assassin', 'Shadow punch', 'DEVIL', 'hard');
insert into job values(4, 'Healer', 'Shine heal', 'DEVIL', 'easy');
insert into job values(5, 'Archer', 'Last shoot', 'ANGEL', 'normal');
insert into job values(6, 'Rapparee', 'Gun booster', 'DEVIL', 'hard');
select * from job
delete from job where j_code = 2

select * from monster