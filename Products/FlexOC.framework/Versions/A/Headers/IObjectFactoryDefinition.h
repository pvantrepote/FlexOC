//
//  IObjectFactoryDefinition.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-19.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IObjectFactoryDefinition <NSObject>

@property (nonatomic, retain) NSString* factoryMethod;
@property (nonatomic, retain) NSString* factoryObject;

@end
