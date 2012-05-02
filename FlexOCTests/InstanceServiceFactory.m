//
//  InstanceServiceFactory.m
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-16.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "InstanceServiceFactory.h"

#import "InstanceService.h"

@implementation InstanceServiceFactory

+(id<IInstanceService>) CreateService {
	InstanceService* srv = [[InstanceService alloc] init];
	srv.stringFromContext = @"A value set from InstanceServiceFactory CreateService";
	return srv;
}

@end
