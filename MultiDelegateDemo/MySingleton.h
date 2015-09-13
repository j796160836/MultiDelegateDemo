//
//  MySingleton.h
//  MultiDelegateDemo
//
//  Created by Johnny on 9/13/15.
//  Copyright (c) 2015 Johnny. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MySingleton;
@protocol MySingletonDelegate <NSObject>
@optional

- (void)mySingletonMethodCallback1:(MySingleton *) single;
- (void)mySingleton:(MySingleton *) single didReceiveMessage:(NSString *)message;

@end

@interface MySingleton : NSObject

+ (MySingleton*)sharedSingleton;

-(void) doSomething;
-(void) doSomethingWithCompleteMessage:(NSString *)message;

- (void)addDelegate:(id)delegate;
- (void)removeDelegate:(id)delegate;

@end
