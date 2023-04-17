//
//  SMNetworkSetting.h
//  StarIODeviceSetting
//

#import <Foundation/Foundation.h>
#import <StarIODeviceSetting/Internal/SMSteadyLANSetting.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMNetworkSetting : NSObject

@property(nonatomic) SMSteadyLANSetting steadyLAN;

@end

NS_ASSUME_NONNULL_END
