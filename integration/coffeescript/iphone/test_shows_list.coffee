UIALogger.logMessage "Shows List"

target = UIATarget.localTarget()
app = target.frontMostApp()
window = app.mainWindow()
table = window.tableViews()[0]

if (table.cells().length > 0)
  UIALogger.logMessage(table.cells().length.toString() + " shows are displayed.")
else
  UIALogger.logError("Expected shows to be displayed.")
