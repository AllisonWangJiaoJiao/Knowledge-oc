//
//  NetRequest.m
//  TTD
//
//  Created by Yuan on 15/11/2.
//  Copyright © 2015年 EUC. All rights reserved.
//

#import "NetRequest.h"
#import "NetState.h"
@implementation NetRequest


+(void)GETRequest:(NSString *)requestUrl
       WithParams:(NSDictionary *)params
      WithSuccess:(SuccessRequest)success
         WithFail:(FailRequest)fail
     WithNetState:(NetStateIsNo)nonet
{
    if ([NetState IsConnectToNet] == YES) {
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
    if ([NetState IsConnectToNet] == YES) {
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
    if ([NetState IsConnectToNet] == YES) {
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        
        session.responseSerializer.acceptableContentTypes = \
        [session.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];

        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestUrl]];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"image/jpeg" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
        [request setValue:@"UTF-8" forHTTPHeaderField:@"Charsert"];
        [request setValue:@"driving.jpg" forHTTPHeaderField:@"uploadFileName"];
        [request setHTTPBody:imageData];
        [[session dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            
            if (!error) {
                
                NSLog(@"Reply JSON: %@", responseObject);
                
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    
                    //处理你的数据
                    
                }
                
            } else {
                
                NSLog(@"Error: %@, %@, %@", error, response, responseObject);
                
            }
            
        }] resume];
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
    if ([NetState IsConnectToNet] == YES) {
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


@end
