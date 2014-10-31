#import "interfaces.h"

#define TouchIDFingerDown  1
#define TouchIDFingerUp    0
#define TouchIDFingerHeld  2
#define TouchIDMatched     3
#define TouchIDNotMatched  10

@interface BTTouchIDController : NSObject <SBUIBiometricEventMonitorDelegate> {
	BOOL isMonitoring;
	BOOL previousMatchingSetting;
}
+(id)sharedInstance;
-(void)startMonitoring;
-(void)stopMonitoring;
@end
