-- 1. Using subquery, find the names of the tracks for the albums "Californication".

SELECT Tracks.Name, Albums.Title 
FROM Tracks 
left join Albums
on Tracks.AlbumId = Albums.AlbumId
where Albums.Title = 'Californication'

-- 2. Find the total number of invoices for each customers along with customers 
-- full name, city and email.

select a.FirstName, a.LastName, a.City, a.Email, count(a.InvoiceId) as TotalInv
from
(select Customers.FirstName,Customers.LastName,Customers.City,
Customers.Email,Invoices.InvoiceId
from Customers
left join Invoices
on Customers.CustomerId=Invoices.CustomerId) as a
group by a.FirstName
having a.FirstName = "František"

-- 3 Retrieve the track name, albums, artistID and trackID for all the albums

select Tracks.Name, Tracks.TrackId, Albums.Title, Albums.ArtistId
from tracks
left join Albums
on Tracks.AlbumId=Albums.AlbumId
where Albums.Title like "For Those About to Rock We Salute You"
and Tracks.TrackId = 12

-- 4 Retrieve a list with the managers last name, and the last name of the employees who
-- report to him or her

select a.LastName as EmployeeLast, a.ReportsTo, b.LastName as ManagerLast
from Employees as a
left join Employees as b
on a.ReportsTo = b.EmployeeId
where b.LastName like "Mitchell"

-- 5 Find the name and ID of the artist who do no have albums

select a.Name
from(select Artists.ArtistId, Artists.Name, Albums.AlbumId
from Artists 
left join Albums
on Artists.ArtistId=Albums.ArtistId
where Albums.AlbumId is null) as a

-- 6 Use a UNION to create a list of all employee's and customer's first names
-- and last names ordered by the last name in descending order.

select FirstName, LastName from Employees
union
select FirstName, LastName from Customers
order by LastName desc

-- 7 See if there are any customers who have a different city listed in their
-- billing city verces their customers city.

select Customers.FirstName, Customers.City, Invoices.BillingCity
from Customers
left join Invoices
on Customers.CustomerId = Invoices.CustomerId
where Customers.City <> Invoices.BillingCity