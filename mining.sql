-- total governors candidates
select count(*) from governors_county;

-- How many votes did each candidate receive?
select candidate, sum(total_votes) as 'Total Votes' from president_county_candidate group by candidate;

-- How many counties did each candidate win?
With tb1 as (select * from president_county_candidate where won = 'True')
select candidate, count(*) as 'Counties won'from tb1 group by candidate;

-- percentage of vote won by each candidate
select candidate, sum(total_votes) * 100/(select sum(total_votes) from president_county_candidate) as 'Total Votes' from president_county_candidate group by candidate;

-- seats won by each party in the house
WITH tb1 as (select * from house_candidate where won = 'True')
select party, count(*) as 'Seats won' from tb1 group by party;

-- votes won by each party in the house
select party, max(total_votes) from house_candidate group by party;

-- senate results
select county, party, max(total_votes) from senate_county_candidate group by county, party;