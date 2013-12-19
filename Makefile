WORKSPACE = Foo.xcworkspace
CONFIGURATION = Debug
SCHEME = Foo

.PHONY: build clean test pods gems all

all: gems pods clean build test

build:
	xctool -workspace $(WORKSPACE) -scheme $(SCHEME) -configuration $(CONFIGURATION) build

clean:
	xctool -workspace $(WORKSPACE) -scheme $(SCHEME) -configuration $(CONFIGURATION) clean

test:
	xctool -workspace $(WORKSPACE) -scheme $(SCHEME) -configuration $(CONFIGURATION) test -sdk iphonesimulator
	bwoken test

pods:
	pod install

gems:
	bundle install

