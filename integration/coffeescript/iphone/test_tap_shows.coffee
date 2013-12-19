UIALogger.logMessage "Tap Show"

target = UIATarget.localTarget()
app = target.frontMostApp()
window = app.mainWindow()
table = window.tableViews()[0]
firstShow = table.cells()[0]

UIALogger.logMessage "Tapping " + firstShow.name()
firstShow.tap()

app.navigationBar().leftButton().tap()
