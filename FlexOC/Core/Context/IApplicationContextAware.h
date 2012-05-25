//
//  IApplicationContextAware.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-25.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IApplicationContext;

@protocol IApplicationContextAware <NSObject>

@property (nonatomic, weak) id<IApplicationContext> context;

@end
