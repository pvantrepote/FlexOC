//
//  ObjectProxy.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-01.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "ObjectProxy.h"

@implementation ObjectProxy

#pragma mark - Properties

@synthesize objectInstance;

#pragma mark - NSObject override

-(void)forwardInvocation:(NSInvocation *)anInvocation {
	if ([self.objectInstance respondsToSelector:anInvocation.selector]) {
		[anInvocation invokeWithTarget:self.objectInstance];
	}
	else {
		[self doesNotRecognizeSelector:anInvocation.selector];
	}
}

-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
	return [self.objectInstance methodSignatureForSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
	
	if ([self.objectInstance respondsToSelector:aSelector]) {
		return self.objectInstance;
	}
	else {
		[self doesNotRecognizeSelector:aSelector];
	}
	
	return nil;
}

-(id)replacementObjectForCoder:(NSCoder *)aCoder {
	return self.objectInstance;
}

@end
