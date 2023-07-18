PL/SQL user named exception. you can define your own error message and error number using Pragma EXCEPTION_INIT or RAISE_APPLICATION_ERROR function.

pragma EXCEPTION_INIT: Pragma is a keyword directive to execute proceed at compile time. pragma EXCEPTION_INIT function take this two argument,
1. exception_name.
2. error_number.

You can define pragrma EXCEPTION_INIT in DECLARE BLOCK on your program.
PRAGMA EXCEPTION_INIT(exception_name, -error_number);
