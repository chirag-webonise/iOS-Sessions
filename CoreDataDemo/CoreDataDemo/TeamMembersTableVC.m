#import <CoreData/CoreData.h>
#import "TeamMembersTableVC.h"
#import "Constant.h"

@interface TeamMembersTableVC ()

@end

@implementation TeamMembersTableVC

NSString *reuseIdentifier = @"TeamMemberCell";

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];

		// Fetch all the team members from persistent data store
	NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:ENTITY_TEAM_MEMBER];
	self.teamMembers = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];

	[self.tableView reloadData];
}

/**
 *  Get managedObjectContext from the AppDelegate.
 *
 *  @return NSManagedObjectContext object
 */
- (NSManagedObjectContext *)managedObjectContext
{
	NSManagedObjectContext *context = nil;
	id delegate = [[UIApplication sharedApplication] delegate];
	if ([delegate performSelector:@selector(managedObjectContext)]) {
		context = [delegate managedObjectContext];
	}
	return context;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.teamMembers.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];

	NSManagedObject *teamMemberDetail = [self.teamMembers objectAtIndex:indexPath.row];
	[cell.textLabel setText:[teamMemberDetail valueForKey:ATTRIBUTE_NAME]];
	[cell.detailTextLabel setText:[teamMemberDetail valueForKey:ATTRIBUTE_TECHNOLOGY]];

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSManagedObjectContext *context = [self managedObjectContext];

	if (editingStyle == UITableViewCellEditingStyleDelete) {
			// Delete team member from database
		[context deleteObject:[self.teamMembers objectAtIndex:indexPath.row]];

		NSError *error = nil;
		if (![context save:&error]) {
			NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
			return;
		}

			// Remove team member from the list
		[self.teamMembers removeObjectAtIndex:indexPath.row];
		[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}
}

@end
