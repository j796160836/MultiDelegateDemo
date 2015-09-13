//
//  MySingleton.m
//  MultiDelegateDemo
//
//  Created by Johnny on 9/13/15.
//  Copyright (c) 2015 Johnny. All rights reserved.
//

#import "MySingleton.h"

@interface MySingleton()

@property (nonatomic, strong)NSPointerArray* delegates;

@end

@implementation MySingleton

+ (MySingleton*)sharedSingleton
{
    static MySingleton* _sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedSingleton = [[self alloc] init];
    });
    
    return _sharedSingleton;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _delegates = [[NSPointerArray alloc] initWithOptions:NSPointerFunctionsWeakMemory];
    }
    return self;
}


-(void) doSomething {
    [self performSelector:@selector(postCallback1) withObject:nil afterDelay:1];
}

-(void) doSomethingWithCompleteMessage:(NSString *)message {
    [self performSelector:@selector(postReceiveMessage:) withObject:message afterDelay:2];
}

- (void)addDelegate:(id)delegate {
    if ([self indexOfDelegate:delegate] != NSNotFound) {
        return;
    }
    [_delegates addPointer:(__bridge void*)delegate];
}

- (void)removeDelegate:(id)delegate {
    NSUInteger index = [self indexOfDelegate:delegate];
    if (index != NSNotFound) {
        [_delegates removePointerAtIndex:index];
    }
    [_delegates compact];
}

- (NSUInteger)indexOfDelegate:(id)delegate {
    for (NSUInteger i = 0; i < _delegates.count; i += 1) {
        if ([_delegates pointerAtIndex:i] == (__bridge void*)delegate) {
            return i;
        }
    }
    return NSNotFound;
}

- (void) postCallback1 {
    [_delegates compact];
    
    for (NSObject<MySingletonDelegate> *observer in _delegates) {
        if ([observer respondsToSelector:@selector(mySingletonMethodCallback1:)]) {
            [observer mySingletonMethodCallback1:self];
        }
    }
}

- (void) postReceiveMessage:(NSString *)message {
    [_delegates compact];
    
    for (NSObject<MySingletonDelegate> *observer in _delegates) {
        if ([observer respondsToSelector:@selector(mySingleton:didReceiveMessage:)]) {
            [observer mySingleton:self didReceiveMessage:message];
        }
    }
}

@end
