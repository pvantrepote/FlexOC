//
//  TestButton.m
//  UIInjection
//
//  Created by Pascal Vantrepote on 12-05-27.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "TestButton.h"

#import <FlexOC/FlexOC.h>

@implementation TestButton

FLEXOC_OBJECT_ID("testButton");

@synthesize behavior;

-(void)setBehavior:(id<TestButtonBehavior>)behavior_ {
	if (behavior == behavior_) return;
	
	if (behavior_) {
		behavior = behavior_;
		[self addTarget:behavior action:@selector(onPress:) forControlEvents:UIControlEventTouchUpInside];
	}
	else {
		behavior = nil;
	}
}

@end
