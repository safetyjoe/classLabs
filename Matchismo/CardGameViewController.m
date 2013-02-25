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
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIButton *dealButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSelector;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@end

@implementation CardGameViewController

- (void)viewDidLoad {
    self.modeSelector.enabled = YES;
    [self updateUI];
}

// Lazy instantiation for the game.
- (CardMatchingGame *) game {
    // Allocate the deck of cards on the fly, we no longer need theDeck object.
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                         usingDeck:[[PlayingCardDeck alloc] init]];
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons {
    UIImage *cardBackImage = [UIImage imageNamed:@"IMG_0607.jpg"];
    UIImage *blankImage = [[UIImage alloc] init];
    _cardButtons = cardButtons;
    for(UIButton *cardButton in _cardButtons) {
        [cardButton setImage:cardBackImage forState:UIControlStateNormal];
        [cardButton setImage:blankImage forState:UIControlStateSelected];
        [cardButton setImage:blankImage forState:UIControlStateSelected|UIControlStateDisabled];
        [cardButton setImageEdgeInsets:UIEdgeInsetsMake(6.0, 6.0, 6.0, 6.0)];
    }
    [self updateUI];
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
    // The game controls the content of the string.  The controller owns the label.
    self.resultLabel.text = self.game.resultString;
    // The controller keeps a value for match level that will not change from
    // game to game unless the user changes it.
    self.game.matchLevel = self.modeSelector.selectedSegmentIndex + 1;
}

// Define setter for flipCount
- (void) setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

// Action defined when a button is pressed and released.
// We will no longer flip the card ourselves, we will let the cardMatchingGame do it.
- (IBAction)flipCard:(UIButton *)sender {
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    self.historySlider.maximumValue = [self.game.historyList count];
    self.historySlider.value = self.historySlider.maximumValue;
    self.modeSelector.enabled = NO;
    self.resultLabel.alpha = 1.0;
    [self updateUI];
}

// Action defined when the deal button is pressed and released.
- (IBAction)newGame:(UIButton *)sender {
    self.game = nil;
    self.flipCount = 0;
    self.modeSelector.enabled = YES;
    self.historySlider.value = 0;
    [self updateUI];
    NSLog(@"Deal button pressed");
}

// Action when the slider changes value;
- (IBAction)reviewHistory:(id)sender {
    self.resultLabel.alpha = 0.6;
    int play = (int)self.historySlider.value;
    if(play) {
        self.game.resultString =
            [NSString stringWithFormat:@"History: Card at flip number %d - %@",play,[self.game.historyList[play-1] contents]];
    }
    [self updateUI];
    NSLog(@"History Value = %d", (int)self.historySlider.value);
}


@end
