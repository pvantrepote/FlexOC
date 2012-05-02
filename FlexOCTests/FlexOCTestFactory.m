//
//  FlexOCTestFactory.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-16.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "FlexOCTestFactory.h"

#import "InstanceService.h"

@implementation FlexOCTestFactory

- (void)setUp {
    [super setUp];
	
	NSBundle* main = [NSBundle bundleForClass:[self class]];
	NSString* path = [main pathForResource:@"context_factorytest" ofType:@"xml"];
	context = [[XmlApplicationContext alloc] initWithXmlAtFilepath:path];
}

-(void)tearDown {
	[super tearDown];
	
	context = nil;
}

-(void) testMethodFactory {	
	InstanceService* srv = [context getObjectWithName:@"sampleFactoryMethod"];
	STAssertNotNil(srv, @"Instance shouldn't be nil.");
	STAssertTrue([srv.stringFromContext isEqualToString:@"A value set from CreateService"], @"Value should be equal.");
}

-(void) testObjectFactory {	
	InstanceService* srv = [context getObjectWithName:@"sampleObjectFactory"];
	STAssertNotNil(srv, @"Instance shouldn't be nil.");
	STAssertTrue([srv.stringFromContext isEqualToString:@"A value set from InstanceServiceFactory CreateService"], @"Value should be equal.");
}


@end
