//
//  InstanceServiceNameAware.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-25.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import "InstanceService.h"

#import <FlexOC/Core/Objects/Factory/IObjectNameAware.h>
#import <FlexOC/Core/Context/IApplicationContextAware.h>

@interface InstanceServiceNameAware : InstanceService<IObjectNameAware>

@end

@interface InstanceServiceContextAware : InstanceService<IApplicationContextAware>

@end
