#import <CoreData/CoreData.h>
#import "SaveTeamMemberVC.h"
#import "Constant.h"

@interface SaveTeamMemberVC ()

@end

@implementation SaveTeamMemberVC

- (void)viewDidLoad {
	[super viewDidLoad];
		// Do any additional setup after loading the view, typically from a nib.
}

/**
 *  Get managedObjectContext from the AppDelegate.
 *
 *  @return NSManagedObjectContext object
 */
- (NSManagedObjectContext *)managedObjectContext {
	NSManagedObjectContext *context = nil;
	id delegate = [[UIApplication sharedApplication] delegate];
	if ([delegate performSelector:@selector(managedObjectContext)]) {
		context = [delegate managedObjectContext];
	}
	return context;
}

/**
 *  To save entered data and go back to the list.
 *
 *  @param sender Button object.
 */
- (IBAction)saveTeamMemberInfo:(UIButton *)sender {

	NSManagedObjectContext *context = [self managedObjectContext];

		// Create a new managed object
	NSManagedObject *newTeamMember = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_TEAM_MEMBER
																   inManagedObjectContext:context];
		// Setting values to the created managed object.
	[newTeamMember setValue:self.textFieldName.text forKey:ATTRIBUTE_NAME];
	[newTeamMember setValue:self.textFieldTechnology.text forKey:ATTRIBUTE_TECHNOLOGY];
	[newTeamMember setValue:self.textFieldEmail.text forKey:ATTRIBUTE_EMAIL];

	NSError *error = nil;
		// Save the object to persistent store
	if (![context save:&error]) {
		NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
	}

		// Pop view controller to get back to the list screen
	[[self navigationController] popViewControllerAnimated:true];
}

@end
