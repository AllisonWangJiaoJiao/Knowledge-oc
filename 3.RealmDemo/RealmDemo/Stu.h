//
//  Stu.h
//  RealmDemo
//
//  Created by Allison on 2017/8/20.
//  Copyright © 2017年 Allison. All rights reserved.
//

#import <Realm/Realm.h>

@interface Stu : RLMObject
@property int num;
@property NSString *name;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<Stu *><Stu>
RLM_ARRAY_TYPE(Stu)
