//
//  SMNetworkManager.h
//  StarIODeviceSetting
//

#import <Foundation/Foundation.h>
#import <StarIODeviceSetting/Internal/SMNetworkSetting.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMNetworkManager : NSObject

- (instancetype)init __attribute__((unavailable("init is not available")));

+ (instancetype)new __attribute__((unavailable("new is not available")));

- (nullable instancetype)initWithPortName:(nonnull NSString *)portName;

- (BOOL)applyNetworkSetting:(SMNetworkSetting *)networkSetting
                      error:(NSError *__autoreleasing _Nullable * _Nullable)error;

- (nullable SMNetworkSetting *)loadWithError:(NSError *__autoreleasing _Nullable * _Nullable)error;

@end

NS_ASSUME_NONNULL_END
