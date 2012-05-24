//
//  IObjectValueDefinition.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-19.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
	ObjectValueTypeValue,
	ObjectValueTypeReference,
	ObjectValueTypeObject,
	ObjectValueTypeList,
	ObjectValueTypeDictionary,
} ObjectValueTypes;

@protocol IObjectValueDefinition <NSObject>

@property (nonatomic, assign) ObjectValueTypes type;
@property (nonatomic, retain) id value;

@end
