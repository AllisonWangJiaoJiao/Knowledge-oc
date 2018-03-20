//
//  NetState.h
//  TTD
//
//  Created by Yuan on 15/12/8.
//  Copyright © 2015年 EUC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetState : NSObject

/***
 *   检验网络状态，是否连接网络，调用此方法即可返回BOOL类型来判断
 ***/
+(BOOL)IsConnectToNet;

@end
