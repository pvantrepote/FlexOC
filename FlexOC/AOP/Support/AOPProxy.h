//
//  AOPProxy.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-03.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#ifdef FLEXOC_STATIC_LIB
#import <FlexOC/Core/Proxy/ObjectProxy.h>
#else
#import <FlexOC/FlexOC.h>
#endif

@interface AOPProxy : ObjectProxy {
	@private
	NSMutableArray* before;
	NSMutableArray* after;
	NSMutableArray* exceptions;
}

@property (nonatomic, retain) NSMutableArray* interceptors;

@end
