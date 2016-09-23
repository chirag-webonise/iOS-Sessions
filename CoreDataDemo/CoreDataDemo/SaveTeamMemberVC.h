#import <UIKit/UIKit.h>

@interface SaveTeamMemberVC : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textFieldName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldTechnology;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;

- (IBAction)saveTeamMemberInfo:(UIButton *)sender;


@end

