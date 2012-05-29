//
//  FlexOCApplication.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-25.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "FlexOCApplication.h"

#import "IApplicationContext.h"
#import "IAnnotations.h"

@implementation FlexOCApplication

#pragma mark - Properties

FLEXOC_OBJECT_ID("FlexOCApplication");

@synthesize applicationDelegate;

#pragma mark - Init/Dealloc

-(id) init {
	self = [super init];
	if (self) {
		if ([[IApplicationContext sharedApplicationContext] configureObject:self 
																   withName:self.flexOCObjectID]) {
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
															   withName:self.flexOCObjectID]) {
		self.delegate = applicationDelegate;			
	}
}

@end

