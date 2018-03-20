//
//  SocketManager.h
//  SocketDemo
//
//  Created by Allison on 2018/3/13.
//  Copyright © 2018年 ChongqingWirelessOasisCommunicationTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SocketManager : NSObject

typedef void (^SocketDataBackBlock)(NSData *data);

/// 工具单例
+ (instancetype)share;
/// 获取到返回数据回调
@property (nonatomic,copy) SocketDataBackBlock backBlock;
/// 开始连接
- (BOOL)connect;
/// 断开连接
- (void)disConnect;
/// 发送数据
- (void)sendMessage:(NSString *)Message;

@end
