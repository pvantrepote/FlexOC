//
//  FailedInstanceService.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-17.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "FailedInstanceService.h"

@implementation FailedInstanceService

-(NSString *)stringFromContext {
	@throw [NSException exceptionWithName:@"FailedInstanceService" reason:@"stringFromContext" userInfo:nil];
}

-(NSNumber *)valueFromContext {
	@throw [NSException exceptionWithName:@"FailedInstanceService" reason:@"valueFromContext" userInfo:nil];
}

@end
