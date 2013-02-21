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
#import "CardMatchingGame.h"

/// Auto generated space for private properties
@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
//@property (strong, nonatomic) Deck *theDeck;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation CardGameViewController

// Perform lazy instantiation by creating theDeck when the getter
// for theDeck is called the first time.
//- (Deck *) theDeck {
//    if (!_theDeck) _theDeck = [[PlayingCardDeck alloc] init];
//    return _theDeck;
//}

// LI for the game.
- (CardMatchingGame *) game {
    /// Allocate the deck wof cards on the fly, we no longer need theDeck object.
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                         usingDeck:[[PlayingCardDeck alloc] init]];
;
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
    
    /*
     for (UIButton *cardButton in cardButtons) {
     Card *card = [self.theDeck drawRandomCard];
     [cardButton setTitle:card.contents forState:UIControlStateSelected];
     */
}

- (void) updateUI{
    for(UIButton *cardButton in self.cardButtons) {
        // Use the model "game" to update the UI.
        Card *card = [self.game cardatIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        
        cardButton.selected = card.isFaceUp;
        // Make the disabled or un-tappable if the card is unplayable.
        cardButton.enabled = !card.isUnplayable;
        // Make the card semi-transparent when it is taken out of the game. 
        cardButton.alpha = card.unPlayable ? 0.3 : 1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

// Define setter for flipCount
- (void) setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

// Action defined when a button is pressed and released.
// We will no longer flip the card ourselves, we will let the cardMatchingGame do it.
- (IBAction)flipCard:(UIButton *)sender {
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

@end
