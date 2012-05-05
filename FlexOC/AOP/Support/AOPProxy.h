//
//  AOPProxy.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-03.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <FlexOC/Core/Proxy/ObjectProxy.h>

@interface AOPProxy : ObjectProxy {
	@private
	NSMutableArray* before;
	NSMutableArray* after;
	NSMutableArray* exceptions;
}

@property (nonatomic, retain) NSMutableArray* interceptors;

@end
