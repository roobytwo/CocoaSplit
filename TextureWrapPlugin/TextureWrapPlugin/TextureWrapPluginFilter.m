//
//  TextureWrapPluginFilter.m
//  TextureWrapPlugin
//
//  Created by Zakk on 8/2/14.
//  Copyright (c) 2014 Zakk. All rights reserved.
//

#import "TextureWrapPluginFilter.h"
#import <Foundation/Foundation.h>
#import <ApplicationServices/ApplicationServices.h>

@implementation TextureWrapPluginFilter

static CIKernel *_TextureWrapPluginFilterKernel = nil;

- (id)init
{
    if(!_TextureWrapPluginFilterKernel) {
        
		NSBundle    *bundle = [NSBundle bundleForClass:NSClassFromString(@"TextureWrapPluginFilter")];
		NSStringEncoding encoding = NSUTF8StringEncoding;
		NSError     *error = nil;
		NSString    *code = [NSString stringWithContentsOfFile:[bundle pathForResource:@"TextureWrapPluginFilterKernel" ofType:@"cikernel"] encoding:encoding error:&error];
		NSArray     *kernels = [CIKernel kernelsWithString:code];

		_TextureWrapPluginFilterKernel = kernels[0];
    }
    return [super init];
}







- (NSDictionary *)customAttributes
{
    return @{
        @"inputOffset":@{
            kCIAttributeDefault:@0.00,
            kCIAttributeType:kCIAttributeTypeScalar,
        },
    };
}

// called when setting up for fragment program and also calls fragment program
- (CIImage *)outputImage
{
    CISampler *src;
    
    
    src = [CISampler samplerWithImage:inputImage keysAndValues:kCISamplerWrapMode, kCISamplerWrapBlack, nil];
    
    return [self apply:_TextureWrapPluginFilterKernel, src,
            inputOffset,kCIApplyOptionDefinition, [src definition], nil];
}

@end