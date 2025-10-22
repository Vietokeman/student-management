@echo off
REM Script push database từ máy lên Android device (đã sửa lỗi permission)

echo ========================================
echo Push SQLite Database to Android Device
echo ========================================
echo.

REM Kiểm tra adb
where adb >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] ADB not found! Please install Android SDK Platform Tools.
    pause
    exit /b 1
)

REM Kiểm tra file database tồn tại
if not exist "student_management.db" (
    echo [ERROR] Database file 'student_management.db' not found!
    echo Please run pull_database.bat first or ensure the file exists.
    pause
    exit /b 1
)

echo [1/5] Checking connected devices...
adb devices
echo.

echo [2/5] Stopping app...
adb shell am force-stop com.example.prm392_student_management
echo.

echo [3/5] Pushing database to SD card...
adb push student_management.db /sdcard/student_management_temp.db
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Failed to push database to SD card!
    pause
    exit /b 1
)
echo.

echo [4/5] Moving database to app directory...
adb shell run-as com.example.prm392_student_management cp /sdcard/student_management_temp.db databases/student_management.db
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Failed to move database to app directory!
    pause
    exit /b 1
)
echo.

echo [5/5] Cleaning up temporary file...
adb shell rm /sdcard/student_management_temp.db
echo.

echo ========================================
echo SUCCESS! Database pushed to device.
echo Restart the app to load new data!
echo ========================================
pause
