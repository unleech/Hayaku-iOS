
#import <UIKit/UIKit.h>

@interface SaveFile : NSObject <NSCoding>

@property    float   totalTimePlayed;
@property    int     totalCakes;
@property    int     totalCoins;
@property    int     remainingCakes;
@property    int     remainingCoins;
@property    int     spentCakes;
@property    int     spentCoins;

@property (nonatomic, strong) NSMutableDictionary *listCostumes;
@property (nonatomic, strong) NSMutableDictionary *listStages;
@property (nonatomic, strong) NSMutableDictionary *listCharacters;

/**
 * create a singleton of SaveFile
 */
+(SaveFile*)sharedFile;

/**
 * Save and Load all the necessary data into the saved file (washer.sav file)
 * file is encrypted
 * saved in the documents directory of the app
 */
+(void) loadData;
+(void) saveData;

@end
