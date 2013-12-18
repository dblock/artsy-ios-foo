//
//  FOOMasterViewController.m
//  Foo
//
//  Created by Daniel Doubrovkine on 12/18/13.
//  Copyright (c) 2013 Artsy. All rights reserved.
//

#import "FOOMasterViewController.h"
#import "FOODetailViewController.h"
#import "FOOShow.h"

@implementation FOOMasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }

    FOOShow *show = self.shows[indexPath.row];
    cell.textLabel.text = show.name;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        FOOShow *show = self.shows[indexPath.row];
        [[segue destinationViewController] setDetailItem:show];
    }
}

@end
