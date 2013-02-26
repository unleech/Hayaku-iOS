
@interface SaveFile : NSObject <NSCoding>
{
    float   totalTimePlayed;
    int     totalCakes;
    int     totalCoins;
    int     remainingCakes;
    int     remainingCoins;
    int     spentCakes;
    int     spentCoins;
    int     highestCombo;
    
    NSMutableDictionary *listCostumes;
    NSMutableDictionary *listStages;
    NSMutableDictionary *listCharacters;
}

@property float totalTimePlayed;
@property int totalCakes;
@property int totalCoins;
@property int remainingCakes;
@property int remainingCoins;
@property int spentCakes;
@property int spentCoins;

@property int highestCombo;

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
