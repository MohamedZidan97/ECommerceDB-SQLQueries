Use CollegeDB
Go

--1) Store procedure

alter proc GetIns @Id int
with encryption
as
    select  InstructorID,FirstName from Instructors where InstructorID = @Id

	-- yes encrypted
SP_helptext GetIns

-- execute
exec GetIns 1 
	


	alter proc GetIns @Id int
as
    select  InstructorID,FirstName from Instructors where InstructorID = @Id


declare @id int 

select  @id 