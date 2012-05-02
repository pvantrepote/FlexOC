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

@protocol ICache <NSObject, NSFastEnumeration>

@property (nonatomic, retain) id<ICachePolicy> policy;
@property (nonatomic, assign) id<CacheDelegate> delegate;
@property (nonatomic, readonly) NSInteger count;
@property (nonatomic, readonly) NSArray* keys;

-(id) initWithPolicy:(id<ICachePolicy>) policy;

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