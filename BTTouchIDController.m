#import "interfaces.h"
#import "BTTouchIDController.h"
#import <objc/runtime.h>

@implementation BTTouchIDController

+(id)sharedInstance {
	// Setup instance for current class once
	static id sharedInstance = nil;
	static dispatch_once_t token = 0;
	dispatch_once(&token, ^{
		sharedInstance = [self new];
	});
	// Provide instance
	return sharedInstance;
}

-(void)biometricEventMonitor:(id)monitor handleBiometricEvent:(unsigned)event {
	switch(event) {
		case TouchIDFingerDown:
			log(@"Touched Finger Down");
			break;
		case TouchIDFingerUp:
			log(@"Touched Finger Up");
			break;
		case TouchIDFingerHeld:
			log(@"Touched Finger Held");
			break;
		case TouchIDMatched:
			log(@"Touched Finger Matched");
			break;
		case TouchIDNotMatched:
			log(@"Touched Finger Not Matched");
			break;
		default:
			//log(@"Touched Finger Other Event"); // Unneeded and annoying
			break;
	}
}

-(void)startMonitoring {
	// If already monitoring, don't start again
	if(isMonitoring) {
		return;
	}
	isMonitoring = YES;

	// Get current monitor instance so observer can be added
	SBUIBiometricEventMonitor* monitor = [[objc_getClass("BiometricKit") manager] delegate];
	// Save current device matching state
	previousMatchingSetting = [monitor isMatchingEnabled];

	// Begin listening :D
	[monitor addObserver:self];
	[monitor _setMatchingEnabled:YES];
	[monitor _startMatching];

	log(@"Started monitoring");
}

-(void)stopMonitoring {
	// If already stopped, don't stop again
	if(!isMonitoring) {
		return;
	}
	isMonitoring = NO;

	// Get current monitor instance so observer can be removed
	SBUIBiometricEventMonitor* monitor = [[objc_getClass("BiometricKit") manager] delegate];
	
	// Stop listening
	[monitor removeObserver:self];
	[monitor _setMatchingEnabled:previousMatchingSetting];

	log(@"Stopped Monitoring");
}

@end
