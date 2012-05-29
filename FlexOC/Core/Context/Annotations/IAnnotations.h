//
//  Annotation.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-28.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IAnnotations <NSObject>

@optional
@property (nonatomic, readonly) NSString* flexOCObjectID;

@end

/**
	Define a property that returns the object id used to lookup in the context
	@param objectName the object id
	@returns the object id
 */
#define FLEXOC_OBJECT_ID(objectName) -(NSString*) flexOCObjectID { return @objectName; }
