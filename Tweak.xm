#import "interfaces.h"
#import "BTTouchIDController.h"

%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)arg1 {
	%orig;
	// When SpringBoard (device) starts up (resprings/reboots/turns on), start listening so we can watch the log
	[[BTTouchIDController sharedInstance] startMonitoring];
}

%end
