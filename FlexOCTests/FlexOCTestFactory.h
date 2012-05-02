//
//  FlexOCTestFactory.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-16.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

#import <FlexOC/Core/Context/Implementation/XmlApplicationContext.h>

@interface FlexOCTestFactory : SenTestCase {
	XmlApplicationContext* context;
}

@end
