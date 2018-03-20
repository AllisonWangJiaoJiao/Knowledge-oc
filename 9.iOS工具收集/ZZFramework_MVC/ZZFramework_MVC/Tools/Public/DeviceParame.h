//
//  DeviceParame.h
//  ZZFramework_MVC
//
//  Created by 袁亮 on 16/10/18.
//  Copyright © 2016年 Migic_Z. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceParame : NSObject

/**
 *  @author shimly
 *
 *  获取设备UUID
 *
 */
+(NSString*) getDeviceUUID;
/**
 *  @author shimly
 *
 *  保存UUID 到 keychain
 */
+(void) saveDeviceUUID;
/**
 *  @author shimly
 *
 *  获取App版本号
 *
 */
+(NSString*) getAppVersion;
/**
 *  @author shimly
 *
 *  获取AppBuild版本号
 *
 */
+(NSString*) getAppBuildVersion;
/**
 *  @author shimly
 *
 *  获取系统设备号
 *
 */
+(NSString*) getDeviceVersion;
/**
 *  @author shimly
 *
 *  获取系统设备名称  iphone6s iphone5 ......
 *
 */
+(NSString*) getDeviceModelName;

@end
