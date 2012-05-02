//
//  UIApplication+FlexOC.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-09.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "UIApplication+FlexOC.h"

#import "IApplicationContext.h"

@implementation UIApplication (FlexOC)

+(void) initialize {
	/// Init shared application context
	[IApplicationContext sharedApplicationContext];
}

@end
