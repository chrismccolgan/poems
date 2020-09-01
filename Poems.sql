--1. What grades are stored in the database?
SELECT 
	Name
FROM Grade;

--2. What emotions may be associated with a poem?
SELECT 
	Name
FROM Emotion;

--3. How many poems are in the database?
SELECT
	COUNT(ID)
FROM Poem;

--4. Sort authors alphabetically by name. What are the names of the top 76 authors?
--5. Starting with the above query, add the grade of each of the authors.
--6. Starting with the above query, add the recorded gender of each of the authors.
SELECT TOP 76 
	a.Name,
	gr.Name AS Grade,
	ge.Name AS Gender
FROM Author a
	LEFT JOIN Grade gr ON a.GradeId = gr.Id
	LEFT JOIN Gender ge ON a.GenderId = ge.Id
ORDER BY a.Name;

--7. What is the total number of words in all poems in the database?
SELECT
	SUM(WordCount)
FROM Poem

--8. Which poem has the fewest characters?
SELECT *
FROM Poem
WHERE CharCount = (SELECT MIN(CharCount) FROM Poem);

--9. How many authors are in the third grade?
SELECT
	COUNT(a.Id)
FROM Author a
	LEFT JOIN Grade gr ON a.GradeId = gr.Id
WHERE gr.Name = '3rd Grade';

--10. How many authors are in the first, second or third grades?
SELECT
	COUNT(a.Id)
FROM Author a
	LEFT JOIN Grade gr ON a.GradeId = gr.Id
WHERE gr.Name = '1st Grade' OR gr.Name = '2nd Grade' OR gr.Name = '3rd Grade';

--11. What is the total number of poems written by fourth graders?
SELECT
	COUNT(p.Id)
FROM Poem p
	LEFT JOIN Author a ON p.AuthorId = a.Id
	LEFT JOIN Grade gr ON a.GradeId = gr.Id
WHERE gr.Name = '4th Grade';

--12. How many poems are there per grade?
SELECT
	gr.Name AS Grade,
	COUNT(p.Id) AS Poems
FROM Poem p
	LEFT JOIN Author a ON p.AuthorId = a.Id
	LEFT JOIN Grade gr ON a.GradeId = gr.Id
GROUP BY gr.Name;

--13. How many authors are in each grade? (Order your results by grade starting with 1st Grade)
SELECT
	gr.Name AS Grade,
	COUNT(a.Id) AS Authors
FROM Author a
	LEFT JOIN Grade gr ON a.GradeId = gr.Id
GROUP BY gr.Name;

--14. What is the title of the poem that has the most words?
SELECT
	Title
FROM Poem
WHERE WordCount = (SELECT MAX(WordCount) FROM Poem);

--15. Which author(s) have the most poems? (Remember authors can have the same name.)
SELECT
	a.Id,
	a.Name,
	COUNT(p.Id) AS NumPoems
FROM Poem p
	LEFT JOIN Author a ON p.AuthorId = a.Id
GROUP BY a.Id, a.Name
ORDER BY NumPoems DESC;

--16. How many poems have an emotion of sadness?
SELECT
	COUNT(pe.Id)
FROM PoemEmotion pe
	LEFT JOIN Emotion e ON pe.EmotionId = e.Id
WHERE e.Name = 'Sadness';

--17. How many poems are not associated with any emotion?
SELECT
	COUNT(p.Id)
FROM Poem p
	LEFT JOIN PoemEmotion pe ON p.Id = pe.PoemId
WHERE pe.EmotionId IS NULL;

--18. Which emotion is associated with the least number of poems?
SELECT
	e.Name AS Emotion,
	COUNT(pe.Id) AS Poems
FROM PoemEmotion pe
	LEFT JOIN Emotion e ON pe.EmotionId = e.Id
GROUP BY e.Name
ORDER BY COUNT(pe.Id);

--19. Which grade has the largest number of poems with an emotion of joy?
SELECT
	gr.Name,
	COUNT(pe.Id) AS Poems
FROM PoemEmotion pe
	LEFT JOIN Emotion e ON pe.EmotionId = e.Id
	LEFT JOIN Poem p ON pe.PoemId = p.Id
	LEFT JOIN Author a ON p.AuthorId = a.Id
	LEFT JOIN Grade gr ON a.GradeId = gr.Id
WHERE e.Name = 'Joy'
GROUP BY gr.Name
ORDER BY COUNT(pe.Id) DESC;

--20. Which gender has the least number of poems with an emotion of fear?
SELECT
	ge.Name,
	COUNT(pe.Id) AS Poems
FROM PoemEmotion pe
	LEFT JOIN Emotion e ON pe.EmotionId = e.Id
	LEFT JOIN Poem p ON pe.PoemId = p.Id
	LEFT JOIN Author a ON p.AuthorId = a.Id
	LEFT JOIN Gender ge ON a.GenderId = ge.Id
WHERE e.Name = 'Fear'
GROUP BY ge.Name
ORDER BY COUNT(pe.Id);