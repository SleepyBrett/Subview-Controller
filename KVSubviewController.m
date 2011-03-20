//
//  KVSubviewController.m
//  Koolistov
//
//  Created by Johan Kool on 22-02-11.
//  Copyright 2011 Koolistov. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are 
//  permitted provided that the following conditions are met:
//
//  * Redistributions of source code must retain the above copyright notice, this list of 
//    conditions and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright notice, this list 
//    of conditions and the following disclaimer in the documentation and/or other materials 
//    provided with the distribution.
//  * Neither the name of KOOLISTOV nor the names of its contributors may be used to 
//    endorse or promote products derived from this software without specific prior written 
//    permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY 
//  EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
//  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL 
//  THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
//  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT 
//  OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
//  HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, 
//  OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "KVSubviewController.h"

@interface KVSubviewController ()

@property(nonatomic, readwrite, retain) NSBundle *nibBundle;

@end

@implementation KVSubviewController

#pragma mark - Creating a Subview Controller Using Nib Files
- (id)initWithNibName:(NSString *)aNibName bundle:(NSBundle *)aNibBundle {
    self = [super init];
    if (self) {
        NSLog(@"KVSubviewController iniated without specifying view controller and parent controller. Strongly discouraged!");
        nibName = [aNibName copy];
        nibBundle = [aNibBundle retain];
        viewController = nil;
        parentController = nil;
        loadFromNib = YES;
    }
    return self;
}

- (id)initWithNibName:(NSString *)aNibName bundle:(NSBundle *)aNibBundle viewController:(UIViewController *)aViewController parentController:(id)aParentController {
    NSParameterAssert(@"No parent view controller provided");
    NSParameterAssert(@"No parent controller provided");
    NSAssert(([aParentController isKindOfClass:[UIViewController class]] || [aParentController isKindOfClass:[KVSubviewController class]]), @"The parent controller should be a (sub)class of UIViewController or a (sub)class of KVSubviewController");
    NSAssert(([aParentController isKindOfClass:[UIViewController class]] ? (aViewController == aParentController) : YES), @"If the parent controller is a (sub)class of UIViewController the parent view controller should be the same instance");
    
    self = [super init];
    if (self) {
        nibName = [aNibName copy];
        nibBundle = [aNibBundle retain];
        viewController = aViewController;
        parentController = aParentController;
        loadFromNib = YES;
    }
    return self;
}

@synthesize nibName;
@synthesize nibBundle;

- (void)dealloc {
    if ([self isViewLoaded]) {
        if (self.view.superview == nil) {
            [view release], view = nil;
            [self viewDidUnload];
            NSAssert(view == nil, @"View was reloaded in viewDidUnload");
        } else {
            NSAssert(YES, @"Subview controller is being deallocated whilst its view is still in the view hierarchy");
        }
    }
    [nibName release], nibName = nil;
    [nibBundle release], nibBundle = nil;
    viewController = nil;
    parentController = nil;
    [super dealloc];
}

#pragma mark - Managing the View
- (UIView *)view {
    if (![self isViewLoaded]) {
        [self willChangeValueForKey:@"isViewLoaded"];
        [self willChangeValueForKey:@"view"];
        [self loadView];
        NSAssert(view != nil, @"View was not loaded");
        [self viewDidLoad];
        [self didChangeValueForKey:@"view"];
        [self didChangeValueForKey:@"isViewLoaded"];
    }
    return view;
}

- (void)setView:(UIView *)anView {
    if (anView != view) {
        [anView retain];
        [view autorelease];
        view = anView;
    }
}

- (void)loadView {
    NSAssert(view == nil, @"View was already loaded");

    if (loadFromNib) {
        NSBundle *loadBundle = self.nibBundle;
        if (!loadBundle) {
            loadBundle = [NSBundle mainBundle];
        }
        
        NSString *loadName = self.nibName;
        if (!loadName) {
            loadName = NSStringFromClass([self class]);
            self.nibName = loadName;
        }
        [loadBundle loadNibNamed:loadName owner:self options:nil];
    } else {
        view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 480.0f)];
    }
    
    NSAssert(view != nil, @"View was not loaded");
}

- (void)viewDidLoad {
    // To be implemented by subclass
}

- (void)viewDidUnload {
    // To be implemented by subclass    
}

- (BOOL)isViewLoaded {
    return (view != nil);
}

#pragma mark - Responding to View Events
- (void)viewWillAppear:(BOOL)animated {
    // To be implemented by subclass
}

- (void)viewDidAppear:(BOOL)animated {
    // To be implemented by subclass
}

- (void)viewWillDisappear:(BOOL)animated {
    // To be implemented by subclass
}

- (void)viewDidDisappear:(BOOL)animated {
    // To be implemented by subclass
}

#pragma mark - Handling View Rotations
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    // To be implemented by subclass
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
    // To be implemented by subclass
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    // To be implemented by subclass
}

//- (void)willAnimateFirstHalfOfRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
//    // To be implemented by subclass
//}
//
//- (void)didAnimateFirstHalfOfRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
//    // To be implemented by subclass
//}
//
//- (void)willAnimateSecondHalfOfRotationFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation duration:(NSTimeInterval)duration {
//    // To be implemented by subclass
//}

#pragma mark - Handling Memory Warnings
- (void)didReceiveMemoryWarning {
    // If our view is loaded, but not in use (superview is nil), release it
    if ([self isViewLoaded]) {
        if (self.view.superview == nil) {
            self.view = nil;
            [self viewDidUnload];
        }
    }
}

#pragma mark - Getting Other Related View Controllers
@synthesize viewController;
@synthesize parentController;

@end
