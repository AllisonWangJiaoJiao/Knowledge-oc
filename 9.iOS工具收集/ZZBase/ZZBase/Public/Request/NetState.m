//
//  NetState.m
//  TTD
//
//  Created by Yuan on 15/12/8.
//  Copyright © 2015年 EUC. All rights reserved.
//

#import "NetState.h"
#import <netdb.h>
@interface NetState()


@end

@implementation NetState

+(BOOL)IsConnectToNet
{
    //创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
    struct sockaddr_in zeroAddress;
    
    bzero(&zeroAddress, sizeof(zeroAddress));
    
    zeroAddress.sin_len = sizeof(zeroAddress);
    
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    
    SCNetworkReachabilityFlags flags;
    
    //获得连接的标志
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    
    CFRelease(defaultRouteReachability);
    //如果不能获取连接标志，则不能连接网络，直接返回
    if (!didRetrieveFlags)
    {
        return NO;
    }
    //根据获得的连接标志进行判断
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    
    return (isReachable && !needsConnection) ? YES : NO;
}

@end
