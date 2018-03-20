//
//  HttpRequest.h
//  ZZFramework_MVC
//
//  Created by 袁亮 on 16/10/18.
//  Copyright © 2016年 Migic_Z. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^SuccessRequest) (id success);
typedef void (^FailRequest)(id fail);
typedef void (^NetStateIsNo)();

@interface HttpRequest : NSObject

#pragma mark GET请求
+(void)GETRequest:(NSString *)requestUrl
       WithParams:(NSDictionary *)params
      WithSuccess:(SuccessRequest)success
         WithFail:(FailRequest)fail
     WithNetState:(NetStateIsNo)nonet;

#pragma mark POST请求

+(void)POSTRequest:(NSString *)requestUrl
        WithParams:(NSDictionary *)params
       WithSuccess:(SuccessRequest)success
          WithFail:(FailRequest)fail
      WithNetState:(NetStateIsNo)nonet;

#pragma mark 上传图片

+(void)POSTPICRequst:(NSString *)requestUrl
          WithParams:(NSDictionary *)params
       WithImageData:(NSData *)imageData
        WithDataFile:(NSString *)dataFile
       WithImageName:(NSString *)imageName
         WithSuccess:(SuccessRequest)success
            WithFail:(FailRequest)fail
        WithNetState:(NetStateIsNo)nonet;
#pragma mark 多图上传
+(void)UploadPicSRequst:(NSString *)requestUrl
             WithParams:(NSDictionary *)params
             WithImages:(NSArray *)images
            WithSuccess:(SuccessRequest)success
               WithFail:(FailRequest)fail
           WithNetState:(NetStateIsNo)nonet;

@end
