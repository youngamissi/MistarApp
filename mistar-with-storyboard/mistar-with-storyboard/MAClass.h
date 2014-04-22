//
//  MAClass.h
//  MistarApp
//
//  Created by Andrew Breckenridge on 3/25/14.
//  Copyright (c) 2014 Andrew Breckenridge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAAssignment.h"
#import "MATeacher.h"

@interface MAClass : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *grade;
@property (nonatomic, strong) NSNumber *percentage;
@property (nonatomic, strong) NSMutableArray *assignments;
@property (nonatomic, strong) MATeacher *teacher;

- (id)initWithName:(NSString *)name grade:(NSString *)grade percentage:(NSNumber *)percentage assignments:(NSMutableArray *)assignments teacher:(MATeacher *)teacher;

@end