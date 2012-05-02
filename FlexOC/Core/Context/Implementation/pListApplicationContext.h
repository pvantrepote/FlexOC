//
//  pListApplicationContext.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-09.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <FlexOC/Core/Context/Implementation/DictionaryApplicationContext.h>

@interface pListApplicationContext : DictionaryApplicationContext

-(id) initWithPListAtPath:(NSString*) path;
-(id) initWithPListAtURL:(NSURL*) url;

@end
