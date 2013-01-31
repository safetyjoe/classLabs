//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Joey Smith on 1/28/13.
//  Copyright (c) 2013 Joey Smith. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

/// Auto generated space for private properties
@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) PlayingCardDeck *theDeck;
@property (strong, nonatomic) PlayingCard *aCard;
@end

@implementation CardGameViewController

/// Perform lazy instantiation by creating theDeck when the getter
/// for theDeck is called the first time.
- (PlayingCardDeck *) theDeck {
    if (!_theDeck) _theDeck = [[PlayingCardDeck alloc] init];
    return _theDeck;
}

/// Define setter for flipCount
- (void) setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

/// Action defined when a button is pressed and released.
- (IBAction)flipCard:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    if (sender.isSelected) {
        self.aCard = (PlayingCard*)self.theDeck.drawRandomCard;
        if (self.aCard != nil) {
            // Use the PlayingCard description
            [sender setTitle:[NSString stringWithFormat:@"%@", self.aCard] forState:UIControlStateSelected];
        } else {
            [sender setTitle:[NSString stringWithFormat:@"MT"] forState:UIControlStateSelected];
        }
        self.flipCount++;
    }
}

@end
