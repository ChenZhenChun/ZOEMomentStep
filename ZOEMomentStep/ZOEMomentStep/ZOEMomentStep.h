//
//  ZOEMomentStep.h
//  AiyoyouCocoapods
//
//  Created by aiyoyou on 2016/10/24.
//  Copyright © 2016年 zoenet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import <UIKit/UIDevice.h>

/**
 ps:The app's Info.plist must contain an NSMotionUsageDescription key with a string value explaining to the user how the app uses this data.
 描述：需要在Info.pllist文件中配置授权信息 key=@"NSMotionUsageDescription" value =@"App需要您的同意,才能访问运动与健身"
 */

typedef enum : NSUInteger {
    SexTypeMen,//男
    SexTypeWomen,//女
} SexType;

@interface ZOEMomentStep : NSObject

/**
 获取行走的步数

 @param success 成功block回调
 @param failure 失败block回调
 */
+ (void)getMomentStepWithSucessBlock:(void(^)(CMPedometerData *data))success errorBlock:(void(^)(id error))failure;

/**
 热量计算（单位千卡）

 @param sexType 性别
 @param kilomet 距离 单位米
 @return xxx千卡
 */
+ (double)getKilocalorieUnit:(SexType)sexType kilometres:(NSNumber*)kilomet;

@end
