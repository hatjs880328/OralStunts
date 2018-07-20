#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "WHDebugConsoleLabel.h"
#import "WHDebugCPUMemoryMonitor.h"
#import "WHDebugFPSMonitor.h"
#import "WHDebugToolManager.h"

FOUNDATION_EXPORT double WHDebugToolVersionNumber;
FOUNDATION_EXPORT const unsigned char WHDebugToolVersionString[];

