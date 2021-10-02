--# 1
--a
select * from course where credits > 3;
--b
select * from classroom where building = 'Watson' or building = 'Packard';
--c
select * from course where dept_name = 'Comp. Sci.';
--d
select * from section where semester = 'Fall';
--e
select * from student where tot_cred between 45 and 90;
--f
select * from student where name like '%a' or
                            name like '%e' or
                            name like '%i' or
                            name like '%o' or
                            name like '%u';
--g
select * from prereq where prereq_id = 'CS-101';

--# 2
--a
select dept_name, avg(salary) as avg_salary from instructor  group by dept_name ORDER BY dept_name ASC;
--b
select building, count(course_id) as max_course from section group by building order by max_course DESC limit 1;
--c
select dept_name, count(course_id) as min_course from course group by dept_name order by min_course ASC limit 1;
--d
select student.id ,student.name from student,takes
where student.id = takes.id and student.dept_name='Comp. Sci.'
group by student.id,name
having count(course_id)>3;
--e
select * from instructor
where dept_name in ('Biology','Philosophy','Music');
--f
select name from instructor
except (select name
        from instructor,teaches
        where instructor.id = teaches.id and teaches.year = 2017);

--#3
--a
select student.name, takes.grade, course.course_id, course.dept_name
from student , course, takes
where student.id= takes.id and
      takes.course_id = course.course_id and
      course.dept_name='Comp. Sci.' and takes.grade in ('A','A-') order by student.name ASC ;
--b
select distinct s_id,i_id ,name , grade
from advisor , takes , student
where takes.id=advisor.s_id and student.id=takes.id and takes.grade in ('C', 'C-', 'F');
--c
select distinct dept_name , takes.grade from takes , course
where course.course_id=takes.course_id and takes.grade not in('F','C');
--d
select distinct name
from instructor
where name not in (select name from takes,teaches,instructor
                    where takes.course_id=teaches.course_id and teaches.id=instructor.id and takes.grade in ('A', 'A-'));
--e
select distinct end_min , end_hr
from course , time_slot , section
where course.course_id = section.course_id and section.time_slot_id=time_slot.time_slot_id and section.time_slot_id in ('A','B','C');
