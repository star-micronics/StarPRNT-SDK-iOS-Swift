//
//  SMFileLogger.h
//  StarIOPort
//
//  Created by u3415 on 2018/09/14.
//

#ifdef TARGET_OS_IPHONE
  #ifdef BUILDING_STARIO
    #import "SMLogger.h"
  #else
    #import <StarIO/SMLogger.h>
  #endif
#endif

@interface SMFileLogger : SMLogger

@property(class, nonatomic, readonly, nonnull) SMFileLogger *sharedInstance NS_SWIFT_NAME(shared);

@property(nonatomic) NSUInteger maxLogSize;

@property(nonatomic, readonly, nonnull) NSString *logDirectoryPath;

@end
