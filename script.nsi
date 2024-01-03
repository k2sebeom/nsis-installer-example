; Define const
!define PRODUCT_NAME "NsisExample"
!define PRODUCT_VERSION "0.1.0"
!define REG_HKLM_UNINST "Software\Microsoft\Windows\CurrentVersion\Uninstall"

!include "MUI2.nsh"

; Define the name of the installer
Outfile "${PRODUCT_NAME} Setup ${PRODUCT_VERSION}.exe"
Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
; Install Directory
InstallDir "$PROGRAMFILES\${PRODUCT_NAME}"
ShowInstDetails show


; Unicode True

; Define pages
!define MUI_WELCOMEPAGE_TITLE "Install NSIS Example"
!define MUI_WELCOMEPAGE_TEXT "Example Installer for NSIS"
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE "English"

Section "MainSection" SEC01
    SetOutPath $INSTDIR
    File "dist\*"
    Call InstallAdditionalComponents
SectionEnd

Section "-post"
    DetailPrint "Register Uninstall Info"
    WriteUninstaller "$INSTDIR\Uninstall.exe"

    WriteRegStr HKLM "${REG_HKLM_UNINST}\${PRODUCT_NAME}" "DisplayName" "${PRODUCT_NAME}"
    WriteRegStr HKLM "${REG_HKLM_UNINST}\${PRODUCT_NAME}" "InstallLocation" "$INSTDIR"
    WriteRegStr HKLM "${REG_HKLM_UNINST}\${PRODUCT_NAME}" "UninstallString" "$INSTDIR\Uninstall.exe"
    MessageBox MB_OK "Install Complete"
SectionEnd

Section Uninstall
    RMDir /r "$INSTDIR\*"
    RMDir $INSTDIR

    DeleteRegKey HKLM "${REG_HKLM_UNINST}\${PRODUCT_NAME}"
SectionEnd

Function InstallAdditionalComponents
    MessageBox MB_OK "Installing additional components"
FunctionEnd
