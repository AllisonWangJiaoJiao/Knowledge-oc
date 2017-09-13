//
//  YModel.h
//  YSqliteLib
//
//  Created by Allison on 2017/9/7.
//  Copyright © 2017年 Allison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YModelProtocol.h"

//@class Getstation;
@interface YModel : NSObject <YModelProtocol>

@property (nonatomic,copy)NSString *name;
@property (nonatomic,assign)int stuNum;
@property (nonatomic,assign)int age2;
@property (nonatomic,assign)float score;
//@property (nonatomic,assign)float score2;


//@property (nonatomic, strong) Getstation *getstation;

@end


//@interface Getstation : NSObject
//
//@property (nonatomic, assign) NSInteger pilenum;
//@property (nonatomic, assign) NSInteger vehiclenum;
//@property (nonatomic, assign) NSString * latitude;
//@property (nonatomic, assign) NSString *  longtitude;
//
//@end
