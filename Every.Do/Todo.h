//
//  Todo.h
//  Every.Do
//
//  Created by carmen cheng on 2016-11-15.
//  Copyright © 2016 carmen cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Todo : NSObject
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *todoDescription;
@property (nonatomic) int priorityNumber;
@property (nonatomic) BOOL isCompleted;
@end
