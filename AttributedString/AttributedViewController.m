//
//  AttributedViewController.m
//  AttributedString
//
//  Created by Vladimir on 03.04.13.
//  Copyright (c) 2013 Vladimir. All rights reserved.
//

#import "AttributedViewController.h"

@interface AttributedViewController ()
@property (strong, nonatomic) NSArray* wordList;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIStepper *selectedWorkStepper;
@property (weak, nonatomic) IBOutlet UILabel *selectedWordLabel;

@end

@implementation AttributedViewController

- (NSArray*) wordList
{
	if (!_wordList) {
		_wordList = [self pickWordListFromLabel];
	}
	return _wordList;
}

- (NSArray*) pickWordListFromLabel
{
	NSArray* list = [[self.label.attributedText string] componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	return [list count]?list:@[@""];
}

- (void) updateSelectedWorkStepper
{
	self.selectedWorkStepper.maximumValue = [self.wordList count] - 1;
}

- (void) updateSelectedWordLabel
{
	self.selectedWordLabel.text = self.wordList[(NSUInteger)self.selectedWorkStepper.value];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self updateSelectedWorkStepper];
	[self updateSelectedWordLabel];
}

- (IBAction)selectedNewWord {
	[self updateSelectedWordLabel];
}

@end
