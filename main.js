const { app, BrowserWindow, session } = require('electron');

let mainWindow;

function createWindow() {
    mainWindow = new BrowserWindow({
        width: 1000,
        height: 800,
        webPreferences: {
            nodeIntegration: false
        }
    });

    // Set Chromium User-Agent
    const userAgent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36";
    mainWindow.webContents.session.webRequest.onBeforeSendHeaders((details, callback) => {
        details.requestHeaders['User-Agent'] = userAgent;
        callback({ cancel: false, requestHeaders: details.requestHeaders });
    });

    mainWindow.loadURL('https://web.whatsapp.com');
}

app.whenReady().then(createWindow);
