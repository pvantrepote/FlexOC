//
//  RegExPointcut.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-17.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "RegExPointcut.h"

@interface RegExPointcut ()

@property (nonatomic, retain) NSRegularExpression* regEx;

@end

@implementation RegExPointcut

#pragma mark - Properties

@synthesize pattern, regEx;

#pragma Init/Dealloc

- (void)dealloc {
    self.pattern = nil;
	self.regEx = nil;
}

#pragma mark - Public methods

-(BOOL)matchesSelector:(NSString *)selector forInvocation:(NSInvocation *)invocation {
	if (!regEx) {
		@synchronized(self) {
			if (!regEx) {
				NSError* error = nil;
				self.regEx = [NSRegularExpression regularExpressionWithPattern:pattern 
																	   options:0 
																		 error:&error];
				if (!regEx) {
					NSLog(@"%@", error);
					return NO;
				}
			}
		}
	}
	
	NSTextCheckingResult* result = [self.regEx firstMatchInString:selector 
														  options:0 
															range:NSMakeRange(0, [selector length])];
	return (result && result.range.location != NSNotFound);
}

@end
