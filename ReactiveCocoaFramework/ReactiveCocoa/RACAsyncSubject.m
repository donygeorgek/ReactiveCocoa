//
//  RACAsyncSubject.m
//  ReactiveCocoa
//
//  Created by Josh Abernathy on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RACAsyncSubject.h"
#import "RACObserver.h"

@interface RACAsyncSubject ()
@property (nonatomic, strong) id lastValue;
@property (assign) BOOL hasCompletedAlready;
@end


@implementation RACAsyncSubject


#pragma mark RACObservable

- (RACDisposable *)subscribe:(id<RACObserver>)observer {
	RACDisposable * disposable = [super subscribe:observer];
	if(self.hasCompletedAlready) {
		[self sendCompleted];
	}
	
	return disposable;
}


#pragma mark RACObserver

- (void)sendNext:(id)value {
	self.lastValue = value;
}

- (void)sendCompleted {
	self.hasCompletedAlready = YES;
	
	[super sendNext:self.lastValue];
	[super sendCompleted];
}


#pragma mark API

@synthesize lastValue;
@synthesize hasCompletedAlready;

@end