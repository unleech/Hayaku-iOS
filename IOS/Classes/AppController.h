#import <UIKit/UIKit.h>
#import "FacebookManager.h"

@interface AppController : NSObject<UIAccelerometerDelegate, UIApplicationDelegate>
{
}
@property (nonatomic, readonly)__strong FacebookManager *fbManager;

- (void) startUnity:(UIApplication*)application;
- (void) startRendering;
- (void) Repaint;
- (void) RepaintDisplayLink;
- (void) prepareRunLoop;
@end

#define NSTIMER_BASED_LOOP 0
#define THREAD_BASED_LOOP 1
#define EVENT_PUMP_BASED_LOOP 2
