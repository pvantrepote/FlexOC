//
//  FlexOCApplication.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-25.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "FlexOCApplication.h"

#import "IApplicationContext.h"

@implementation FlexOCApplication

#pragma mark - Properties

@synthesize applicationDelegate;

#pragma mark - Init/Dealloc

-(id) init {
	self = [super init];
	if (self) {
		if ([[IApplicationContext sharedApplicationContext] configureObject:self 
																   withName:NSStringFromClass([self class])]) {
			self.delegate = applicationDelegate;			
		}
	}
	
	return self;
}

- (void)dealloc {
    self.applicationDelegate = nil;
}

-(void)awakeFromNib {
	if ([[IApplicationContext sharedApplicationContext] configureObject:self 
															   withName:NSStringFromClass([self class])]) {
		self.delegate = applicationDelegate;			
	}
}

@end

