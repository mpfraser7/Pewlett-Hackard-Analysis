SELECT em.emp_no, em.first_name, em.last_name, ti.title, ti.from_date, ti.to_date
INTO retirement_titles
FROM employees as em
INNER JOIN titles as ti
ON em.emp_no = ti.emp_no
WHERE em.birth_date BETWEEN '1952-01-01' AND '1955-01-01'
ORDER BY em.emp_no


SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no ASC

SELECT title, COUNT (title) AS titles_count
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY titles_count DESC

SELECT DISTINCT ON (em.emp_no) em.emp_no, em.first_name, em.last_name, em.birth_date, de.from_date, de.to_date, ti.title
INTO membership_eligibility
FROM employees AS em
LEFT JOIN dept_emp AS de ON em.emp_no = de.emp_no
LEFT JOIN titles AS ti ON em.emp_no = ti.emp_no
WHERE (de.to_date = '9999-01-01') 
AND (em.birth_date BETWEEN '1965-01-01' AND '1965-01-12')
ORDER BY em.emp_no ASC