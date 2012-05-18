//
//  ReadWriteLock.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-15.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <pthread.h>

@interface ReadWriteLock : NSObject<NSLocking> {
@private
	pthread_rwlock_t lock;
}

-(void) writeLock;
-(BOOL) tryLock;
-(BOOL) tryWriteLock;

@end
