select count(*) from [dbo].[cleaned_dataset]

--EDA---


select count(*) from [dbo].[cleaned_dataset]

select count(distinct artist) from [dbo].[cleaned_dataset]

select count(distinct album) from [dbo].[cleaned_dataset]


select distinct album_type from [dbo].[cleaned_dataset]

select max(duration_min), min(duration_min) from [dbo].[cleaned_dataset]


delete from 
 [dbo].[cleaned_dataset]
 where duration_min = 0

 ---- Business problem easy level --

 --- 1.  retrive the all the track more than 1 billion streams--

 select * from [dbo].[cleaned_dataset]
 where stream > 1000000000

 ---2.list all the unique albums ---

 select distinct
 album , artist 
 from [dbo].[cleaned_dataset] 

 --no of comments lisenced true--

 select count(*) from  [dbo].[cleaned_dataset]  
 where Licensed = 1


 ---all the tracks which belongs to type single --

 select * from [dbo].[cleaned_dataset]  
 where album_type ='Single'

 ---total no of tracks by each artist---
select count(track) as no_of_tracks
,artist from [dbo].[cleaned_dataset]  
group by artist
order by 1 desc


---Medium level problems--

--calculate the average densability of trcks in each album--

select avg(danceability) as averga, album from [dbo].[cleaned_dataset] 
group by album
order by averga desc

----top 5 tracks with highest energy values--

select top 5 
max(energy),track from [dbo].[cleaned_dataset] 
group by track
order by max(energy)

--list all the tracks total likes and comment where official video='True

select sum(likes) as total_likes,sum(comments),track from 
[dbo].[cleaned_dataset] 
where Licensed = 1
group by track
order by 1 desc


-- For each album calculte total views with the track--

select track,sum(views),album  from [dbo].[cleaned_dataset] 
group by track , album 
order by 2

--- retreive the songs played in spotify more than you tube--
select * from 

(SELECT 
    track,
    COALESCE(SUM(CASE WHEN most_playedon = 'youtube' THEN stream END), 0) AS stream_on_youtube,
    COALESCE(SUM(CASE WHEN most_playedon = 'spotify' THEN stream END), 0) AS stream_on_spotify
FROM 
    [dbo].[cleaned_dataset]
GROUP BY 
    track) as sub_query

where stream_on_spotify>stream_on_youtube

-----Hard level problems----

--1. top 3 most viewed track for each artist using window  function ---
select * from 
(
select artist,track,
 sum(views) as total_views 
 , dense_rank() over( partition by artist order by sum(views) desc) as rnk
 from [dbo].[cleaned_dataset]
 group by artist,track
 ) as sub_query 
where rnk < =3

----2. write the query where lineness score is above the average--

select * from [dbo].[cleaned_dataset]
where Liveness>(select avg(liveness) from [dbo].[cleaned_dataset])

---3.calculate the diff between highest and the lowest energy values  for trcaks in each columns--
with ct as (
select album,max(energy) as maxi,min(energy) as mini  from 
[dbo].[cleaned_dataset] group  by album
)
select(maxi-mini) as diff ,album
from ct


















