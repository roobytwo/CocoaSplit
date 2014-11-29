//
//  CAMultiAudioPCMPlayer.h
//  CocoaSplit
//
//  Created by Zakk on 11/14/14.
//  Copyright (c) 2014 Zakk. All rights reserved.
//

#import <CoreMedia/CoreMedia.h>

#import "CAMultiAudioNode.h"
#import "CAMultiAudioPCM.h"

@interface CAMultiAudioPCMPlayer : CAMultiAudioNode
{
    NSMutableArray *_pendingBuffers;
    dispatch_queue_t _pendingQueue;
    
}

@property (strong) NSString *inputUID;
@property (weak) id converterNode;
@property (assign) Float64 latestScheduledTime;

-(void)releasePCM:(CAMultiAudioPCM *)buffer;
-(void)scheduleBuffer:(CMSampleBufferRef)sampleBuffer;
-(void)scheduleAudioBuffer:(AudioBufferList *)bufferList bufferFormat:(AudioStreamBasicDescription)bufferFormat;
-(bool)playPcmBuffer:(CAMultiAudioPCM *)pcmBuffer;


-(void)play;




@end
