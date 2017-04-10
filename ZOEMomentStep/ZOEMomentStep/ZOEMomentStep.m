//
//  ZOEMomentStep.m
//  AiyoyouCocoapods
//
//  Created by aiyoyou on 2016/10/24.
//  Copyright © 2016年 zoenet. All rights reserved.
//

#import "ZOEMomentStep.h"
static CMPedometer *_pedometer;
@implementation ZOEMomentStep

//获取设备步数(开始计步)
+ (void)getMomentStepWithSucessBlock:(void (^)(CMPedometerData *))success errorBlock:(void (^)(id))failure {
    if ([ZOEMomentStep isStepCountingAvailable]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _pedometer = [[CMPedometer alloc] init];
        });
        [_pedometer startPedometerUpdatesFromDate:[ZOEMomentStep beginOfToday:[NSDate date]] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
            if (![NSThread isMainThread]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (error) {
                        if (error.code == 105) {
                            failure (@"您需要进入手机的设置中设置允许访问\"运动与健康\"");
                        }else {
                            failure(error);
                        }
                    }else {
                        success(pedometerData);
                    }
                });
            }else {
                if (error) {
                    if (error.code == 105) {
                        failure (@"您需要进入手机的设置中设置允许访问\"运动与健康\"");
                    }else {
                        failure(error);
                    }
                }else {
                    success(pedometerData);
                }
            }
        }];
    }else  {
        if (![NSThread isMainThread]) {
            if (![CMMotionActivityManager isActivityAvailable]) {
                failure (@"您需要进入手机的设置中设置允许访问\"运动与健康\"");
            }else {
                failure (@"该设备不支持计步");
            }
        }else {
            if (![CMMotionActivityManager isActivityAvailable]) {
                failure (@"您需要进入手机的设置中设置允许访问\"运动与健康\"");
            }else {
                failure (@"该设备不支持计步");
            }
        }
    }
}

//结束计步
+ (void)stopPedometerUpdates {
    if ([ZOEMomentStep isStepCountingAvailable]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _pedometer = [[CMPedometer alloc] init];
        });
        [_pedometer stopPedometerUpdates];
    }
}

//热量获取
+ (double)getKilocalorieUnit:(SexType)sexType kilometres:(NSNumber*)kilomet {
    float weight =sexType==0?66.2:57.3;
    double kcal = weight*[kilomet doubleValue]/1000.0*1.036;
    return kcal;
}

//获取一天的开始时间
+ (NSDate *)beginOfToday:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:date];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    NSTimeInterval ts = (double)(int)[[calendar dateFromComponents:components] timeIntervalSince1970];
    return [NSDate dateWithTimeIntervalSince1970:ts];
}

//检测设备是否可以计步
+ (BOOL)isStepCountingAvailable {
    if ([CMPedometer isStepCountingAvailable] && [CMMotionActivityManager isActivityAvailable]) {
        return YES;
    }else {
        return NO;
    }
}

@end
