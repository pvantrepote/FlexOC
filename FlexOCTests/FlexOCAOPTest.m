//
//  FlexOCAOPTest.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-04.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "FlexOCAOPTest.h"

#import "InstanceService.h"

@implementation FlexOCAOPTest

- (void)setUp {
    [super setUp];
	
	NSBundle* main = [NSBundle bundleForClass:[self class]];
	NSString* path = [main pathForResource:@"pointcut" ofType:@"xml"];
	context = [[XmlApplicationContext alloc] initWithXmlAtFilepath:path];
}

-(void) testArray {
	id<IInstanceService> srv = [context getObjectWithName:@"instanceService"];
	STAssertNotNil(srv, @"Service should not be nil");
	STAssertTrue([srv.stringFromContext isEqualToString:@"A value from context"], @"stringFromContext should be equal to A value from context");
	
	
}

@end
