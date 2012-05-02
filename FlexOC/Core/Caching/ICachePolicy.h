//
//  ICachePolicy.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-15.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ICache;
@protocol CachePolicyDelegate;

@protocol ICachePolicy <NSObject>

@property (nonatomic, assign) id<CachePolicyDelegate> delegate;

-(id) cache:(id<ICache>)cache willAddElement:(id) element forKey:(id) key;
-(id) cache:(id<ICache>)cache willAccessElement:(id) element forKey:(id) key;
-(id) cache:(id<ICache>)cache willRemoveElement:(id) element forKey:(id) key;
-(void) cacheWillRemoveAllElements:(id<ICache>)cache;

@end

@protocol CachePolicyDelegate <NSObject>

-(void) policy:(id<ICachePolicy>) policy expiredElementForKey:(id) key;
-(void) policyShouldClearAllElements:(id<ICachePolicy>)policy;

@end