//
//  Debug.h
//  ZZBase
//
//  Created by 袁亮 on 16/7/7.
//  Copyright © 2016年 Migic_Z. All rights reserved.
//

#ifndef Debug_h
#define Debug_h


#define SESSIONDEBUG @"SESSION DEBUG => session request fail ,info "
#define SESSIONSUCCESSFAIL @"session success=false"

#define SESSIONINFO [NSString stringWithFormat:@"%@%@ message %@",SESSIONDEBUG,@"服务器内服处理错误",SESSIONSUCCESSFAIL]

#define SESSIONCONNECT @"session connect fail"


#define REQUESTDEBUG @"REQUST DEBUG => http request fail, info"
#define REQUESTSUCCESSFAIL @"request successful=false"
#define REQUESTINFO [NSString stringWithFormat:@"%@%@ message %@",REQUESTDEBUG,@"服务器内服处理错误",REQUESTSUCCESSFAIL]

#define REQUESTCONNECT @"session connect fail,服务器链接失败,可能是老乔那里连接不上了,链接失败信息:"

#endif /* Debug_h */
