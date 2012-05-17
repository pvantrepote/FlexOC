//
//  AOPProxy.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-03.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "AOPProxy.h"

#import "IPointcutAdvisor.h"
#import "IPointcut.h"
#import "IMessageMatcher.h"
#import "IMessageBeforeAdvice.h"
#import "IMessageAfterAdvice.h"
#import "IMessageExceptionAdvice.h"

@implementation AOPProxy

#pragma mark - Property

@synthesize interceptors;

-(void) setInterceptors:(NSMutableArray *)interceptors_ {
	if (interceptors == interceptors_) return;
	
	if (interceptors_) {
		interceptors = interceptors_;
		
		if (!before) before = [NSMutableArray array];
		else [before removeAllObjects];
		
		if (!after) after = [NSMutableArray array];
		else [after removeAllObjects];
		
		if (!exceptions) exceptions = [NSMutableArray array];
		else [exceptions removeAllObjects];
		
		for (id<IPointcutAdvisor> advisor in interceptors) {
			if ([advisor.advice respondsToSelector:@selector(beforeInvocation:withTarget:)] && advisor.pointcut) 
				[before addObject:advisor];
			if ([advisor.advice respondsToSelector:@selector(afterInvocation:withTarget:)] && advisor.pointcut) 
				[after addObject:advisor];
			if ([advisor.advice respondsToSelector:@selector(exception:duringInvocation:withTarget:)] && advisor.pointcut) 
				[exceptions addObject:advisor];
		}
	}
	else {
		interceptors = nil;
		before = nil;
		after = nil;
		exceptions = nil;
	}
	
}

#pragma mark - Init/Dealloc

-(void) dealloc {
	before = nil;
	after = nil;
	exceptions = nil;
    self.interceptors = nil;
}

#pragma mark - Override

-(void)forwardInvocation:(NSInvocation *)anInvocation {
	
	NSString* aStringSelector = NSStringFromSelector(anInvocation.selector);
	
	@try {
		/// Before advice
		for (id<IPointcutAdvisor> advisor in before) {
			if ([advisor.pointcut matchesSelector:aStringSelector 
									forInvocation:anInvocation]) {
				[((id<IMessageBeforeAdvice>)advisor.advice) beforeInvocation:anInvocation 
																  withTarget:self.target];
			}
		}
		
		[super forwardInvocation:anInvocation];		
		
		/// After advice
		for (id<IPointcutAdvisor> advisor in after) {
			if ([advisor.pointcut matchesSelector:aStringSelector 
									forInvocation:anInvocation]) {
				[((id<IMessageAfterAdvice>)advisor.advice) afterInvocation:anInvocation 
																withTarget:self.target];
			}
		}
	}
	@catch (NSException *exception) {
		/// Exception advice
		for (id<IPointcutAdvisor> advisor in exceptions) {
			if ([advisor.pointcut matchesSelector:aStringSelector 
									forInvocation:anInvocation]) {
				[((id<IMessageExceptionAdvice>)advisor.advice) exception:exception 
														duringInvocation:anInvocation 
															  withTarget:self.target];
			}
		}
	}
	@finally {
	}
}

-(id)forwardingTargetForSelector:(SEL)aSelector {
	if ([self.interceptors count]) return nil;
	
	return self.target;
}

@end
