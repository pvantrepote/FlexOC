//
//  ApplicationContextResourceProvider.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-04-15.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApplicationContextResourceProvider : NSObject

+(NSString*) resolveFilepath:(NSString*) filepath;
+(NSURL*) resolveURL:(NSURL*) url;

@end
