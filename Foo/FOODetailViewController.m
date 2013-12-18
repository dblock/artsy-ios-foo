//
//  FOODetailViewController.m
//  Foo
//
//  Created by Daniel Doubrovkine on 12/18/13.
//  Copyright (c) 2013 Artsy. All rights reserved.
//

#import "FOODetailViewController.h"

@interface FOODetailViewController ()
- (void)configureView;
@end

@implementation FOODetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem name];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self adjustColor];
    [self createDetailLabel];
    [self configureView];
}

- (void) adjustColor
{
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void) createDetailLabel
{
    UILabel * label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.textAlignment = NSTextAlignmentCenter;
    self.detailDescriptionLabel = label;
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
