//
//  MemoryWarningCachePolicy.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-15.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//


#ifdef FLEXOC_STATIC_LIB
#import <FlexOC/Core/Caching/ICachePolicy.h>
#else
#import <FlexOC/ICachePolicy.h>
#endif


/**
	Memory warning cache policy.
 	Clear the cache when receive a memory UIApplicationDidReceiveMemoryWarningNotification.
 */
@interface MemoryWarningCachePolicy : NSObject<ICachePolicy>
@end
