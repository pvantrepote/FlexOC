//
//  DependencyTree.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-17.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DependencyTree : NSObject {
	@private
	NSMutableArray* children;
	NSString* name;
	__weak id instance;
	DependencyTree* parent;
}

@property (nonatomic, readonly) NSString* name;
@property (nonatomic, weak) id instance;
@property (nonatomic, retain) DependencyTree* parent;


+(id) hasCircularDependencyForObjectName:(NSString*) objectName;
+(void) pushInstance:(id) instance forObjectName:(NSString*) objectName;
+(void) pop;

@end
