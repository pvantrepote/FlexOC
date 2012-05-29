//
//  ObjectProxy.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-01.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "ObjectProxy.h"

#import "LazyObjectProxy.h"

@implementation ObjectProxy

#pragma mark - Properties

@synthesize target;

#pragma mark - NSObject override

-(BOOL)isProxy {
	return YES;
}

-(void) forwardInvocation:(NSInvocation *)anInvocation {
	/// Unwrape if the tagert is lazy
	if ([self.target isKindOfClass:[LazyObjectProxy class]]) {
		self.target = ((LazyObjectProxy*)self.target).target;
	}
	
	if ([self.target respondsToSelector:anInvocation.selector]) {
		anInvocation.target = self.target;
		[anInvocation invoke];
	}
	else {
		[self doesNotRecognizeSelector:anInvocation.selector];
	}
}

-(NSMethodSignature *) methodSignatureForSelector:(SEL)aSelector {
	/// Unwrape if the tagert is lazy
	if ([self.target isKindOfClass:[LazyObjectProxy class]]) {
		self.target = ((LazyObjectProxy*)self.target).target;
	}
	
	return [self.target methodSignatureForSelector:aSelector];
}

-(id) forwardingTargetForSelector:(SEL)aSelector {
	/// Unwrape if the tagert is lazy
	if ([self.target isKindOfClass:[LazyObjectProxy class]]) {
		self.target = ((LazyObjectProxy*)self.target).target;
	}
	
	if ([self.target respondsToSelector:aSelector]) {
		return self.target;
	}
	else {
		[self doesNotRecognizeSelector:aSelector];
	}
	
	return nil;
}

-(id) replacementObjectForCoder:(NSCoder *)aCoder {
	/// Unwrape if the tagert is lazy
	if ([self.target isKindOfClass:[LazyObjectProxy class]]) {
		self.target = ((LazyObjectProxy*)self.target).target;
	}
	
	return self.target;
}

@end
