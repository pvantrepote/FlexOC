//
//  TruePointcut.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-05.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "TruePointcut.h"

@implementation TruePointcut

-(BOOL) matchesSelector:(NSString*) selector forInvocation:(NSInvocation*) invocation{
	return YES;
}

@end
