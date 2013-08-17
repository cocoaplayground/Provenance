//
//  PVGameListViewController.m
//  Provenance
//
//  Created by James Addyman on 15/08/2013.
//  Copyright (c) 2013 James Addyman. All rights reserved.
//

#import "PVGameListViewController.h"
#import "PVEmulatorViewController.h"

@interface PVGameListViewController ()

@property (nonatomic, strong) NSArray *games;

@end

@implementation PVGameListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
	if ((self = [super initWithStyle:style]))
	{
		[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
	}
	
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.title = @"Games";
	
	NSString *bundlePath = [[NSBundle mainBundle] resourcePath];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	NSMutableArray *tempGames = [NSMutableArray array];
	
	NSArray *bundleContents = [fileManager contentsOfDirectoryAtPath:bundlePath error:NULL];
	for (NSString *filePath in bundleContents)
	{
		if ([filePath hasSuffix:@".smd"])
		{
			[tempGames addObject:[bundlePath stringByAppendingPathComponent:filePath]];
		}
	}
	
	self.games = [tempGames copy];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.games count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
	
	NSString *path = [self.games objectAtIndex:[indexPath row]];
	
	[[cell textLabel] setText:[path lastPathComponent]];
	
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *path = [self.games objectAtIndex:[indexPath row]];
	
	PVEmulatorViewController *emulatorViewController = [[PVEmulatorViewController alloc] initWithROMPath:path];
//	[self.navigationController pushViewController:emulatorViewController animated:YES];
	[self presentViewController:emulatorViewController animated:YES completion:NULL];
}

@end