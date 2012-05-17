//
//  TestExceptionAdvisor.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-17.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "TestExceptionAdvisor.h"

@implementation TestExceptionAdvisor

@synthesize exception, advice, pointcut;

-(id<IAdvice>)advice {
	return self;
}

-(void)exception:(NSException *)exception_ duringInvocation:(NSInvocation *)invocation withTarget:(id)target {
	self.exception = exception_;
}

@end
