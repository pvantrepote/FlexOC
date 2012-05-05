//
//  TestAfterBeforAdvisor.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-05.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "TestAfterBeforAdvisor.h"

@implementation TestAfterBeforAdvisor

@synthesize didAfter, didBefore, pointcut, advice;

-(id<IAdvice>)advice {
	return self;
}

-(void)beforeInvocation:(NSInvocation *)invocation withTarget:(id)target {
	didBefore = YES;
}

-(void)afterInvocation:(NSInvocation *)invocation withTarget:(id)target {
	didAfter = YES;
}

@end
