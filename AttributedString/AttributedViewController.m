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

- (NSString*) selectedWord
{
	return self.wordList[(NSUInteger)self.selectedWorkStepper.value];
}

- (void) updateSelectedWordLabel
{
	self.selectedWordLabel.text = [self selectedWord];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	[self updateSelectedWorkStepper];
	[self updateSelectedWordLabel];
}

- (void) addAttributeForSelectedWord: (NSString*) attribute value: (id)value
{
	NSRange range = [[self.label.attributedText string] rangeOfString: [self selectedWord]];
	
	NSMutableAttributedString* as = self.label.attributedText.mutableCopy;
	
	[as addAttribute: attribute	value: value range: range];
	
	self.label.attributedText = as;
	
}

- (IBAction)selectedNewWord {
	[self updateSelectedWordLabel];
}

- (IBAction)updateFont:(UIButton *)sender {
	UIFont* newFont = [sender.titleLabel.font fontWithSize: self.label.font.pointSize];
	
	[self addAttributeForSelectedWord:NSFontAttributeName value: newFont];
}

@end
