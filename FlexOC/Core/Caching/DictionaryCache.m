//
//  DictionaryCache.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-15.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "DictionaryCache.h"

#import <FlexOC/Core/Threading/ReadWriteLock.h>
#import "ICachePolicy.h"
#import "MemoryWarningCachePolicy.h"

@interface DictionaryCache (Private) <CachePolicyDelegate>

@end

@implementation DictionaryCache

#pragma mark - Properties

@synthesize policy, delegate;

-(void) setPolicy:(id<ICachePolicy>)policy_ {
	if (policy == policy_) return;
	
	if (policy) {
		policy.delegate = nil;
	}
	
	if (policy_) {
		policy = policy_;
		policy.delegate = self;
	}
	else {
		policy = nil;		
	}
}

-(NSInteger)count {
	NSInteger count;
	[lock lock];
	count = [elements count];
	[lock unlock];
	
	return count;
}

-(NSArray *)keys {
	NSArray* keys;
	[lock lock];
	keys = [elements allKeys];
	[lock unlock];
	return keys;
}

#pragma mark - Init/Dealloc

-(id) initWithPolicy:(id<ICachePolicy>) policy_ {
	self = [super init];
	if (self) {
		self.policy = policy_;
		elements = [[NSMutableDictionary alloc] init];
		lock = [[ReadWriteLock alloc] init];
	}
	
	return self;
}

- (id)init {
    self = [super init];
    if (self) {
        elements = [[NSMutableDictionary alloc] init];
		lock = [[ReadWriteLock alloc] init];
		
		/// By default on iOS we use Memory Warning policy
		self.policy = [[MemoryWarningCachePolicy alloc] init];
    }
    return self;
}

- (void)dealloc {
	lock = nil;
	elements = nil;
}

#pragma mark - Public methods

-(id) elementForKey:(id) key {
	id element = nil;
	[lock lock];
	@try {
		element = [elements objectForKey:key];		
	}
	@finally {
		[lock unlock];
	}
	
	if (!element) {
		[lock writeLock];
		
		@try {
			element = [elements objectForKey:key];
			if (!element) {
				element = [delegate cache:self requestInstanceForKey:key];
				if (element) {
					/// ACK policy that an element was added
					element = [policy cache:self willAddElement:element forKey:key];
					
					[elements setObject:element forKey:key];
				}
			}
		}		
		@finally {
			[lock unlock];
		}
	}
	
	/// ACK policy that an element was accessed
	if (element) {
		element = [policy cache:self willAccessElement:element forKey:key];
	}
	
	return element;
}

-(void) removeElementForKey:(id) key {
	[lock writeLock];
	
	@try {
		id element = [elements objectForKey:key];
		if (element) {
			if ([delegate respondsToSelector:@selector(cache:shouldRemoveElementForKey:)]) {
				if ([delegate cache:self shouldRemoveElementForKey:key]) {
					/// ACK policy that an element was deleteded
					element = [policy cache:self willRemoveElement:element forKey:key];
					
					[elements removeObjectForKey:key];
				}
			}
			else {
				/// ACK policy that an element was deleteded
				element = [policy cache:self willRemoveElement:element forKey:key];
				
				[elements removeObjectForKey:key];
			}
		}	
	}
	@finally {
		[lock unlock];
	}
	
}

-(void) removeAllElements {
	[lock writeLock];
	
	@try {
		if ([delegate respondsToSelector:@selector(cacheShouldRemoveAllElements:)]) {
			if ([delegate cacheShouldRemoveAllElements:self]) {
				/// ACK policy that we will remove all elements
				[policy cacheWillRemoveAllElements:self];
				
				[elements removeAllObjects];
			}
		}
		else {
			/// ACK policy that we will remove all elements
			[policy cacheWillRemoveAllElements:self];
			
			[elements removeAllObjects];
		}		
	}
	@finally {
		[lock unlock];
	}	
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])buffer count:(NSUInteger)len {
	NSUInteger count = 0;
	[lock lock];
	count = [elements countByEnumeratingWithState:state 
										  objects:buffer 
											count:len];
	[lock unlock];
	
	return count;
}

@end

@implementation DictionaryCache (Private)

-(void) policy:(id<ICachePolicy>) policy expiredElementForKey:(id) key {
	[self removeElementForKey:key];
}

-(void) policyShouldClearAllElements:(id<ICachePolicy>)policy {
	[self removeAllElements];
}

@end
