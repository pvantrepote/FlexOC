//
//  IMessageMatcher.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-02.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IMessageMatcher <NSObject>

-(BOOL) matchesSelector:(NSString*) selector forInvocation:(NSInvocation*) invocation;

@end
