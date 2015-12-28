
@echo off&setlocal EnableDelayedExpansion
set a=012345789ABCDEF
set /a b=%random%%%14+1
set /a c=%random%%%14+1
set /a d=%random%%%14+1
set /a e=%random%%%14+1
set /a f=%random%%%14+1
set /a g=%random%%%14+1
set /a h=%random%%%14+1
set /a i=%random%%%14+1
set /a j=%random%%%14+1
set /a k=%random%%%14+1
set /a l=%random%%%14+1
set /a m=%random%%%14+1
:: set mac=!a:~%b%,1!-!a:~%d%,1!!a:~%e%,1!-!a:~%f%,1!!a:~%g%,1!-!a:~%h%,1!!a:~%i%,1!-!a:~%j%,1!!a:~%k%,1!-!a:~%l%,1!!a:~%m%,1!
:: set mac=!a:~%b%,1!!a:~%c%,1!!a:~%d%,1!!a:~%e%,1!!a:~%f%,1!!a:~%g%,1!!a:~%h%,1!!a:~%i%,1!!a:~%j%,1!!a:~%k%,1!!a:~%l%,1!!a:~%m%,1!
set mac=00!a:~%d%,1!!a:~%e%,1!!a:~%f%,1!!a:~%g%,1!!a:~%h%,1!!a:~%i%,1!!a:~%j%,1!!a:~%k%,1!!a:~%l%,1!!a:~%m%,1!

endlocal&set "%~1=%mac%"