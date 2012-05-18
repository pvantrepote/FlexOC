//
//  ReadWriteLock.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-15.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "ReadWriteLock.h"

@implementation ReadWriteLock

#pragma mark - Init/Dealloc

-(id) init {
	self = [super init];
	if (self) {
		pthread_rwlock_init(&lock, NULL);
	}
	
	return self;
}

-(void) dealloc {
	pthread_rwlock_destroy(&lock);
}

#pragma mark - Public methods

-(void) lock {
	pthread_rwlock_rdlock(&lock);
}

-(void) unlock {
	pthread_rwlock_unlock(&lock);
}

-(void) writeLock {
	pthread_rwlock_wrlock(&lock);
}

-(BOOL) tryLock {
	return (pthread_rwlock_tryrdlock(&lock) == 0);
}

-(BOOL) tryWriteLock {
	return (pthread_rwlock_trywrlock(&lock) == 0);
}

@end
