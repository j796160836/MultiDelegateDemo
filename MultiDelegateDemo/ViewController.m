//
//  ViewController.m
//  MultiDelegateDemo
//
//  Created by Johnny on 9/13/15.
//  Copyright (c) 2015 Johnny. All rights reserved.
//

#import "ViewController.h"
#import "MySingleton.h"

@interface ViewController () <MySingletonDelegate>

@property (nonatomic, weak) MySingleton *single;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.single = [MySingleton sharedSingleton];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.single addDelegate:self];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.single removeDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)button01Click:(id)sender {
    [self.single doSomething];
}
- (IBAction)button02Click:(id)sender {
    [self.single doSomethingWithCompleteMessage:@"Hello"];
}

-(void)mySingletonMethodCallback1:(MySingleton *)single {
    NSLog(@"Callback");
}

-(void)mySingleton:(MySingleton *)single didReceiveMessage:(NSString *)message {
    NSLog(@"My message: %@", message);
}

@end
