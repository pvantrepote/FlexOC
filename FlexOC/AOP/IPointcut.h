//
//  IPointcut.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-02.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ITypeFilter;
@protocol IMessageMatcher;

@protocol IPointcut <NSObject>

@property (nonatomic, retain) id<ITypeFilter> typeFilter;
@property (nonatomic, retain) id<IMessageMatcher> messageMatcher;

@end
