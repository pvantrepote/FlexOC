//
//  AOPProxy.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-03.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "AOPProxy.h"

@implementation AOPProxy

#pragma mark - Override

-(void)forwardInvocation:(NSInvocation *)anInvocation {
	[super forwardInvocation:anInvocation];
}

-(id)forwardingTargetForSelector:(SEL)aSelector {
	/// Force the system to call forwardInvocation
	return nil;
}

@end
