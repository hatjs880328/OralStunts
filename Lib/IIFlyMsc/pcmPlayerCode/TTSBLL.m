//
//  TTSUIController.m
//  MSCDemo_UI
//
//  Created by wangdan on 15-4-25.
//  Copyright (c) 2015年 iflytek. All rights reserved.
//

#import "TTSBLL.h"
#import <QuartzCore/QuartzCore.h>



@implementation TTSBLL

- (void)getPathNoah
{
    NSString *prePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    _uriPath = [NSString stringWithFormat:@"%@/%@",prePath,@"iat.pcm"];
    _audioPlayer = [[PcmPlayer alloc] init];
    _audioPlayer = [[PcmPlayer alloc] initWithFilePath:_uriPath sampleRate:16000];
    [_audioPlayer play];
}

@end
