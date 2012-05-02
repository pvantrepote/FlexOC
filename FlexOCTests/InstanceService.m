//
//  InstanceService.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-11.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "InstanceService.h"

@implementation InstanceService

@synthesize stringFromContext, valueFromContext;

-(id) initWithValue:(NSNumber *)value andString:(NSString *)string {
	self = [super init];
	if (self) {
		self.valueFromContext = value;
		self.stringFromContext = string;
	}
	
	return self;
}

- (void)dealloc {
	stringFromContext = nil;
}

+(id<IInstanceService>) CreateService {
	InstanceService* srv = [[InstanceService alloc] init];
	srv.stringFromContext = @"A value set from CreateService";
	return srv;
}

-(NSString *)testProxyCall {
	return @"Hello";
}

-(id) initWithCoder:(NSCoder *)aDecoder {
	self = [super init];
	if (self) {
		self.valueFromContext = [aDecoder decodeObjectForKey:@"v"];
		self.stringFromContext = [aDecoder decodeObjectForKey:@"s"];
	}
	
	return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:self.valueFromContext forKey:@"v"];
	[aCoder encodeObject:self.stringFromContext forKey:@"s"];
}
@end
