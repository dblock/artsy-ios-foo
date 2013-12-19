WORKSPACE = Foo.xcworkspace
CONFIGURATION = Debug
SCHEME = Foo

.PHONY: build clean test pods all

all: pods clean build test

build:
	xctool -workspace $(WORKSPACE) -scheme $(SCHEME) -configuration $(CONFIGURATION) build

clean:
	xctool -workspace $(WORKSPACE) -scheme $(SCHEME) -configuration $(CONFIGURATION) clean

test:
	xctool -workspace $(WORKSPACE) -scheme $(SCHEME) -configuration $(CONFIGURATION) test -sdk iphonesimulator

pods:
	pod install

