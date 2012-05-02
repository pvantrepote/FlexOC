//
//  MemoryWarningCachePolicy.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-15.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "MemoryWarningCachePolicy.h"

#import <UIKit/UIKit.h>

@interface MemoryWarningCachePolicy (Private)

-(void) onMemoryWarning:(NSNotification*) notification;

@end

@implementation MemoryWarningCachePolicy

#pragma mark - Properties

@synthesize delegate;

#pragma mark - Init/Dealloc

- (id)init {
    self = [super init];
    if (self) {
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(onMemoryWarning:) 
													 name:UIApplicationDidReceiveMemoryWarningNotification 
												   object:nil];
    }
    return self;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self 
													name:UIApplicationDidReceiveMemoryWarningNotification 
												  object:nil];
}

#pragma mark - Public methods

-(id) cache:(id<ICache>)cache willAddElement:(id) element forKey:(id) key {
	return element;
}

-(id) cache:(id<ICache>)cache willAccessElement:(id) element forKey:(id) key {
	return element;
}

-(id) cache:(id<ICache>)cache willRemoveElement:(id) element forKey:(id) key {
	return element;
}

-(void) cacheWillRemoveAllElements:(id<ICache>)cache {
}

@end

@implementation MemoryWarningCachePolicy (Private)

-(void) onMemoryWarning:(NSNotification*) notification {
	if (!delegate) return;
	
	[delegate policyShouldClearAllElements:self];
}

@end
