//
//  NSString+Utils.m
//  Address Search
//
//  Created by Staff on 3/31/15.
//  Copyright (c) 2015 Hoat Ha Van. All rights reserved.
//

#import "NSString+Utils.h"


@import UIKit;
@import MobileCoreServices;
@implementation NSString (Utils)
+(BOOL)isEmptyString:(NSString*)string{

    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSString class]]) {
        
        string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([string isEqualToString:@"<null>"] ||[string isEqualToString:@"(null)"] || [string isEqualToString:@""]) {
            return YES;
        }
        
        if (string.length > 0) {
            return NO;
        }
    }
    
    if (!string) {
        return YES;
    }
    
    return NO;
}

@end
