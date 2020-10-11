-- List of employees with corresponding title that will retire (ordered by employee number) 
SELECT e.emp_no, e.first_name, e.last_name, 
	   ti.title, ti.from_date, ti.to_date
INTO retirement_titles
FROM employees AS e
JOIN titles AS ti
ON (e.emp_no=ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows, unique employees with current title
SELECT DISTINCT ON (emp_no) emp_no,
first_name, 
last_name, 
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- List and count of retiring titles
SELECT COUNT(emp_no), title 
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT DESC;

-- Determine employees who are eligible to participate in the mentorship program.
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, 
 		de.from_date, de.to_date, 
 		ti.title 
INTO mentorship_eligibilty
FROM employees AS e
JOIN dept_emp AS de
ON (e.emp_no=de.emp_no)
JOIN titles AS ti
ON (e.emp_no=ti.emp_no)
WHERE (de.to_date = '9999-01-01')
AND(e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no, ti.to_date DESC
