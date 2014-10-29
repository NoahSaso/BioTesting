#import "interfaces.h"
#import "BTTouchIDController.h"

static BTTouchIDController* controller;

%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)arg1 {
	%orig;
	if(!controller)
		controller = [[BTTouchIDController alloc] init];
	[controller startMonitoring];
}

%end
