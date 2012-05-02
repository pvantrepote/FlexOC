//
//  NestedService.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-25.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IInstanceService.h"

@interface NestedService : NSObject

@property (nonatomic, retain) id<IInstanceService> service;

@end
