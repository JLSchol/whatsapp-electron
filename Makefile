APP_NAME = whatsapp-electron
INSTALL_PATH = /opt/whatsapp
EXECUTABLE = whatsapp
DESKTOP_FILE = ~/.local/share/applications/whatsapp.desktop

build:
	@echo "Installing dependencies..."
	npm install
	@echo "Building the Electron app..."
	npx electron-packager . $(APP_NAME) --platform=linux --arch=x64 --overwrite
	@echo "Build complete!"

install:
	@echo "Moving app to $(INSTALL_PATH)..."
	sudo mv $(APP_NAME)-linux-x64 $(INSTALL_PATH)
	sudo ln -sf $(INSTALL_PATH)/$(EXECUTABLE) /usr/bin/$(EXECUTABLE)

	@echo "Installing desktop entry..."
	cp whatsapp_desktop_app/whatsapp.desktop $(DESKTOP_FILE)
	cp whatsapp_desktop_app/icon.png $(INSTALL_PATH)/resources/app/

	@echo "Updating application database..."
	update-desktop-database ~/.local/share/applications/

	@echo "Installation complete! You can now launch WhatsApp from the menu or by running 'whatsapp'."

clean:
	@echo "Cleaning build files..."
	rm -rf node_modules
	rm -rf whatsapp-linux-x64
	rm -f $(DESKTOP_FILE)
	@echo "Cleanup complete!"