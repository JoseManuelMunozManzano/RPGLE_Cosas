--
-- Subject: iSee - How ifs_path can simplify working with the IFS
-- Author: Scott Forstie (with Tim Rowe)  
-- Date  : June, 2025
--
-- Function - The request was... give IBM i developers SQL-based tools for the IFS
--
-- Resources:
-- https://www.ibm.com/docs/en/i/7.6.0?topic=services-ifs-path-scalar-function
--
-- Note: ifs_path was PTF'd to IBM i 7.5 and 7.6 in April, 2025
stop;

--
-- Let's examine what ifs_path can do
--
SELECT path_name, object_type, 
       systools.ifs_path(path_name => path_name, subsection => 'PATH PREFIX')    as path_pre,
       systools.ifs_path(path_name => path_name, subsection => 'FILE NAME')      as file_name,
       systools.ifs_path(path_name => path_name, subsection => 'FILE PREFIX')    as file_pre,
       systools.ifs_path(path_name => path_name, subsection => 'FILE EXTENSION') as file_ext  
  FROM TABLE (
      qsys2.ifs_object_statistics('/home/jomuma/data')
    ) order by create_timestamp desc;
stop;

--
-- Find all my SQL scripts
--
SELECT path_name, data_change_timestamp, data_size
  FROM TABLE (
      qsys2.ifs_object_statistics('/home/jomuma')
    )
  WHERE systools.ifs_path(path_name => path_name, subsection => 'FILE EXTENSION') = 'sql'
  order by data_change_timestamp desc;
stop;

-- OLD way !!!!!
-- Group by combines rows that yield identical group by values
--
SELECT SUBSTR(path_name, 1, LOCATE_IN_STRING(path_name, '/', -1)) AS sub_dir,
       COUNT(*) AS ifs_objects, SUM(data_size) AS subdir_size
  FROM TABLE (
      qsys2.ifs_object_statistics('/home/jomuma')
    )
  WHERE object_type <> '*DIR'
  GROUP BY SUBSTR(path_name, 1, LOCATE_IN_STRING(path_name, '/', -1))
  ORDER BY subdir_size DESC;
stop;

set session authorization jomuma;
--
-- Space study of all my subdirectories
--
SELECT systools.ifs_path(path_name => path_name, subsection => 'PATH PREFIX') AS subdir_name,
       COUNT(*) AS subdir_count, SUM(data_size) AS subdir_size
  FROM TABLE (
      qsys2.ifs_object_statistics('/home/jomuma')
    )
  WHERE object_type <> '*DIR'
  GROUP BY systools.ifs_path(path_name => path_name, subsection => 'PATH PREFIX')
  ORDER BY subdir_size DESC;
stop;   

--
-- Build a path string that represents a new file, 
-- status_yymmdd.txt, in the same directory as the provided path.
-- 
VALUES systools.ifs_path(
    path_name  => '/usr/mydir/prior_resultfile.txt', 
    subsection => 'PATH PREFIX') 
    CONCAT 'status_' CONCAT varchar_format(CURRENT DATE, 'YYYYMMDD') CONCAT '.txt';
stop;
