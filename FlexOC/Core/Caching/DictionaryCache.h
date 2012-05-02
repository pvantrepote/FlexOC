//
//  DictionaryCache.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-15.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <FlexOC/Core/Caching/ICache.h>

@class ReadWriteLock;

@interface DictionaryCache : NSObject<ICache> {
	@private
	NSMutableDictionary* elements;
	ReadWriteLock* lock;
}

@end
