//
//  ViewController.m
//  Checkmark
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *selectedCells;
@property (nonatomic, strong) NSMutableArray *selecedStates;

@property (nonatomic, strong) NSArray *states;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)selectAll:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.selectedCells = [NSMutableArray array];
    self.selecedStates = [NSMutableArray array];
    self.states = [NSArray arrayWithObjects:@"Alabama", @"Alaska", @"Arizona",
                               @"Arkansas", @"California", @"Colorado", @"Connecticut", @"Delaware", @"District of Columbia",
                               @"Florida", @"Georgia", @"Hawaii", @"Idaho", @"Illinois", @"Indiana", @"Iowa", @"Kansas",
                               @"Kentucky", @"Louisiana", @"Maine", @"Maryland", @"Massachusetts", @"Michigan", @"Minnesota",
                               @"Mississippi", @"Missouri", @"Montana", @"Nebraska", @"Nevada", @"New Hampshire",
                               @"New Jersey", @"New Mexico", @"New York", @"North Carolina", @"North Dakota", @"Ohio",     @"Oklahoma",
                               @"Oregon", @"Pennsylvania", @"Rhode Island", @"South Carolina", @"South Dakota",
                               @"Tennessee", @"Texas", @"Utah", @"Vermont", @"Virginia", @"Washington", @"West Virginia", 
                               @"Wisconsin", @"Wyoming", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.states count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *unifiedID = @"aCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:unifiedID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:unifiedID];
    }
    
    cell.textLabel.text = [self.states objectAtIndex:indexPath.row];
    
    //if the indexPath was found among the selected ones, set the checkmark on the cell
    cell.accessoryType = ([self isRowSelectedOnTableView:tableView atIndexPath:indexPath]) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
    
}

//if a row gets selected, toggle checkmark
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *state = [self.states objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if([self isRowSelectedOnTableView:tableView atIndexPath:indexPath]){
        [self.selectedCells removeObject:indexPath];
        [self.selecedStates removeObject:state];
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        [self.selectedCells addObject:indexPath];
        [self.selecedStates addObject:state];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    NSLog(@"%@", self.selecedStates);
}

-(BOOL)isRowSelectedOnTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    return ([self.selectedCells containsObject:indexPath]) ? YES : NO;
}

- (IBAction)selectAll:(id)sender {
    NSUInteger numberOfSections = [self.tableView numberOfSections];
    for (NSUInteger s = 0; s < numberOfSections; ++s) {
        NSUInteger numberOfRowsInSection = [self.tableView numberOfRowsInSection:s];
        for (NSUInteger r = 0; r < numberOfRowsInSection; ++r) {
            NSIndexPath *idxPath = [NSIndexPath indexPathForRow:r inSection:s];
            [self.selectedCells addObject:idxPath];
            [self.selecedStates addObject:self.states[idxPath.row]];
        }
    }
    [self.tableView reloadData];
}
@end
