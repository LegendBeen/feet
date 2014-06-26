@echo off
echo [INFO] 使用maven根据pom.xml 复制依赖jar到相应目录.
echo [INFO] compile,runtime级别到/WebRoot/WEB-INF/lib, test,provided级别到/lib

set local_path=%cd%

cd %local_path%/..
echo [INFO] pom.xml文件所在目录 %cd%

call mvn dependency:copy-dependencies -DoutputDirectory=WebRoot/WEB-INF/lib -DincludeScope=runtime -Dsilent=true
pause