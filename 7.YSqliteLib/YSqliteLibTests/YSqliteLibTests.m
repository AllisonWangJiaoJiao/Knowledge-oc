//
//  YSqliteLibTests.m
//  YSqliteLibTests
//
//  Created by Allison on 2017/9/7.
//  Copyright © 2017年 Allison. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "YSqliteTool.h"

@interface YSqliteLibTests : XCTestCase

@end

@implementation YSqliteLibTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
   
    NSString *sql = @"CREATE TABLE IF NOT EXISTS t_stu(id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL ,age integer, score real)";
   BOOL result =  [YSqliteTool dealSql:sql withUid:nil];
    XCTAssertEqual(result, YES);
    
    
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
