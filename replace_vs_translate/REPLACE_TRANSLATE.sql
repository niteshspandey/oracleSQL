--REPLACE VS TRANSLATE
--BOTH ARE STRING MANIPULATION FUNCTION

--REPLACE
--3 PARAMETER(1-STRING,SEARCH_STRING,REPLACE_STRING)

SELECT REPLACE('NITESH SARVESH PANDEY','SARVESH','SARVESHKUMAR') FROM DUAL;--NITESH SARVESHKUMAR PANDEY
SELECT REPLACE('NITESH SARVESH PANDEY','SARVESH','') FROM DUAL;--NITESH  PANDEY
SELECT REPLACE('NITESH SARVESH PANDEY','SARVESH') FROM DUAL;--NITESH  PANDEY

--TRANSLATE FUNCTION
--ONE TO ONE MAPPING OF CHARACTER OR CHARACTER BY CHARACTER REPLACEMENT.
SELECT TRANSLATE('NITESH SARVESH PANDEY','ABCD','1234') FROM DUAL;--NITESH S1RVESH P1N4EY
SELECT TRANSLATE('ABCCCD','ABC','1234') FROM DUAL;--12333D
SELECT TRANSLATE('WELCOME','ORACLE','1234') FROM DUAL;--W41M
SELECT TRANSLATE('ABCDS','ACB','12') FROM DUAL;--12DS
SELECT TRANSLATE('ABCDS','ACBD','123') FROM DUAL;--132S
