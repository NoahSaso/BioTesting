#import "interfaces.h"
#import "BTTouchIDController.h"
#import <objc/runtime.h>

@implementation BTTouchIDController

+(id)sharedInstance {
	static id sharedInstance = nil;
	static dispatch_once_t token = 0;
	dispatch_once(&token, ^{
		sharedInstance = [self new];
	});
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
			log(@"Touched Finger Other Event");
			break;
	}
}

-(void)startMonitoring {
	if(isMonitoring) return;
	isMonitoring = YES;
	SBUIBiometricEventMonitor* monitor = [[objc_getClass("BiometricKit") manager] delegate];
	[monitor addObserver:self];
	previousMatchingSetting = [monitor isMatchingEnabled];
	[monitor _setMatchingEnabled:YES];
	[monitor _startMatching];
	log(@"Started monitoring");
}

-(void)stopMonitoring {
	if(!isMonitoring) return;
	isMonitoring = NO;
	SBUIBiometricEventMonitor* monitor = [[objc_getClass("BiometricKit") manager] delegate];
	[monitor removeObserver:self];
	[monitor _setMatchingEnabled:previousMatchingSetting];
	log(@"Stopped Monitoring");
}

@end
