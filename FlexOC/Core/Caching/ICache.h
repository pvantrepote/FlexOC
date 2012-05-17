//
//  ICache.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-15.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ICachePolicy;
@protocol CacheDelegate;

/**
	Cache interface
 */
@protocol ICache <NSObject, NSFastEnumeration>

@property (nonatomic, retain) id<ICachePolicy> policy;
@property (nonatomic, assign) id<CacheDelegate> delegate;
@property (nonatomic, readonly) NSInteger count;
@property (nonatomic, readonly) NSArray* keys;

/**
	Init the cache with a specified policy
	@returns the instance of the cache or nil if initialization failed.
 */
-(id) initWithPolicy:(id<ICachePolicy>) policy;

/**
	Return an element for a given key
	@returns an element
 */
-(id) elementForKey:(id) key;


-(void) removeElementForKey:(id) key;
-(void) removeAllElements;

@end


@protocol CacheDelegate <NSObject>

-(id) cache:(id<ICache>) cache requestInstanceForKey:(id) key;

@optional
-(BOOL) cache:(id<ICache>) cache shouldRemoveElementForKey:(id) key;
-(BOOL) cacheShouldRemoveAllElements:(id<ICache>)cache;

@end
