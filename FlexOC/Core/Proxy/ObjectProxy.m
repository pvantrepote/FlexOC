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

-(void) forwardInvocation:(NSInvocation *)anInvocation {
	
	if ([self.target isKindOfClass:[LazyObjectProxy class]]) {
		/// Its a lazy object
		self.target = ((LazyObjectProxy*)self.target).target;
	}
	
	if ([self.target respondsToSelector:anInvocation.selector]) {
		[anInvocation invokeWithTarget:self.target];
	}
	else {
		[self doesNotRecognizeSelector:anInvocation.selector];
	}
}

-(NSMethodSignature *) methodSignatureForSelector:(SEL)aSelector {
	return [self.target methodSignatureForSelector:aSelector];
}

-(id) forwardingTargetForSelector:(SEL)aSelector {
	
	if ([self.target respondsToSelector:aSelector]) {
		return self.target;
	}
	else {
		[self doesNotRecognizeSelector:aSelector];
	}
	
	return nil;
}

-(id) replacementObjectForCoder:(NSCoder *)aCoder {
	return self.target;
}

@end
