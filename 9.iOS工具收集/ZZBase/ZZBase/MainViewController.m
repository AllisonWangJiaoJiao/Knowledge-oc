//
//  MainViewController.m
//  TTD
//
//  Created by Yuan on 15/11/2.
//  Copyright © 2015年 EUC. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"
#import "NetRequest.h"
#import "Debug.h"
@interface MainViewController ()


@end

@implementation MainViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //主入口文件，包含主界面中的Navigation、Tabbar。
        
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
   

    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    session.responseSerializer.acceptableContentTypes = \
    [session.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.pand-auto.com/appClientUploadServlet"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"image/jpeg" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
    [request setValue:@"UTF-8" forHTTPHeaderField:@"Charsert"];
    [request setValue:@"driving.jpg" forHTTPHeaderField:@"uploadFileName"];
    
    UIImage * image = [[self class] imageWithImage:[UIImage imageNamed:@"migic.jpg"] scaledToSize:CGSizeMake(300, 300)];
    NSData *data = UIImageJPEGRepresentation(image, 1);
    
    [request setHTTPBody:data];

    
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

}

+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}



-(void) downPicture
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.view addSubview:imageView];
    
    //异步加载图片
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData * data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:@"http://m.xxxiao.com/wp-content/uploads/sites/3/2015/06/m.xxxiao.com_4f5d4bcd03ee2ef0c60bfc0e17a00ea6-760x500.jpg"]];
        UIImage *image = [[UIImage alloc]initWithData:data];
        NSLog(@"下载中");
        if (data != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                imageView.image = image;
                NSLog(@"下载完成");
            });
        }
    });
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
