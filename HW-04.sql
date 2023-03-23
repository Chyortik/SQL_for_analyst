-- Семинар 4
-- 1. Подсчитать общее количество лайков, которые получили пользователи младше 12 лет.

USE lesson_4;

SELECT count(*)
FROM likes
WHERE media_id IN (
	SELECT id 
	FROM media 
	WHERE user_id IN (
		SELECT user_id
		FROM profiles AS p
		WHERE YEAR(CURDATE()) - YEAR(birthday) < 12
	)
);

-- 2. Определить кто больше поставил лайков (всего): мужчины или женщины.

USE lesson_4;

SELECT gender FROM (
	SELECT gender, 
    COUNT(
		(SELECT COUNT(*) 
		FROM likes AS L
		WHERE L.user_id = P.user_id)
        )
    AS gender_likes_count
    FROM profiles AS P
	
    WHERE gender = 'm'
	GROUP BY gender
	UNION ALL
	SELECT gender, COUNT(
		(SELECT COUNT(*) FROM likes AS L
        WHERE L.user_id = P.user_id)
        )
	FROM profiles AS P
	WHERE gender = 'f'
	GROUP BY gender
) AS T
GROUP BY gender
ORDER BY MAX(gender_likes_count) DESC
LIMIT 1;


-- 3. Вывести всех пользователей, которые не отправляли сообщения.

USE lesson_4;

select id from users
where id not in (select from_user_id from messages);


/* (по желанию)* Пусть задан некоторый пользователь.
 Из всех друзей этого пользователя найдите человека, который больше всех написал ему сообщений.*/

USE lesson_4;

select from_user_id,
	count(to_user_id) as count_message from messages
where to_user_id = 1 
	and
		from_user_id in (
			select target_user_id from friend_requests fr
			where initiator_user_id = 1 and status = 'approved'
		)
	or 
		from_user_id in (
			select initiator_user_id from friend_requests fr
			where target_user_id = 1 and status = 'approved'
		)
group by from_user_id
order by count_message desc
limit 1;