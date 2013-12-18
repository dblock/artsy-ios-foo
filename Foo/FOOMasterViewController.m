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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FOOShow *show = self.shows[indexPath.row];
    NSLog(@"Detail show: %@.", show.name);
    FOODetailViewController *controller = [[FOODetailViewController alloc] init];
    controller.detailItem = show;
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)setShows:(NSArray *)shows
{
    _shows = shows;
    [self.tableView reloadData];
}

@end
