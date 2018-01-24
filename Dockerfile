# escape = `

FROM microsoft/windowsservercore as installer

SHELL [ "powershell", "-Command", "$ErrorActionPreference = 'Stop';$ProgressPreference='silentlyContinue';"]

RUN Invoke-WebRequest -OutFile nodejs.zip -UseBasicParsing "https://nodejs.org/dist/v9.4.0/node-v9.4.0-win-x64.zip"; `
Expand-Archive nodejs.zip -DestinationPath C:\; `
Rename-Item "C:\node-v9.4.0-win-x64" c:\nodejs

FROM microsoft/nanoserver:latest

WORKDIR C:\nodejs

COPY --from=installer C:\nodejs\ .

RUN SETX PATH C:\nodejs

RUN npm config set registry https://registry.npmjs.org/

WORKDIR C:\

RUN npm install @angular/cli -g 
