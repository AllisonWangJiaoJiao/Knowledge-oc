//
//  YModelToolsTest.m
//  YSqliteLib
//
//  Created by Allison on 2017/9/7.
//  Copyright © 2017年 Allison. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "YModelTool.h"
#import "YModel.h"
#import "YSqliteModelTool.h"
#import "YSqliteTool.h"

@interface YModelToolsTest : XCTestCase

@end

@implementation YModelToolsTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testTvarNameType {
    
//    [YSqliteTool openDBWithUID:nil];
//   NSDictionary *dic =  [YModelTool getModelIvarNameIvarTypeDic:[YModel class]];
//    NSDictionary *dic = [YModelTool getModelIvarNameSqliteTypeDic:[YModel class]];
//    NSLog(@"%@",dic);
    
//    NSString *sql = [YModelTool columnNameAndTypesStr:[YModel class]];
//    NSLog(@"---- %@",sql);
 
    BOOL result = [YSqliteModelTool createTable:[YModel class] uid:nil];
    NSLog(@"---- %d",result);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
