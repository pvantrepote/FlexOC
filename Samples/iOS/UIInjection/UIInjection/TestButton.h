//
//  TestButton.h
//  UIInjection
//
//  Created by Pascal Vantrepote on 12-05-27.
//  Copyright (c) 2012 Tamajii Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TestButtonBehavior;

@interface TestButton : UIButton

@property (nonatomic, strong) IBOutlet id<TestButtonBehavior> behavior;

@end

@protocol TestButtonBehavior <NSObject>

-(IBAction) onPress:(TestButton*) button;
				 
@end