//
//  BBViewController.m
//  BBForm
//
//  Created by Ash Thwaites on 11/03/2015.
//  Copyright (c) 2015 Ash Thwaites. All rights reserved.
//

#import "BBViewController.h"
#import "BBFormViewController.h"

@interface BBViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *prePopulatedSwitch;

@end

@implementation BBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[BBFormViewController class]])
    {
        BBFormViewController *bfvc = (BBFormViewController*)segue.destinationViewController;
        bfvc.prePopulate = _prePopulatedSwitch.on;
    }
}


@end
