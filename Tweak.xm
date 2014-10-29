#import "interfaces.h"
#import "BTTouchIDController.h"

%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)arg1 {
	%orig;
	[[BTTouchIDController sharedInstance] startMonitoring];
}

%end
