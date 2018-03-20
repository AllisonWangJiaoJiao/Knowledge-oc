//
//  SocketManager.m
//  SocketDemo
//
//  Created by Allison on 2018/3/13.
//  Copyright © 2018年 ChongqingWirelessOasisCommunicationTechnology. All rights reserved.
//

#import "SocketManager.h"
#import "GCDAsyncSocket.h" // for TCP


static  NSString * Khost = @"192.168.0.107";
static const uint16_t Kport = 8090;


@interface SocketManager()<GCDAsyncSocketDelegate>
{
    GCDAsyncSocket *gcdSocket;
}

// 心跳计时器
@property (nonatomic, strong) NSTimer *connectTimer;
@end

@implementation SocketManager

+ (instancetype)share
{
    static dispatch_once_t onceToken;
    static SocketManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
        [instance initSocket];
    });
    return instance;
}

- (void)initSocket
{
    gcdSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
}
// 添加定时器
- (void)addTimer
{
    // 长连接定时器
    self.connectTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(longConnectToSocket) userInfo:nil repeats:YES];
    // 把定时器添加到当前运行循环,并且调为通用模式
    [[NSRunLoop currentRunLoop] addTimer:self.connectTimer forMode:NSRunLoopCommonModes];
}

// 心跳连接
- (void)longConnectToSocket
{
    // 发送固定格式的数据
    NSString *longConnect = @"bengbeng";
    
    NSData  *data = [longConnect dataUsingEncoding:NSUTF8StringEncoding];
    
    [gcdSocket writeData:data withTimeout:- 1 tag:0];
}

#pragma mark - 对外的一些接口

//建立连接
- (BOOL)connect
{
    return  [gcdSocket connectToHost:Khost onPort:Kport error:nil];
    //    return [gcdSocket connectToUrl:[NSURL fileURLWithPath:@"/Users/tuyaohui/IPCTest"] withTimeout:-1 error:nil];
}

//断开连接
- (void)disConnect
{
    [gcdSocket disconnect];
}

//字典转为Json字符串
- (NSString *)dictionaryToJson:(NSDictionary *)dic
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}



//发送消息
- (void)sendMessage:(NSString *)message
{
    NSDictionary *model = @{@"userName":@"翀鹰女孩",@"userAge":@18,@"realData":message};

    NSData *data = [NSJSONSerialization dataWithJSONObject:model options:NSJSONWritingPrettyPrinted error:nil];
//    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"test" ofType:@"jpg"];
//    NSData *data = [NSData dataWithContentsOfFile:filePath];

//    UInt8 star[2];
//    star[0] = 0x7e;
//    star[1] = 0xa5;

    UInt8 end[2];
    end[0] = 0x7e;
    end[1] = 0x0d;

    NSMutableData *multiData = [[NSMutableData alloc] init];
//    [multiData appendBytes:&star length:2];
    [multiData appendData:data];
    [multiData appendBytes:&end length:2];

//    for (int i=0; i<multiData.length; i+=16) {
//        if (i+16 < [multiData length]){
//            //1.拆包
//            NSMutableData *aData = [[NSMutableData alloc] init];
//            NSString *rangeStr =  [NSString stringWithFormat:@"%i,%i",i,18];
//            NSData *subData = [multiData subdataWithRange:NSRangeFromString(rangeStr)];
//            [aData appendData:subData];
//            //2.调用发送数据的方法
//        }
//    }


    
    [gcdSocket writeData:multiData withTimeout:-1 tag:110];
    
//    NSData *data  = [@"你好" dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *data1  = [@"猪头" dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *data2  = [@"先生" dataUsingEncoding:NSUTF8StringEncoding];
//
//
//    NSData *data3  = [@"今天天气好" dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *data4  = [@"吃饭了吗" dataUsingEncoding:NSUTF8StringEncoding];
//
//    [self sendData:data :@"txt"];
//    [self sendData:data1 :@"txt"];
//    [self sendData:data2 :@"txt"];
//    [self sendData:data3 :@"txt"];
//    [self sendData:data4 :@"txt"];
    
    //    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"test1" ofType:@"jpg"];
    //
    //    NSData *data5 = [NSData dataWithContentsOfFile:filePath];
    //
    //    [self sendData:data5 :@"img"];
}

- (void)sendData:(NSData *)data :(NSString *)type
{
    NSUInteger size = data.length;
    
    NSMutableDictionary *headDic = [NSMutableDictionary dictionary];
    [headDic setObject:type forKey:@"type"];
    [headDic setObject:[NSString stringWithFormat:@"%ld",size] forKey:@"size"];
    NSString *jsonStr = [self dictionaryToJson:headDic];
    
    
    NSData *lengthData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSMutableData *mData = [NSMutableData dataWithData:lengthData];
    //分界
    [mData appendData:[GCDAsyncSocket CRLFData]];
    
    [mData appendData:data];
    
    
    //第二个参数，请求超时时间
    [gcdSocket writeData:mData withTimeout:-1 tag:110];
    
}

//监听最新的消息
- (void)pullTheMessage
{
    //貌似是分段读数据的方法
    //    [gcdSocket readDataToData:[GCDAsyncSocket CRLFData] withTimeout:10 maxLength:50000 tag:110];
    
    //监听读数据的代理，只能监听10秒，10秒过后调用代理方法  -1永远监听，不超时，但是只收一次消息，
    //所以每次接受到消息还得调用一次
    [gcdSocket readDataWithTimeout:-1 tag:110];
    
}

//用Pingpong机制来看是否有反馈
- (void)checkPingPong
{
    //pingpong设置为3秒，如果3秒内没得到反馈就会自动断开连接
    [gcdSocket readDataWithTimeout:3 tag:110];
    
}



#pragma mark - GCDAsyncSocketDelegate
//连接成功调用
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"连接成功,host:%@,port:%d",host,port);
    
    [self pullTheMessage];
    
//    [sock startTLS:nil];
    
    //心跳
//    [self addTimer];
}

//断开连接的时候调用
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(nullable NSError *)err
{
    NSLog(@"断开连接,host:%@,port:%d",sock.localHost,sock.localPort);
    
    //断线重连写在这...
    
}

//写的回调
- (void)socket:(GCDAsyncSocket*)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"写的回调,tag:%ld",tag);
    //判断是否成功发送，如果没收到响应，则说明连接断了，则想办法重连
    [self pullTheMessage];
}


- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    if (self.backBlock) {
        self.backBlock(data);
    }
    
    NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"收到消息：%@",msg);
    
    [self pullTheMessage];
}

//Unix domain socket
//- (void)socket:(GCDAsyncSocket *)sock didConnectToUrl:(NSURL *)url
//{
//    NSLog(@"connect:%@",[url absoluteString]);
//}

//    //看能不能读到这条消息发送成功的回调消息，如果2秒内没收到，则断开连接
//    [gcdSocket readDataToData:[GCDAsyncSocket CRLFData] withTimeout:2 maxLength:50000 tag:110];

//貌似触发点
- (void)socket:(GCDAsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag
{
    
    NSLog(@"读的回调,length:%ld,tag:%ld",partialLength,tag);
    
}


//为上一次设置的读取数据代理续时 (如果设置超时为-1，则永远不会调用到)
//-(NSTimeInterval)socket:(GCDAsyncSocket *)sock shouldTimeoutReadWithTag:(long)tag elapsed:(NSTimeInterval)elapsed bytesDone:(NSUInteger)length
//{
//    NSLog(@"来延时，tag:%ld,elapsed:%f,length:%ld",tag,elapsed,length);
//    return 10;
//}


@end
