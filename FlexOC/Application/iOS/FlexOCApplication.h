//
//  FlexOCApplication.h
//  FlexOC
//
//  Created by Pascal Vantrepote on 12-05-25.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef FLEXOC_STATIC_LIB
#import <FlexOC/Core/Context/Annotations/IAnnotations.h>
#else
#import <FlexOC/IAnnotations.h>
#endif

@interface FlexOCApplication : UIApplication<IAnnotations>

@property (strong) id<UIApplicationDelegate> applicationDelegate; 

@end
