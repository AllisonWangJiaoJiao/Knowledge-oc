//
//  HttpRequest.m
//  ZZFramework_MVC
//
//  Created by 袁亮 on 16/10/18.
//  Copyright © 2016年 Migic_Z. All rights reserved.
//

#import "HttpRequest.h"
#import <netdb.h>

@implementation HttpRequest

+(void)GETRequest:(NSString *)requestUrl
       WithParams:(NSDictionary *)params
      WithSuccess:(SuccessRequest)success
         WithFail:(FailRequest)fail
     WithNetState:(NetStateIsNo)nonet
{
    if ([self IsConnectToNet] == YES) {
        // 1.获得请求管理者
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        
        //防止报错 code = -1016
        session.responseSerializer.acceptableContentTypes = \
        [session.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        // 2.发送GET请求
        
        
        [session GET:requestUrl parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject){
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error){
            if (fail) {
                fail(error);
            }
        }];
        
        
    }else{
        if (nonet) {
            nonet();
        }
    }
    
}

+(void)POSTRequest:(NSString *)requestUrl
        WithParams:(NSDictionary *)params
       WithSuccess:(SuccessRequest)success
          WithFail:(FailRequest)fail
      WithNetState:(NetStateIsNo)nonet
{
    if ([self IsConnectToNet] == YES) {
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        
        //防止报错code = -1016
        session.responseSerializer.acceptableContentTypes = \
        [session.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        
        [session POST:requestUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (fail) {
                fail(error);
            }
        }];
    }else{
        if (nonet) {
            nonet();
        }
    }
    
}

+(void)POSTPICRequst:(NSString *)requestUrl
          WithParams:(NSDictionary *)params
       WithImageData:(NSData *)imageData
        WithDataFile:(NSString *)dataFile
       WithImageName:(NSString *)imageName
         WithSuccess:(SuccessRequest)success
            WithFail:(FailRequest)fail
        WithNetState:(NetStateIsNo)nonet
{
    if ([self IsConnectToNet] == YES) {
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        
        session.responseSerializer.acceptableContentTypes = \
        [session.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        [session POST:requestUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData){
            
            [formData appendPartWithFileData:imageData name:dataFile fileName:[NSString stringWithFormat:@"%@.jpg",imageName] mimeType:@"image/jpeg"];
            
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject){
            if (success) {
                success(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
            if (fail) {
                fail(error);
            }
        }];
    }else{
        if (nonet) {
            nonet();
        }
    }
    
}

+(void)UploadPicSRequst:(NSString *)requestUrl
             WithParams:(NSDictionary *)params
             WithImages:(NSArray *)images
            WithSuccess:(SuccessRequest)success
               WithFail:(FailRequest)fail
           WithNetState:(NetStateIsNo)nonet
{
    if ([self IsConnectToNet] == YES) {
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        
        session.responseSerializer.acceptableContentTypes = \
        [session.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        [session POST:requestUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData){
            
            for (int i = 0; i < images.count; i++) {
                
                NSData *imageData = UIImageJPEGRepresentation((UIImage *)[images objectAtIndex:i], 0.75);
                
                [formData appendPartWithFileData :imageData name:[NSString stringWithFormat:@"file%d",i] fileName:[NSString stringWithFormat:@"pic%d.jpg",i] mimeType:@"image/jpeg"];
            }
            
            
            
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject){
            if (success) {
                success(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
            if (fail) {
                fail(error);
            }
        }];
    }else{
        if (nonet) {
            nonet();
        }
    }
    
}

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
