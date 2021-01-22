FROM microsoft/iis

# Rótulos
LABEL name="windows/iis web server" \
  summary="Imagem para execução do IIS e SSH Server." \
  maintainer="Antonio Jousivan S. Sousa <ajssti@gmail.com>" \
  description="sudo docker run --name <NOME_CONTAINER> --hostname <NOME_CONTAINER> -d -e <VARIAVEL>=<VALOR_VARIAVEL> -P ajss/ajss/windows:windows-iis-ssh" \
  la.foton.ssh-usuario-default="ssh" \
  la.foton.ssh-senha-default="senha_ssh" \
  la.foton.iis-porta-default="80" \
  la.foton.iis-caminho-ssh="c:/OpenSSH-Win64/" \
  la.foton.iis-caminho-servidor-web-iis-sisag="c:/inetpub/wwwroot/site"

RUN powershell -NoProfile -Command Remove-Item -Recurse C:\inetpub\wwwroot\*

WORKDIR /inetpub/wwwroot

COPY /site/ /inetpub/wwwroot/site

COPY util/conf/wget/wget.exe c:/OpenSSH-Win64/

COPY util/conf/wget/libintl3.dll c:/Windows/System32

RUN powershell Install-WindowsFeature Web-Mgmt-Service && \
    powershell Install-WindowsFeature Web-Windows-Auth && \
    powershell Install-WindowsFeature NET-Framework-45-ASPNET && \
    powershell Install-WindowsFeature Web-Asp-Net45 && \
    powershell Install-WindowsFeature NET-WCF-HTTP-Activation45 && \
    net start wmsvc && \
    sc config WMSVC start= auto && \
    powershell -NoProfile -Command Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\WebManagement\Server -Name EnableRemoteManagement -Value 1

#Adicionar extensoes validas .deb, .png, .sh
RUN c:\windows\system32\inetsrv\APPCMD set config "Default Web Site" -section:system.webServer/staticContent /+"[fileExtension='deb',mimeType='Arquivo/Debian']" && \
    c:\windows\system32\inetsrv\APPCMD set config "Default Web Site" -section:system.webServer/staticContent /+"[fileExtension='png',mimeType='arquivo/png']" && \
    c:\windows\system32\inetsrv\APPCMD set config "Default Web Site" -section:system.webServer/staticContent /+"[fileExtension='sh',mimeType='application/x-sh']"

# Install Powershell
#ADD https://github.com/PowerShell/PowerShell/releases/download/v6.0.0/PowerShell-6.0.0-win-x64.zip c:/powershell.zip
COPY util/conf/PowerShell-6.0.0-win-x64.zip c:/powershell.zip
RUN powershell.exe -Command Expand-Archive c:/powershell.zip c:/PS6 ; Remove-Item c:/powershell.zip
RUN C:/PS6/pwsh.EXE -Command C:/PS6/Install-PowerShellRemoting.ps1

# Install SSH
#ADD https://github.com/PowerShell/Win32-OpenSSH/releases/download/0.0.24.0/OpenSSH-Win64.zip c:/openssh.zip
COPY util/conf/OpenSSH-Win64.zip c:/openssh.zip
RUN c:/PS6/pwsh.exe -Command Expand-Archive c:/openssh.zip c:/ ; Remove-Item c:/openssh.zip
RUN c:/PS6/pwsh.exe -Command c:/OpenSSH-Win64/Install-SSHd.ps1

# Configure SSH
COPY util/conf/sshd_config c:/OpenSSH-Win64/sshd_config

# Don't use powershell as -f paramtere causes problems.
RUN c:/OpenSSH-Win64/ssh-keygen.exe -t dsa -N "" -f ssh_host_dsa_key && \
    c:/OpenSSH-Win64/ssh-keygen.exe -t rsa -N "" -f ssh_host_rsa_key && \
    c:/OpenSSH-Win64/ssh-keygen.exe -t ecdsa -N "" -f ssh_host_ecdsa_key && \
    c:/OpenSSH-Win64/ssh-keygen.exe -t ed25519 -N "" -f ssh_host_ed25519_key

# Create a user to login, as containeradministrator password is unknown
RUN net USER ssh "senha_ssh" /ADD && net localgroup "Administrators" "ssh" /ADD

# Set PS6 as default shell
RUN C:/PS6/pwsh.EXE -Command \
    New-Item -Path HKLM:\SOFTWARE -Name OpenSSH -Force; \
    New-ItemProperty -Path HKLM:\SOFTWARE\OpenSSH -Name DefaultShell -Value c:\ps6\pwsh.exe -PropertyType string -Force ; 

RUN C:/PS6/pwsh.EXE -Command \
    ./Install-sshd.ps1; \
    ./FixHostFilePermissions.ps1 -Confirm:$false;

EXPOSE 80 443 22 

RUN net start sshd && \
    sc config sshd start= auto && \
    powershell -NoProfile -Command Start-Service sshd