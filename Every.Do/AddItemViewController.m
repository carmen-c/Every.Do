//
//  AddItemViewController.m
//  Every.Do
//
//  Created by carmen cheng on 2016-11-15.
//  Copyright © 2016 carmen cheng. All rights reserved.
//

#import "AddItemViewController.h"
#import "Todo.h"

@interface AddItemViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *priorityTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;

@property (weak, nonatomic) IBOutlet UIButton *done;

@property (nonatomic) Todo *todo;
@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.todo = [[Todo alloc]init];

    self.titleTextField.delegate = self;
    self.priorityTextField.delegate = self;
    self.descriptionTextField.delegate = self;
    
    self.titleTextField.tag = 1;
    self.priorityTextField.tag = 2;
    self.descriptionTextField.tag = 3;
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 1) {
        self.titleTextField.text = textField.text;
    }else if (textField.tag == 2) {
        self.priorityTextField.text = textField.text;
    }else if (textField.tag == 3) {
        self.descriptionTextField.text = textField.text;
    }
}


#pragma mark - Buttons

- (IBAction)doneButtonPressed:(id)sender {
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:self.todo, @"textInput", nil];

    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    NSNotification *notify = [[NSNotification alloc]initWithName:@"textInputted" object:sender userInfo:dictionary];
    
    [notificationCenter postNotification:notify];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
