--REPLACE VS TRANSLATE
--BOTH ARE STRING MANIPULATION FUNCTION

--REPLACE
--3 PARAMETER(1-STRING,SEARCH_STRING,REPLACE_STRING)

SELECT REPLACE('NITESH SARVESH PANDEY','SARVESH','SARVESHKUMAR') FROM DUAL;--NITESH SARVESHKUMAR PANDEY
SELECT REPLACE('NITESH SARVESH PANDEY','SARVESH','') FROM DUAL;--NITESH  PANDEY
SELECT REPLACE('NITESH SARVESH PANDEY','SARVESH') FROM DUAL;--NITESH  PANDEY
select replace('Nitesh Sarvesh Pandey','Sarvesh','Sarveshkumar') as modified_name from dual;--Nitesh Sarveshkumar Pandey
select replace('Nitesh Sarvesh Pandey','Sarvesh','') as modified_name from dual;--Nitesh  Pandey
select replace('Nitesh Sarvesh Pandey','Sarvesh') as modified_name from dual;--Nitesh  Pandey
select replace('Nitesh Sarvesh Pandey','Nitesh','Nit') as modified_name from dual;--Nit Sarvesh Pandey
select replace('Nitesh Sarvesh Pandey','Nitesh1','') as modified_name from dual;--Nitesh Sarvesh Pandey
select replace('Nitesh Sarvesh Pandey',' ','') as modified_name from dual;--NiteshSarveshPandey




--TRANSLATE FUNCTION
--ONE TO ONE MAPPING OF CHARACTER OR CHARACTER BY CHARACTER REPLACEMENT.
SELECT TRANSLATE('NITESH SARVESH PANDEY','ABCD','1234') FROM DUAL;--NITESH S1RVESH P1N4EY
SELECT TRANSLATE('ABCCCD','ABC','1234') FROM DUAL;--12333D
SELECT TRANSLATE('WELCOME','ORACLE','1234') FROM DUAL;--W41M
SELECT TRANSLATE('ABCDS','ACB','12') FROM DUAL;--12DS
SELECT TRANSLATE('ABCDS','ACBD','123') FROM DUAL;--132S
select TRANSLATE('Nitesh pandey','nit','')from dual;--return null if 3rd argument is null
select TRANSLATE('Nitesh pandey','nit')from dual;--error occurred (Invalid no of argument) same is working fine in case of replace
select TRANSLATE('Nitesh pandey','nit','abc')from dual;--Nbcesh paadey
select TRANSLATE('Nitesh pandey','nit','abc12')from dual;--Nbcesh paadey
select TRANSLATE('Nitesh pandey','nitshi','abc12')from dual;--Nbce12 paadey
select TRANSLATE('Nitesh pandeyi','nitshi','abc123')from dual;--Nbce12 paadeyb
select TRANSLATE('Nitesh Pandey','','') from dual;--return null
