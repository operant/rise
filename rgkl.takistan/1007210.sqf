ISSE_arr_update = {
    private["_arr", "_key", "_val", "_upd", "_i"];
    _arr = _this select 0;
    _key = _this select 1;
    _val = _this select 2;
    _upd = false;
    for [{_i=0}, {_i < (count _arr)}, {_i=_i+1}] do {
        if ( ((_arr select _i) select 0) == _key ) exitWith {
            (_arr select _i) SET [1, _val];
            _upd = true;
            
        };
    };
    if (!_upd) then {
        _arr = _arr + [ [_key, _val] ];
        
    };
    _arr
};

ISSE_arr_length = {
    (count _this)
};

ISSE_arr_keys = {
    private["_result", "_i"];
    _result = [];
    for [{_i=0}, {_i < (count _this)}, {_i=_i+1}] do {
        _result = _result + [ ((_this select _i) select 0)];
    };
    _result
};

ISSE_arr_values = {
    private["_result", "_i"];
    _result = [];
    for [{_i=0}, {_i < (count _this)}, {_i=_i+1}] do {
        _result = _result + [ ((_this select _i) select 1)];
    };
    _result
};

ISSE_arr_hasKey = {
    (  (_this select 1) in ((_this select 0) call ISSE_arr_keys)  )
};

ISSE_arr_delete = {
    private["_arr", "_key", "_del", "_i"];
    _arr = _this select 0;
    _key = _this select 1;
    for [{_i=0}, {_i <(count _arr)}, {_i=_i+1}] do {
        if ( ((_arr select _i) select 0) == _key ) exitWith {
            _arr SET [_i, ""];
            _arr = _arr - [""];
        };   
    };
    _arr
};

ISSE_arr_equals = {
    (  (format["%1", _this select 0]) == (format["%1", _this select 1])  )
};

ISSE_arr_getValue = {
    private ["_c", "_arr", "_key"];
    _arr = _this select 0;
    _key = _this select 1;
    for [{_c=0}, {_c < (count _arr)}, {_c=_c+1}] do {
        if (((_arr select _c) select 0) == _key) exitWith {
            ((_arr select _c) select 1)
        };
    };
};

ISSE_arr_countMultiple = {
    private ["_c", "_Farr", "_Fval", "_Fcount"];
    _Farr   = _this select 0;
    _Fval   = _this select 1;
    _Fcount = 0;
    for [{_c=0}, { _c < (count _Farr)}, {_c=_c+1}] do {
        if ( (typeName (_Farr select _c)) == (typeName _Fval) ) then {
            if ((_Farr select _c) == _Fval) then {
                _Fcount = _Fcount + 1;
                
            };
        };
    };
    _Fcount
};

