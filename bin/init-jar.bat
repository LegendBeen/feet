@echo off
echo [INFO] ʹ��maven����pom.xml ��������jar����ӦĿ¼.
echo [INFO] compile,runtime����/WebRoot/WEB-INF/lib, test,provided����/lib

set local_path=%cd%

cd %local_path%/..
echo [INFO] pom.xml�ļ�����Ŀ¼ %cd%

call mvn dependency:copy-dependencies -DoutputDirectory=WebRoot/WEB-INF/lib -DincludeScope=runtime -Dsilent=true
pause