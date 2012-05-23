//
//  FlexOCXMLResourceTest.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-23.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "FlexOCXMLResourceTest.h"

#import <FlexOC/Core/Context/Implementation/XmlApplicationContext.h>

@implementation FlexOCXMLResourceTest

- (void)setUp {
    [super setUp];
	
	NSBundle* main = [NSBundle bundleForClass:[self class]];
	NSString* path = [main pathForResource:@"context_rcsTest" ofType:@"xml"];
	context = [[XmlApplicationContext alloc] initWithXmlAtFilepath:path];
}

-(void) testInclude {
	NSArray* list = [context getObjectWithName:@"sampleList"];
	STAssertNotNil(list, @"List shouldn't be nil");
	STAssertTrue([[list objectAtIndex:0] isEqualToString:@"Hello stringRef1"], @"Element 0 should be equald to 'Hello stringRef1'");
	STAssertTrue([[list objectAtIndex:1] isEqualToString:@"Hello stringRef2"], @"Element 2 should be equald to 'Hello stringRef2'");
}

@end
