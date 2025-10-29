@echo off
REM create obj and bin folders if non exiting, since
REM the development tools will not create them themselves
if not exist obj mkdir obj
if not exist bin mkdir bin

echo.
echo Compile the C code
echo --------------------------
compile Worm.c -o obj\Worm.asm || goto :failed
echo.
echo Assemble the ASM code
echo --------------------------
assemble obj\Worm.asm -o obj\Worm.vbin || goto :failed

echo.
echo Convert the PNG textures
echo --------------------------
png2vircon libs\TextFonts\TextureFont22x32.png -o obj\TextureFont22x32.vtex    || goto :failed

echo.
echo Pack the ROM
echo --------------------------
packrom Worm.xml -o "bin\Worm.v32" || goto :failed
goto :succeeded

:failed
echo.
echo BUILD FAILED
exit /b %errorlevel%

:succeeded
echo.
echo BUILD SUCCESSFUL
exit /b

@echo on