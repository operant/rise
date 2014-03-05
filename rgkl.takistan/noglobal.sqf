[] spawn {
                disableSerialization;
                _cntchat_nigger = 0;
                while {true} do
                {
                        _display_nigger1 = findDisplay 55;
                        _display_nigger2 = findDisplay 63;
                        if ((!isNull _display_nigger1) && (!isNull _display_nigger2)) then
                        {
                                _nigger1 = ctrlText ((findDisplay 55) displayCtrl 101);
                                _nigger2 = ctrlText ((findDisplay 63) displayCtrl 101);
                                _niggerchk1 = '\ca\ui\textures\mikrak.paa';
                                _niggerchk2 = 'Command channel';
                                _niggerchk3 = 'Global channel';
                                if (_nigger1 == _niggerchk1) then
                                {
                                        if (((_nigger2 == _niggerchk2) or (_nigger2 == _niggerchk3) && not(isStaff))) then
                                        {
                                                _nigger = ('Warning! Voice chat is not allowed in Global or Command channels! You will be auto kicked!');
                                                cutText [format['%1',_nigger], 'PLAIN'];
                                                hint _nigger;
                                                _cntchat_nigger = _cntchat_nigger + 1;
                                                if (_cntchat_nigger > 3) then
                                                {
                                                        for '_r' from 0 to 99 do {(findDisplay _r) closeDisplay 0;};
                                                        (findDisplay 46) closeDisplay 0;endmission 'loser';
                                                        failMission "END1";
                                                };
                                        };
                                };
                        };
                        sleep 0.5;
                };
        };
