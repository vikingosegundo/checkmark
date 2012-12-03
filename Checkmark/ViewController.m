//
//  ViewController.m
//  Checkmark
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *selectedCells;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.selectedCells = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *unifiedID = @"aCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:unifiedID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:unifiedID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%u", indexPath.row];
    
    //if the indexPath was found among the selected ones, set the checkmark on the cell
    cell.accessoryType = ([self isRowSelectedOnTableView:tableView atIndexPath:indexPath]) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
    
}

//if a cell gets selected, toggle checkmark
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if([self isRowSelectedOnTableView:tableView atIndexPath:indexPath]){
        [self.selectedCells removeObject:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        [self.selectedCells addObject:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

-(BOOL)isRowSelectedOnTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    return ([self.selectedCells containsObject:indexPath]) ? YES : NO;
}

@end
