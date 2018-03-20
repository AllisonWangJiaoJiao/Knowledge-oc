//
//  NetRequest.h
//  TTD
//
//  Created by Yuan on 15/11/2.
//  Copyright © 2015年 EUC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^SuccessRequest) (id success);
typedef void (^FailRequest)(id fail);
typedef void (^NetStateIsNo)();

@interface NetRequest : NSObject


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
