//
//  FlexOCAOPTest.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-04.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "FlexOCAOPTest.h"

#import "InstanceService.h"
#import "TestAfterBeforAdvisor.h"
#import "TestExceptionAdvisor.h"
#import <FlexOC/AOP/Support/AOPProxy.h>
#import <FlexOC/Core/Proxy/LazyObjectProxy.h>

#import <FlexOC/AOP/TruePointcut.h>
#import <FlexOC/AOP/RegExPointcut.h>

@implementation FlexOCAOPTest

+(void)load {
	[super load];
	
	[TruePointcut version];
	[RegExPointcut version];
}

- (void)setUp {
    [super setUp];
	
	NSBundle* main = [NSBundle bundleForClass:[self class]];
	NSString* path = [main pathForResource:@"pointcut" ofType:@"xml"];
	context = [[XmlApplicationContext alloc] initWithXmlAtFilepath:path];
}

-(void) testBeforAfter {
	id<IInstanceService> srv = [context getObjectWithName:@"instanceService"];
	AOPProxy* concreteSrv = (AOPProxy*) srv;
	TestAfterBeforAdvisor* advisor = [concreteSrv.interceptors objectAtIndex:0];

	STAssertFalse(advisor.didBefore, @"didBefore should be false for the advisor");
	STAssertFalse(advisor.didAfter, @"didAfter should be false for the advisor");

	STAssertNotNil(srv, @"Service should not be nil");
	STAssertTrue([srv.stringFromContext isEqualToString:@"A value from context"], @"stringFromContext should be equal to A value from context");
	

	STAssertTrue(advisor.didBefore, @"didBefore should be true for the advisor");
	STAssertTrue(advisor.didAfter, @"didAfter should be true for the advisor");
}

-(void) testLazyBeforeAfter {
	id<IInstanceService> srv = [context getObjectWithName:@"lazyInstanceService"];
	AOPProxy* concreteSrv = (AOPProxy*) srv;
	TestAfterBeforAdvisor* advisor = [concreteSrv.interceptors objectAtIndex:0];
	
	STAssertTrue([concreteSrv.target isKindOfClass:[LazyObjectProxy class]], @"Target should be type of LazyObjectProxy.");
	
	STAssertFalse(advisor.didBefore, @"didBefore should be false for the advisor");
	STAssertFalse(advisor.didAfter, @"didAfter should be false for the advisor");
	
	STAssertNotNil(srv, @"Service should not be nil");
	STAssertTrue([srv.stringFromContext isEqualToString:@"A value from context"], @"stringFromContext should be equal to A value from context");
	
	STAssertTrue(advisor.didBefore, @"didBefore should be true for the advisor");
	STAssertTrue(advisor.didAfter, @"didAfter should be true for the advisor");
}

-(void) testException {
	id<IInstanceService> srv = [context getObjectWithName:@"exceptionInstanceService"];
	AOPProxy* concreteSrv = (AOPProxy*) srv;
	TestExceptionAdvisor* advisor = [concreteSrv.interceptors objectAtIndex:0];
	
	STAssertNil(advisor.exception, @"Exception should be nil");
	
	STAssertNotNil(srv, @"Service should not be nil");
	STAssertFalse([srv.stringFromContext isEqualToString:@"A value from context"], @"stringFromContext should be equal to A value from context");
	
	STAssertNotNil(advisor.exception, @"Exception should not be nil");
	STAssertTrue([advisor.exception.reason isEqualToString:@"stringFromContext"], @"Reason should be stringFromContext");
}

-(void) testRegex {
	id<IInstanceService> srv = [context getObjectWithName:@"regExInstanceService"];
	AOPProxy* concreteSrv = (AOPProxy*) srv;
	TestAfterBeforAdvisor* advisor = [concreteSrv.interceptors objectAtIndex:0];
	
	STAssertFalse(advisor.didBefore, @"didBefore should be false for the advisor");
	STAssertFalse(advisor.didAfter, @"didAfter should be false for the advisor");
	
	STAssertNotNil(srv, @"Service should not be nil");

	STAssertTrue(srv.valueFromContext.intValue == 5, @"Value should be 5");
	
	STAssertFalse(advisor.didBefore, @"didBefore should be false for the advisor");
	STAssertFalse(advisor.didAfter, @"didAfter should be false for the advisor");

	STAssertTrue([srv.stringFromContext isEqualToString:@"A value from context"], @"stringFromContext should be equal to A value from context");
	
	STAssertTrue(advisor.didBefore, @"didBefore should be true for the advisor");
	STAssertTrue(advisor.didAfter, @"didAfter should be true for the advisor");
}

@end
