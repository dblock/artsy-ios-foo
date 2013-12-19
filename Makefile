WORKSPACE = Foo.xcworkspace
CONFIGURATION = Debug
SCHEME = Foo

build:
	xctool -workspace $(WORKSPACE) -scheme $(SCHEME) -configuration $(CONFIGURATION) build

clean:
	xctool -workspace $(WORKSPACE) -scheme $(SCHEME) -configuration $(CONFIGURATION) clean

test:
	xctool -workspace $(WORKSPACE) -scheme $(SCHEME) -configuration $(CONFIGURATION) test -sdk iphonesimulator

pods:
	pod install

all: clean build test
