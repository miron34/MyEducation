--Со сколькими креативными агентствами мы работаем? 
--Креативное агентство – это партнер без единой локации, 
--но имеющий патент на хотя бы одну легенду.

select p.partner_rk
from partner p 
left join "location" l on p.partner_rk = l.partner_rk 
left join legend l2 on p.partner_rk = l2.partner_rk 
group by p.partner_rk 
having 1=1
	and count(distinct l.location_rk) = 0
	and count(distinct l2.legend_rk) > 0
	
	
--У какого квеста (укажите его quest_nm) разница доли состоявшихся квестов 
--в декабре 2022 и в январе 2023 наибольшая по модулю? 
--Долей считать количество состоявшихся квестов деленное на количество заявленных. 
--В случае наличия нескольких квестов, подходящих под условие, 
--требуется вывести тот, у которого значение quest_rk больше.
	
select q.quest_nm, q.quest_rk, abs(fin_202212 - fin_202301) as diff
from quest q
inner join (
	select quest_rk, sum(game_flg)/count(game_rk)::decimal as fin_202212
	from game  
	where extract(month from game_dttm) = 12 and extract(year from game_dttm) = 2022	
	group by quest_rk 
) res_202212 on q.quest_rk = res_202212.quest_rk
inner join
(
	select quest_rk, sum(game_flg)/count(game_rk)::decimal as fin_202301
	from game  
	where extract(month from game_dttm) = 1 and extract(year from game_dttm) = 2023
	group by quest_rk 
) res_202301 on q.quest_rk = res_202301.quest_rk
order by diff desc, q.quest_rk desc
