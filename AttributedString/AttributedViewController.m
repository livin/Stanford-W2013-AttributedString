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

- (NSRange)selectedWordRange
{
    return [[self.label.attributedText string] rangeOfString: [self selectedWord]];
}

- (void) addAttributeForSelectedWord: (NSString*) attribute value: (id)value
{
	NSMutableAttributedString* as = self.label.attributedText.mutableCopy;
	[as addAttribute: attribute	value: value range: [self selectedWordRange]];
	self.label.attributedText = as;	
}

- (void) addAttributesForSelectedWord: (NSDictionary*) attributes
{
	NSMutableAttributedString* as = self.label.attributedText.mutableCopy;
	[as addAttributes: attributes range: [self selectedWordRange]];
	self.label.attributedText = as;
}


- (IBAction)selectedNewWord {
	[self updateSelectedWordLabel];
}

- (IBAction)updateFont:(UIButton *)sender {
	NSDictionary* attrs = [self.label.attributedText attributesAtIndex: 0 effectiveRange: NULL];
	UIFont* existingFont = attrs[NSFontAttributeName];
	
	UIFont* newFont = [sender.titleLabel.font fontWithSize: existingFont.pointSize];
	
	[self addAttributeForSelectedWord:NSFontAttributeName value: newFont];
}

- (IBAction)updateFontColor:(UIButton *)sender {
	[self addAttributeForSelectedWord: NSForegroundColorAttributeName value: sender.backgroundColor];
}

- (IBAction)underline:(UIButton *)sender {
	[self addAttributeForSelectedWord: NSUnderlineStyleAttributeName value: @(NSUnderlineStyleSingle)];
}

- (IBAction)ununderline:(UIButton *)sender {
	[self addAttributeForSelectedWord: NSUnderlineStyleAttributeName value: @(NSUnderlineStyleNone)];
}

- (IBAction)outline:(UIButton *)sender {
	[self addAttributesForSelectedWord: @{NSStrokeWidthAttributeName : @(-5), NSStrokeColorAttributeName: [UIColor redColor]}];
}

- (IBAction)unoutline:(UIButton *)sender {
	[self addAttributeForSelectedWord: NSStrokeWidthAttributeName value: @(0)];
}



@end
