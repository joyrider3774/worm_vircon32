#ifndef SAVEDATA_H
#define SAVEDATA_H

#include "Worm.h"
#include "memcard.h"

struct SaveData {
	int highScore_a;
	int highScore_b;
	int highScore_c;
};

game_signature GameSignature;

SaveData save;

void LoadSavedData()
{
	save.highScore_a = 0;
	save.highScore_b = 0;
	save.highScore_c = 0;
	if(card_is_connected())
		if(card_signature_matches( &GameSignature ))
		{
			 card_read_data( &save, sizeof(game_signature), sizeof(save) );
		}
}

void SaveSavedData()
{
	if(card_is_connected())
		if(card_is_empty() || card_signature_matches( &GameSignature ))
		{			
			card_write_signature( &GameSignature );
    		card_write_data( &save, sizeof(game_signature), sizeof(save) );
		}
}

#endif