//
//  AuditAdvisor.m
//  UIInjection
//
//  Created by Pascal Vantrepote on 12-05-28.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "AuditAdvisor.h"

@implementation AuditAdvisor

@synthesize pointcut, advice;

-(id<IAdvice>)advice {
	return self;
}

-(void)beforeInvocation:(NSInvocation *)invocation withTarget:(id)target {
	NSLog(@"beforeInvocation: %@", NSStringFromSelector(invocation.selector));
}

-(void)afterInvocation:(NSInvocation *)invocation withTarget:(id)target {
	NSLog(@"afterInvocation: %@", NSStringFromSelector(invocation.selector));
}

@end
