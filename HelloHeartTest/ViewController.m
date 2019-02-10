//
//  ViewController.m
//  HelloHeartTest
//
//  Created by Sebastian Natalevich on 13/7/17.
//  Copyright © 2017 Sebastian Natalevich. All rights reserved.
//

#import "ViewController.h"
#import "CategorizeTest.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchTapped:(id)sender {
    
    self.categoryLabel.text = [CategorizeTest categoriesNameForTestName:self.searchTextField.text];
    
}

@end
