//
//  DictionaryCache.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-15.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#ifdef FLEXOC_STATIC_LIB
#import <FlexOC/Core/Caching/ICache.h>
#else
#import <FlexOC/ICache.h>
#endif

@class ReadWriteLock;

@interface DictionaryCache : NSObject<ICache> {
	@private
	NSMutableDictionary* elements;
	ReadWriteLock* lock;
}

@end
