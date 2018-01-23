# escape = `

FROM microsoft/windowsservercore as installer

SHELL [ "powershell", "-Command", "$ErrorActionPreference = 'Stop';$ProgressPreference='silentlyContinue';"]

RUN Invoke-WebRequest -OutFile nodejs.zip -UseBasicParsing "https://nodejs.org/dist/v9.4.0/node-v9.4.0-win-x64.zip"
RUN Expand-Archive nodejs.zip -DestinationPath C:\
RUN Rename-Item "C:\node-v9.4.0-win-x64" c:\nodejs

FROM microsoft/windowsservercore

WORKDIR C:\nodejs

COPY --from=installer C:\nodejs\ .

RUN SETX PATH C:\nodejs

WORKDIR C:\

RUN npm install @angular/cli -g 
