SUBVIEW CONTROLLER
==================

From [Apple's Documentation](http://developer.apple.com/library/ios/#featuredarticles/ViewControllerPGforiPhoneOS/AboutViewControllers/AboutViewControllers.html%23//apple_ref/doc/uid/TP40007457-CH112-SW10):

> If you want to divide a view hierarchy into multiple subareas and manage each one separately,
use generic controller objects (custom objects descending from NSObject) instead of view 
controller objects to manage each subarea. Then use a single view controller object to manage
the generic controller objects.

This is a generic controller class that can be used to handle a subarea. It is modelled after
UIViewController, but conforms to Apple's recommendation.

Your view controller creates the instances and is responsible for managing the subview controllers.
Alternatively you can further subdivided your view hierachy and create subview controllers inside
other subview controllers. In both cases the controller instantiating the object is responsible for
managing the subview controller. The responsible controller is referred to as 'parent controller.' 
Subclasses can use the view controller when they for example need to show a modal dialog.

Methods that the parent controller should call at the apropriate times are:

    - (void)viewWillAppear:(BOOL)animated;
    - (void)viewDidAppear:(BOOL)animated;
    - (void)viewWillDisappear:(BOOL)animated;
    - (void)viewDidDisappear:(BOOL)animated;

    - (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
    - (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration;
    - (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation;
    - (void)willAnimateFirstHalfOfRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
    - (void)didAnimateFirstHalfOfRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation;
    - (void)willAnimateSecondHalfOfRotationFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation duration:(NSTimeInterval)duration;

    - (void)didReceiveMemoryWarning;

Subclasses should always call `[super didReceiveMemoryWarning]`. This is recommended for all other 
methods listed above as well.

The loading of the view is similar to how UIViewController loads it views. You can either use the 
nib based loading, or load the view in `-loadView`. Do not call `[super loadView]` in your subclass!


LICENSE
-------
Copyright 2011 Koolistov. All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are 
permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this list of 
  conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this list 
  of conditions and the following disclaimer in the documentation and/or other materials 
  provided with the distribution.
* Neither the name of KOOLISTOV nor the names of its contributors may be used to 
  endorse or promote products derived from this software without specific prior written 
  permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY 
EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL 
THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT 
OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, 
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

AUTHOR
------
Johan Kool is an developer of iOS and Mac OS X (Cocoa and Cocoa touch) software. If you wish to hire me, please look at [www.koolistov.net/services](http://www.koolistov.net/services/).

-- Thanks!

   Johan
