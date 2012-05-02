//
//  InstanceServiceFactory.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-16.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IInstanceService.h"

@interface InstanceServiceFactory : NSObject

+(id<IInstanceService>) CreateService;

@end
