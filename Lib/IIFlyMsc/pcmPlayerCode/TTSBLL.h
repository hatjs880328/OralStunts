//
//  TTSUIController.h
//  MSCDemo_UI
//
//  Created by wangdan on 15-4-25.
//  Copyright (c) 2015年 iflytek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "PcmPlayer.h"

/*
 demo of Text-to-Speech (TTS)
 
 Text-to-Speech has two work modes:
 1.Normal TTS: Playing While synthesizing;
 2.URI TTS   : Not Playing While synthesizing;
 */
@interface TTSBLL : NSObject




@property (nonatomic, strong) NSString *uriPath;
@property (nonatomic, strong) PcmPlayer *audioPlayer;


/**
 调用这个吊方法的时候，当前类的实例必须是成员变量！SB也不给一个注释
 */
- (void)getPathNoah;

@end
