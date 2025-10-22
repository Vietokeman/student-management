@echo off
REM Script pull database từ Android device về máy (đã sửa lỗi permission)

echo ========================================
echo Pull SQLite Database từ Android Device
echo ========================================
echo.

REM Kiểm tra adb
where adb >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] ADB not found! Please install Android SDK Platform Tools.
    pause
    exit /b 1
)

echo [1/5] Checking connected devices...
adb devices
echo.

echo [2/5] Stopping app...
adb shell am force-stop com.example.prm392_student_management
echo.

echo [3/5] Copying database to SD card (bypassing permission)...
adb shell run-as com.example.prm392_student_management cp databases/student_management.db /sdcard/student_management_temp.db
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Failed to copy database to SD card!
    echo Tip: Make sure the app has been run at least once to create the database.
    pause
    exit /b 1
)
echo.

echo [4/5] Pulling database from SD card...
adb pull /sdcard/student_management_temp.db ./student_management.db
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Failed to pull database from SD card!
    pause
    exit /b 1
)
echo.

echo [5/5] Cleaning up temporary file...
adb shell rm /sdcard/student_management_temp.db
echo.

REM Optional: Copy to backup with timestamp
set timestamp=%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%
set timestamp=%timestamp: =0%
if not exist ".\backups\" mkdir backups
copy student_management.db ".\backups\student_management_%timestamp%.db" >nul
echo [BACKUP] Created: backups\student_management_%timestamp%.db
echo.

echo ========================================
echo SUCCESS! Database saved to: student_management.db
echo You can now open it in DBeaver!
echo ========================================
pause
