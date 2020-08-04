//
//  SMCloudServices.h
//  SMCloudServices
//
//  Created by Yuji on 2015/**/**.
//  Copyright (c) 2015年 Star Micronics. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMCloudServices : NSObject

+ (NSString *)description;

+ (void)showRegistrationView:(void (^)(BOOL isRegistered))completion;

+ (BOOL)isRegistered;

@end
