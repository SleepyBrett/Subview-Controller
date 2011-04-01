//
//  KVTableSubviewController.m
//  Koolistov
//
//  Created by Johan Kool on 25-02-11.
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

#import "KVTableSubviewController.h"

@interface KVTableSubviewController ()

@end

@implementation KVTableSubviewController

@synthesize clearsSelectionOnViewWillAppear;

#pragma mark - Creating a Table Subview Controller
- (id)initWithStyle:(UITableViewStyle)style {
    self = [super init];
    if (self) {
        NSLog(@"KVTableSubviewController iniated without specifying view controller and parent controller. Strongly discouraged!");
        tableViewStyle = style;
        loadFromNib = NO;
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style viewController:(UIViewController *)aViewController parentController:(id)aParentController {
    NSParameterAssert(aViewController);
    NSParameterAssert(aParentController);
    NSAssert(([aParentController isKindOfClass:[UIViewController class]] || [aParentController isKindOfClass:[KVSubviewController class]]), @"The parent controller should be a (sub)class of UIViewController or a (sub)class of KVSubviewController");
    NSAssert(([aParentController isKindOfClass:[UIViewController class]] ? (aViewController == aParentController) : YES), @"If the parent controller is a (sub)class of UIViewController the parent view controller should be the same instance");

    self = [super init];
    if (self) {
        tableViewStyle = style;
        viewController = aViewController;
        parentController = aParentController;
        loadFromNib = NO;
    }
    return self;
}

- (void)dealloc {
    if ([self isViewLoaded]) {
        if (self.tableView.superview == nil) {
            [tableView release], tableView = nil;
            [self viewDidUnload];
            NSAssert(tableView == nil, @"View was reloaded in viewDidUnload");
        } else {
            NSAssert(YES, @"Table Subview controller is being deallocated whilst its view is still in the view hierarchy");
        }
    }
    viewController = nil;
    parentController = nil;
    [super dealloc];
}

#pragma mark - Managing the View
- (UIView *)view {
    return [self tableView];
}

- (void)setView:(UIView *)anView {
    NSAssert([anView isKindOfClass:[UITableView class]], @"Expected an UITableView instance");
    [self setTableView:(UITableView *)anView];
}

- (UITableView *)tableView {
    if (![self isViewLoaded]) {
        [self willChangeValueForKey:@"isViewLoaded"];
        [self willChangeValueForKey:@"view"];
        [self loadView];
        NSAssert(tableView != nil, @"View was not loaded");
        [self viewDidLoad];
        [self didChangeValueForKey:@"view"];
        [self didChangeValueForKey:@"isViewLoaded"];
    }
    return tableView;
}

- (void)setTableView:(UITableView *)anTableView {
    if (anTableView != tableView) {
        [anTableView retain];
        [tableView autorelease];
        tableView = anTableView;
    }
}

- (void)loadView {
    NSAssert(tableView == nil, @"View was already loaded");

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
        tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 480.0f) style:tableViewStyle];
    }

    NSAssert(tableView != nil, @"View was not loaded");
}

- (BOOL)isViewLoaded {
    return (tableView != nil);
}

#pragma mark - Responding to View Events
- (void)viewWillAppear:(BOOL)animated {
    // To be implemented by subclass
    [super viewWillAppear:animated];

    if (self.clearsSelectionOnViewWillAppear) {
        [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:animated];
    }
}

#pragma mark - Handling Memory Warnings
- (void)didReceiveMemoryWarning {
    // If our view is loaded, but not in use (superview is nil), release it
    if ([self isViewLoaded]) {
        if (self.tableView.superview == nil) {
            self.tableView = nil;
            [self viewDidUnload];
        }
    }
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}

@end
