select * from t_opinion;
select * from t_tag;
call sample_data (100000);
call get_tags('');
select * from t_opinion order by f_opinion_id desc limit 10;
-- truncate t_opinion;
-- delete from t_opinion where f_user_id = 123 limit 100000;
update t_tag a set a.f_count = (select count(1) from t_opinion b where f_status = 'Active' and b.f_tag_id = a.f_tag_id) limit 1000000;
update t_opinion set f_time = sysdate() - interval floor(rand() * 8000000) second limit 10000000;

select * from t_tag where f_tag like '%ebo%';

call get_opinions(null, 0, null, null, null , null , null , null);

select * from t_tag  where f_tag like concat('','%');

call insert_opinion( NULL, 'ebola', -10.278378211, 34.1898298989812, 25, 62, 77);

select f_tag from t_tag where f_status = 'active' and f_tag like concat('%','ebo','%') order by f_count desc;
